package main

import (
	"./config"
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"io/ioutil"
	"os"
)

func (tool *SchemaTool) Install() {
	appConfig := config.GetConfig()
	fmt.Println("Looking for table definitions...")
	for _, table := range appConfig.Tables.Tables {
		for _, dependency := range table.Dependencies {
			LoadDependency(dependency, appConfig.SchemaRoot, appConfig.Tables.Tables, tool.Db)
		}
		CreateTable(table, appConfig.SchemaRoot, appConfig.Tables.Tables, tool.Db)
		table.Loaded = true
	}

	for _, data := range appConfig.Data.Data {
		LoadTableData(data, appConfig.DataRoot, tool.Db)
	}
}

func CreateTable(table *config.TableDefinition, root string, tables []*config.TableDefinition, db *sql.DB) {
	for _, dependency := range table.Dependencies {
		LoadDependency(dependency, root, tables, db)
	}

	if table.Loaded == true {
		return
	}

	fmt.Println("Loading table definition: ", table.Name)
	tablePath := fmt.Sprint(root, "/", table.Name, ".sql")
	tableInfo, err := ioutil.ReadFile(tablePath)
	if err != nil {
		fmt.Println("Error reading table definition: ", err)
		os.Exit(1)
	}
	_, err = db.Exec(string(tableInfo))
	if err != nil {
		fmt.Println("Error running table query for ", table.Name, " - ", err)
		os.Exit(1)
	}
}

func LoadDependency(dependency string, root string, tables []*config.TableDefinition, db *sql.DB) {
	for _, table := range tables {
		if table.Name == dependency {
			if table.Loaded == true {
				return
			}
			CreateTable(table, root, tables, db)
			table.Loaded = true
			return
		}
	}
}

func LoadTableData(data *config.TableDataDefinition, root string, db *sql.DB) {
	fmt.Println("Loading table data: ", data.Name)
	tablePath := fmt.Sprint(root, "/", data.Name, ".sql")
	tableInfo, err := ioutil.ReadFile(tablePath)
	if err != nil {
		fmt.Println("Error reading table data: ", err)
		os.Exit(1)
	}
	_, err = db.Exec(string(tableInfo))
	if err != nil {
		fmt.Println("Error running table query for ", data.Name, " - ", err)
		os.Exit(1)
	}
}
