package log

import (
	"../config"
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"github.com/Sirupsen/logrus"
	"os"
	"path/filepath"
	"strings"
)

const (
	LOG_CONTEXT_CLI = "cli"
)

type Log struct {
	Logrus    *logrus.Logger
	RequestId string
	Context   string
}

type Logger interface {
	Debug(args ...interface{})
	Warning(args ...interface{})
	Info(args ...interface{})
	Error(args ...interface{})
	Fatal(args ...interface{})
	NewLogContext(context string) *Log
}

func (logger *Log) NewLogContext(context string) *Log {
	if context != LOG_CONTEXT_CLI {
		logger.Error("Invalid log context [", context, "]")
		return logger
	}

	b := make([]byte, 8)
	_, err := rand.Read(b)
	if err != nil {
		logger.Error("Error creating request id - ", err)
		return logger
	}

	base64ID := base64.URLEncoding.EncodeToString(b)

	log := &Log{
		Logrus:    logger.Logrus,
		RequestId: base64ID,
	}
	return log
}

func (logger *Log) Debug(args ...interface{}) {
	logger.Logrus.WithFields(logrus.Fields{
		"request_id": logger.RequestId,
	}).Debug(args)
}

func (logger *Log) Warning(args ...interface{}) {
	logger.Logrus.WithFields(logrus.Fields{
		"request_id": logger.RequestId,
	}).Warn(args)
}

func (logger *Log) Info(args ...interface{}) {
	logger.Logrus.WithFields(logrus.Fields{
		"request_id": logger.RequestId,
	}).Info(args)
}

func (logger *Log) Error(args ...interface{}) {
	logger.Logrus.WithFields(logrus.Fields{
		"request_id": logger.RequestId,
	}).Error(args)
}

func (logger *Log) Fatal(args ...interface{}) {
	logger.Logrus.WithFields(logrus.Fields{
		"request_id": logger.RequestId,
	}).Fatal(args)
}

func (log *Log) CloseLog(logFile string, fileHandle *os.File) {
	if logFile == "STDOUT" || logFile == "STDERR" {
		return
	}
	err := fileHandle.Close()
	if err != nil {
		fmt.Println("Error closing log file: ", err)
	}
}

func (log *Log) SetupLogging(logPath string, logLevel string, reconfigure bool) {
	config := config.GetConfig()

	log.Logrus.Formatter = &logrus.JSONFormatter{}

	if logLevel != "" {
		config.ActiveLog.Level = logLevel
	}
	level, err := logrus.ParseLevel(strings.ToLower(config.ActiveLog.Level))
	if err != nil {
		if reconfigure {
			log.Error("Invalid log level [", config.ActiveLog.Level, "]")
			return
		} else {
			fmt.Println("Invalid log level [", config.ActiveLog.Level, "]")
			os.Exit(1)
		}
	}
	log.Logrus.Level = level

	if logPath != "" {
		if logPath != "STDOUT" && logPath != "STDERR" {
			config.ActiveLog.File, _ = filepath.Abs(logPath)
		} else {
			config.ActiveLog.File = logPath
		}
	}

	var file *os.File
	if config.ActiveLog.File == "STDOUT" {
		file = os.Stdout
	} else if config.ActiveLog.File == "STDERR" {
		file = os.Stderr
	} else {
		var err error
		file, err = os.OpenFile(config.ActiveLog.File, os.O_WRONLY|os.O_APPEND|os.O_CREATE, 0640)
		if err != nil {
			if reconfigure {
				log.Error("Unable to open log file [", config.ActiveLog.File, "] - ", err)
				return
			} else {
				fmt.Println("Unable to open log file [", config.ActiveLog.File, "] - ", err)
				os.Exit(1)
			}
		}
	}
	config.LogHandle = file
	log.Logrus.Out = file
}

func NewLog(logLevel string, logPath string) *Log {
	log := &Log{
		Logrus: logrus.New(),
	}
	log.SetupLogging(logPath, logLevel, false)
	return log
}
