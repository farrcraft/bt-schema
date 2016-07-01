package config

import (
	"testing"
)

func TestConfig(t *testing.T) {
	err := LoadConfig("/this/path/is/bad/config.json")
	if err == nil {
		t.Error("Expected loading bogus config to fail")
	}
	err = LoadConfig("../../test/data/bad_config.json")
	if err == nil {
		t.Error("Expected loading invalid config to fail")
	}
}
