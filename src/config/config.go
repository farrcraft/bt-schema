package config

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"sync"
)

type LogInfo struct {
	Level string
	File  string
}

type TableDefinition struct {
	Name         string   `json:"name"`
	System       bool     `json:"system"`
	Version      int      `json:"version"`
	Dependencies []string `json:"depends"`
	Loaded       bool     `json:"-"`
}

type TableDataDefinition struct {
	Name         string   `json:"table"`
	Version      int      `json:"version"`
	Dependencies []string `json:"depends"`
}

type DataConfig struct {
	Data []*TableDataDefinition `json:"data"`
}

type TablesConfig struct {
	Tables []*TableDefinition `json:"tables"`
}

type BaseConfig struct {
	Database   string `json:"db"`
	Host       string `json:"host"`
	User       string `json:"user"`
	Password   string `json:"password"`
	SchemaRoot string `json:"schema_root"`
	DataRoot   string `json:"data_root"`
	LogLevel   string `json:"log_level"`
	LogFile    string `json:"log_file"`

	//// Runtime Configuration ////

	Data    *DataConfig
	Tables  *TablesConfig
	Version int

	Path             string
	ActiveLog        LogInfo
	ReloadLog        chan LogInfo
	OverrideLogLevel bool
	OverrideLogFile  bool
	LogHandle        *os.File
}

var (
	config     *BaseConfig
	configLock = new(sync.RWMutex)
)

func GetConfig() *BaseConfig {
	configLock.RLock()
	defer configLock.RUnlock()
	return config
}

func GetUnsafeConfig() *BaseConfig {
	return config
}

func LockConfig() {
	configLock.Lock()
}

func UnlockConfig() {
	configLock.Unlock()
}

func LoadFileContent(path string) ([]byte, error) {
	content, err := ioutil.ReadFile(path)
	if err != nil {
		return content, err
	}
	return content, nil
}

func LoadConfig(configPath string) error {
	if configPath == "" {
		configPath = config.Path
	} else {
		configPath, _ = filepath.Abs(configPath)
	}
	content, err := LoadFileContent(configPath)
	if err != nil {
		return err
	}
	newConfig := &BaseConfig{}
	err = json.Unmarshal(content, &newConfig)
	if err != nil {
		return err
	}

	newConfig.Path = configPath
	newConfig.ActiveLog.Level = newConfig.LogLevel
	if newConfig.LogFile != "STDOUT" && newConfig.LogFile != "STDERR" {
		newConfig.ActiveLog.File, _ = filepath.Abs(newConfig.LogFile)
	} else {
		newConfig.ActiveLog.File = newConfig.LogFile
	}
	newConfig.OverrideLogFile = false
	newConfig.OverrideLogLevel = false

	dir := filepath.Dir(configPath)

	dataConfigPath := fmt.Sprint(dir, "/", "data.json")
	content, err = LoadFileContent(dataConfigPath)
	if err != nil {
		return err
	}
	newConfig.Data = &DataConfig{}
	err = json.Unmarshal(content, &newConfig.Data)
	if err != nil {
		return err
	}

	tablesConfigPath := fmt.Sprint(dir, "/", "tables.json")
	content, err = LoadFileContent(tablesConfigPath)
	if err != nil {
		return err
	}
	newConfig.Tables = &TablesConfig{}
	err = json.Unmarshal(content, &newConfig.Tables)
	if err != nil {
		return err
	}

	SetConfig(newConfig)

	return nil
}

func SetConfig(appConfig *BaseConfig) {
	configLock.Lock()
	config = appConfig
	configLock.Unlock()
}
