package main

import (
	"os"
	"github.com/codegangsta/cli"
)

func main() {
	app :=cli.NewApp()
	app.Name = "bt-schema"
	app.Usage = "Manage the BrewTheory DB schema"
	app.Action = func(c *cli.Context) {
		println("doing stuff!")
	}
	app.Run(os.Args)
}
