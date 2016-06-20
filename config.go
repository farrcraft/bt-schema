package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"path/filepath"
	"sync"
	"os"
)

type TableDefinition struct {
	Name         string   `json:"name"`
	System       bool     `json:"system"`
	Dependencies []string `json:"depends"`
}

type TableDataDefinition struct {
	Name         string   `json:"table"`
	Dependencies []string `json:"depends"`
}

type DataConfig struct {
	Data []TableDataDefinition `json:"data"`
}

type TablesConfig struct {
	Tables []TableDefinition `json:"tables"`
}

type SchemaConfig struct {
	Database   string `json:"db"`
	Host       string `json:"host"`
	User       string `json:"user"`
	Password   string `json:"password"`
	SchemaRoot string `json:"schema_root"`
}

type Config interface {
	loadConfig(jsonPath string)
}

type BaseConfig struct {
	LogLevel         string `json:"log_level"`
	LogFile          string `json:"log_file"`

	//// runtime-only configuration ////

	// remember path to the config file so we can reload it if necessary
	Path string
	// CLI or ENV setting may override config file setting
	ActiveLogLevel string
	ActiveLogFile  string
	// keep track of whether config settings have been overridden
	OverrideLogLevel bool
	OverrideLogFile  bool	
}

var (
	config     *Config
	configLock = new(sync.RWMutex)
)

func loadJson(jsonPath string) []byte {
	rawJson, err := ioutil.ReadFile(jsonPath)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	return rawJson
}

func (config SchemaConfig) loadConfig(jsonPath string) {
	rawJson := loadJson(jsonPath)
	json.Unmarshal(rawJson, &config)
}

func (config TablesConfig) loadConfig(jsonPath string) {
	rawJson := loadJson(jsonPath)
	json.Unmarshal(rawJson, &config)
}

func (config DataConfig) loadConfig(jsonPath string) {
	rawJson := loadJson(jsonPath)
	json.Unmarshal(rawJson, &config)
}

// GetConfig retrieves the global configuration
// our config object is global,
// but we must make sure to always access it via this method
func GetConfig() *Config {
	configLock.RLock()
	defer configLock.RUnlock()
	return config
}

// LoadConfig loads the configuration from disk
func LoadConfig(configPath string) error {
	if configPath == "" {
		configPath = config.Path
	} else {
		configPath, _ = filepath.Abs(configPath)
	}
	raw, err := ioutil.ReadFile(configPath)
	if err != nil {
		return err
	}
	newConfig := new(Config)
	if err = json.Unmarshal(raw, &newConfig); err != nil {
		return err
	}

	// remember where the file is
	newConfig.Path = configPath
	// start with the config values, but may be overridden elsewhere
	newConfig.ActiveLogLevel = newConfig.LogLevel
	if newConfig.LogFile != "STDOUT" && newConfig.LogFile != "STDERR" {
		newConfig.ActiveLogFile, _ = filepath.Abs(newConfig.LogFile)
	} else {
		newConfig.ActiveLogFile = newConfig.LogFile
	}
	newConfig.OverrideLogFile = false
	newConfig.OverrideLogLevel = false

	configLock.Lock()
	config = newConfig
	configLock.Unlock()

	return nil
}
