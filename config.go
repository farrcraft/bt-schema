package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
)

type TableDefinition struct {
	Name         string   `json:"name"`
	System       bool     `json:"system"`
	Dependencies []string `json:"depends"`
	Loaded       bool     `json:"-"`
}

type TableDataDefinition struct {
	Name         string   `json:"table"`
	Dependencies []string `json:"depends"`
}

type DataConfig struct {
	Data []*TableDataDefinition `json:"data"`
}

type TablesConfig struct {
	Tables []*TableDefinition `json:"tables"`
}

type SchemaConfig struct {
	Database   string `json:"db"`
	Host       string `json:"host"`
	User       string `json:"user"`
	Password   string `json:"password"`
	SchemaRoot string `json:"schema_root"`
	DataRoot   string `json:"data_root"`
}

type Config interface {
	loadConfig(jsonPath string)
}

func loadJson(jsonPath string) []byte {
	rawJson, err := ioutil.ReadFile(jsonPath)
	if err != nil {
		fmt.Println("Error reading config data: ", jsonPath, " - ", err.Error())
		os.Exit(1)
	}
	return rawJson
}

func (config *SchemaConfig) loadConfig(jsonPath string) {
	rawJson := loadJson(jsonPath)
	err := json.Unmarshal(rawJson, &config)
	if err != nil {
		fmt.Println("Error loading config: ", jsonPath, " - ", err)
	}
}

func (config *TablesConfig) loadConfig(jsonPath string) {
	rawJson := loadJson(jsonPath)
	err := json.Unmarshal(rawJson, &config)
	if err != nil {
		fmt.Println("Error loading config: ", jsonPath, " - ", err)
	}
}

func (config *DataConfig) loadConfig(jsonPath string) {
	rawJson := loadJson(jsonPath)
	err := json.Unmarshal(rawJson, &config)
	if err != nil {
		fmt.Println("Error loading config: ", jsonPath, " - ", err)
	}
}
