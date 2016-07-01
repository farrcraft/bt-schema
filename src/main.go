package main

import (
	"github.com/codegangsta/cli"
	"os"
)

func CreateTool(c *cli.Context) *SchemaTool {
	configPath := c.String("config")
	logLevel := c.String("level")
	logPath := c.String("log")

	tool := NewSchemaTool(configPath, logLevel, logPath)
	return tool
}

func InstallSchema(c *cli.Context) error {
	tool := CreateTool(c)
	tool.Install()
	tool.Shutdown()
	return nil
}

func UpdateSchema(c *cli.Context) error {
	tool := CreateTool(c)
	tool.Update()
	tool.Shutdown()
	return nil
}

func DeleteSchema(c *cli.Context) error {
	tool := CreateTool(c)
	tool.Delete()
	tool.Shutdown()
	return nil
}

func CreateSchema(c *cli.Context) error {
	tool := CreateTool(c)
	tool.Create()
	tool.Shutdown()
	return nil
}

func SchemaVersion(c *cli.Context) error {
	tool := CreateTool(c)
	tool.Version()
	tool.Shutdown()
	return nil
}

func main() {
	app := cli.NewApp()
	app.Name = "bt-schema"
	app.Usage = "Manage the BrewTheory DB schema"
	flags := []cli.Flag{
		cli.StringFlag{
			Name:   "config",
			Usage:  "path to the config file",
			EnvVar: "BREWTHEORY_SCHEMA_CONFIG",
		},
		cli.StringFlag{
			Name:   "level",
			Usage:  "Log level",
			EnvVar: "BREWTHEORY_SCHEMA_LOG_LEVEL",
		},
		cli.StringFlag{
			Name:   "log, l",
			Usage:  "Log file",
			EnvVar: "BREWTHEORY_SCHEMA_LOG_FILE",
		},
	}
	app.Commands = []cli.Command{
		{
			Name:    "create",
			Aliases: []string{"c"},
			Usage:   "Create database",
			Action:  CreateSchema,
			Flags:   flags,
		},
		{
			Name:    "install",
			Aliases: []string{"i"},
			Usage:   "Install base schema",
			Action:  InstallSchema,
			Flags:   flags,
		},
		{
			Name:    "update",
			Aliases: []string{"u"},
			Usage:   "Update schema",
			Action:  UpdateSchema,
			Flags:   flags,
		},
		{
			Name:    "destroy",
			Aliases: []string{"d"},
			Usage:   "Delete schema",
			Action:  DeleteSchema,
			Flags:   flags,
		},
		{
			Name:    "version",
			Aliases: []string{"v"},
			Usage:   "Display schema version",
			Action:  SchemaVersion,
			Flags:   flags,
		},
	}
	app.Run(os.Args)
}
