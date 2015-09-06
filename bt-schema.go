package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"github.com/codegangsta/cli"
	_ "github.com/go-sql-driver/mysql"
)

type TableDefinition struct {
	Name 			string 		`json:"name"`
	System 			bool 		`json:"system"`
	Dependencies	[]string 	`json:"depends"`
}

type TableDataDefinition struct {
	Name 			string 		`json:"table"`
	Dependencies	[]string	`json:"depends"`
}

type DataConfig struct {
	Data 	[]TableDataDefinition 	`json:"data"`
}

type TablesConfig struct {
	Tables 	[]TableDefinition 	`json:"tables"`
}

type SchemaConfig struct {
	Database 	string 	`json:"db"`
	Host 		string 	`json:"host"`
	User 		string 	`json:"user"`
	Password 	string 	`json:"password"`
	SchemaRoot 	string 	`json:"schema_root"`
}

type Config interface {
	loadConfig(jsonPath string)
}

func loadJson(jsonPath string) {
	rawJson, err := ioutil.ReadFile(jsonPath)
	if err != nill {
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
	rawJson := loadJson(tablesJsonPath)
	json.Unmarshal(rawJson, &config)
}

func (config DataConfig) loadConfig(jsonPath string) {
	rawJson := loadJson(jsonPath)
	json.Unmarshal(rawJson, &config)
}

func main() {
	app :=cli.NewApp()
	app.Name 	= "bt-schema"
	app.Usage 	= "Manage the BrewTheory DB schema"
	app.Commands = []cli.Command{
		{
			Name: 		"install",
			Aliases: 	[]string{"i"},
			Usage:		"install base schema",
			Action: func(c *cli.Context) {
			}
		}
	}
	app.Run(os.Args)
}
