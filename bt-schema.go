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

type SchemaConfig struct {
	Database 	string 	`json:"db"`
	Host 		string 	`json:"host"`
	User 		string 	`json:"user"`
	Password 	string 	`json:"password"`
	SchemaRoot 	string 	`json:"schema_root"`
}

func loadSchemaConfig(schemaJsonPath string) {
	rawJson, err := ioutil.ReadFile(schemaJsonPath)
	if err != nill {
		fmt.Println(err.Error())
		os.Exit(1)
	}

	var config SchemaConfig
	json.Unmarshal(rawJson, &config)
	return config
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
