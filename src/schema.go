package main

import (
	"./config"
	logger "./log"
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"os"
)

type SchemaTool struct {
	Db     *sql.DB
	Logger *logger.Log
}

func NewSchemaTool(configPath string, logLevel string, logPath string) *SchemaTool {
	if configPath == "" {
		fmt.Println("Missing config")
		os.Exit(1)
	}

	err := config.LoadConfig(configPath)
	if err != nil {
		fmt.Println("Error loading config: ", err)
		os.Exit(1)
	}

	log := logger.NewLog(logLevel, logPath)
	tool := &SchemaTool{
		Logger: log,
	}

	appConfig := config.GetConfig()
	// make note of overridden options
	if logLevel != "" {
		appConfig.OverrideLogLevel = true
	}
	if logPath != "" {
		appConfig.OverrideLogFile = true
	}

	tool.Logger.SetupLogging(logPath, logLevel, true)

	// logging is up, barf out some debug info about the config state up to now
	tool.Logger.Debug("Log level set to [", appConfig.ActiveLog.Level, "]")
	if appConfig.OverrideLogLevel {
		tool.Logger.Debug("Log level overridden from original config setting [", appConfig.LogLevel, "]")
	}
	if appConfig.OverrideLogFile {
		tool.Logger.Debug("Log file overridden from original config setting [", appConfig.LogFile, "]")
	}
	tool.Logger.Debug("Loaded configuration from [", appConfig.Path, "]")

	dbinfo := fmt.Sprintf("user=%s password=%s dbname=%s sslmode=disable",
		appConfig.User, appConfig.Password, appConfig.Database)
	tool.Db, err = sql.Open("postgres", dbinfo)
	if err != nil {
		fmt.Println("Error opening database: ", err)
		os.Exit(1)
	}

	return tool
}

func (tool *SchemaTool) Create() {

}

func (tool *SchemaTool) Delete() {

}

func (tool *SchemaTool) Version() {

}

func (tool *SchemaTool) Update() {

}

// Shutdown shuts down the tool
func (tool *SchemaTool) Shutdown() {
	tool.Db.Close()
	appConfig := config.GetConfig()
	tool.Logger.CloseLog(appConfig.ActiveLog.File, appConfig.LogHandle)
}
