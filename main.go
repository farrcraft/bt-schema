package main

import (
	"github.com/Sirupsen/logrus"
	"github.com/codegangsta/cli"
	"os"
)

var log = logrus.New()

func main() {
	app := cli.NewApp()
	app.Name = "bt-schema"
	app.Usage = "Manage the BrewTheory DB schema"
	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:   "config, c",
			Usage:  "agent configuration file",
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
			Name:    "install",
			Aliases: []string{"i"},
			Usage:   "install base schema",
			Action: func(c *cli.Context) {
				schema := NewSchema(c)
				schema.Install()
				schema.Shutdown()
			},
		},
		{
			Name:"create",
			Aliases: []string{"c"},
			Usage: "create user and database",
			Action: func(c *cli.Context) {
				schema := NewSchema(c)
				schema.Create()
				schema.Shutdown()
			},
		},
		{
			Name:"update",
			Aliases: []string{"u"},
			Usage: "update database",
			Action: func(c *cli.Context) {
				schema := NewSchema(c)
				schema.Update()
				schema.Shutdown()
			},
		},
	}
	app.Run(os.Args)
}
