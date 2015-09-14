package main

import (
	"database/sql"
	"github.com/codegangsta/cli"
	_ "github.com/go-sql-driver/mysql"
	"os"
)

func main() {
	app := cli.NewApp()
	app.Name = "bt-schema"
	app.Usage = "Manage the BrewTheory DB schema"
	app.Commands = []cli.Command{
		{
			Name:    "install",
			Aliases: []string{"i"},
			Usage:   "install base schema",
			Action: func(c *cli.Context) {
			},
		},
	}
	app.Run(os.Args)
}
