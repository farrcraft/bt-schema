package main

type Schema struct {

}


func NewSchema(c *cli.Context) *Schema {
	schema := &Schema{
	}

	configPath := c.String("config")
	logLevel := c.String("level")
	logPath := c.String("log")

	if configPath == "" {
		fmt.Println("Missing config")
		os.Exit(1)
	}

	err := LoadConfig(configPath)
	if err != nil {
		fmt.Println("Error loading config: ", err)
		os.Exit(1)
	}

	config := GetConfig()
	if logLevel != "" {
		config.OverrideLogLevel = true
	}
	if logPath != "" {
		config.OverrideLogFile = true
	}

	err = SetupLogging(logPath, logLevel)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	log.Debug("Log level set to [", config.ActiveLogLevel, "]")
	if config.OverrideLogLevel {
		log.Debug("Log level overridden from original config setting [", config.LogLevel, "]")
	}
	if config.OverrideLogFile {
		log.Debug("Log file overridden from original config setting [", config.LogFile, "]")
	}
	log.Debug("Loaded configuration from [", config.Path, "]")

	return schema
}

func (schema *Schema) Install() {

}

func (schema *Schema) Create() {

}

func (schema *Schema) Update() {

}
// Shutdown shuts down the tool
func (schema *Schema) Shutdown() {
	log.Info("Shutting down...")
	config := GetConfig()
	CloseLog(config.ActiveLogFile, log.Out.(*os.File))
}
