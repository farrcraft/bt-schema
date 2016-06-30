package main

import (
	"database/sql"
	"fmt"
	"github.com/codegangsta/cli"
	_ "github.com/lib/pq"
	"io/ioutil"
	"os"
)

func CreateTable(table *TableDefinition, root string, tables []*TableDefinition, db *sql.DB) {
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

func LoadDependency(dependency string, root string, tables []*TableDefinition, db *sql.DB) {
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

func LoadTableData(data *TableDataDefinition, root string, db *sql.DB) {
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

func InstallSchema(c *cli.Context) error {
	configPath := c.String("config")
	tablesConfigPath := c.String("tables")
	dataConfigPath := c.String("data")

	schemaConfig := &SchemaConfig{}
	tablesConfig := &TablesConfig{}
	dataConfig := &DataConfig{}

	schemaConfig.loadConfig(configPath)
	tablesConfig.loadConfig(tablesConfigPath)
	dataConfig.loadConfig(dataConfigPath)

	dbinfo := fmt.Sprintf("user=%s password=%s dbname=%s sslmode=disable",
		schemaConfig.User, schemaConfig.Password, schemaConfig.Database)
	db, err := sql.Open("postgres", dbinfo)
	if err != nil {
		fmt.Println("Error opening database: ", err)
		os.Exit(1)
	}
	defer db.Close()

	fmt.Println("Looking for table definitions...")
	for _, table := range tablesConfig.Tables {
		for _, dependency := range table.Dependencies {
			LoadDependency(dependency, schemaConfig.SchemaRoot, tablesConfig.Tables, db)
		}
		CreateTable(table, schemaConfig.SchemaRoot, tablesConfig.Tables, db)
		table.Loaded = true
	}

	for _, data := range dataConfig.Data {
		LoadTableData(data, schemaConfig.DataRoot, db)
	}

	return nil
}

func main() {
	app := cli.NewApp()
	app.Name = "bt-schema"
	app.Usage = "Manage the BrewTheory DB schema"
	flags := []cli.Flag{
		cli.StringFlag{
			Name:  "config",
			Usage: "path to the config file",
		},
		cli.StringFlag{
			Name:  "tables",
			Usage: "path to the tables config file",
		},
		cli.StringFlag{
			Name:  "data",
			Usage: "path to the data config file",
		},
	}
	app.Commands = []cli.Command{
		{
			Name:    "install",
			Aliases: []string{"i"},
			Usage:   "install base schema",
			Action:  InstallSchema,
			Flags:   flags,
		},
	}
	app.Run(os.Args)
}
