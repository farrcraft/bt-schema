package main

import (
	"fmt"
	"github.com/Sirupsen/logrus"
	"os"
	"path/filepath"
	"strings"
)

func CloseLog(logFile string, fileHandle *os.File) {
	if logFile == "STDOUT" || logFile == "STDERR" {
		return
	}
	err := fileHandle.Close()
	if err != nil {
		fmt.Errorf("Error closing log file: ", err)
	}
}

// SetupLogging sets up the log object for logging
func SetupLogging(logPath string, logLevel string) error {
	config := GetConfig()

	log.Formatter = new(logrus.JSONFormatter)

	// determine the log level we want to log at
	if logLevel != "" {
		config.ActiveLogLevel = logLevel
	}
	level, err := logrus.ParseLevel(strings.ToLower(config.ActiveLogLevel))
	if err != nil {
		return fmt.Errorf("Invalid log level [", config.ActiveLogLevel, "]")
	}
	log.Level = level

	if logPath != "" {
		if logPath != "STDOUT" && logPath != "STDERR" {
			config.ActiveLogFile, _ = filepath.Abs(logPath)
		} else {
			config.ActiveLogFile = logPath
		}
	}

	// get a file to log into - could also be a predefined std stream
	var file *os.File
	if config.ActiveLogFile == "STDOUT" {
		file = os.Stdout
	} else if config.ActiveLogFile == "STDERR" {
		file = os.Stderr
	} else {
		var err error
		file, err = os.OpenFile(config.ActiveLogFile, os.O_WRONLY|os.O_APPEND|os.O_CREATE, 0640)
		if err != nil {
			return err
		}
	}
	log.Out = file

	return nil
}
