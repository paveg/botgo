package main

import (
	"log"
	"os"

	"github.com/k0kubun/pp"
	"github.com/kelseyhightower/envconfig"
	"github.com/nlopes/slack"
)

type environmentConfig struct {
	Port              string `environmentConfig:"PORT" default:"3000"`
	BotID             string `environmentConfig:"BOT_ID" required:"true"`
	BotToken          string `environmentConfig:"BOT_TOKEN" required:"true"`
	ChannelID         string `environmentConfig:"CHANNEL_ID" required:"true"`
	VerificationToken string `environmentConfig:"VERIFICATION_TOKEN" require:"true"`
}

func main() {
	os.Exit(_main(os.Args[1:]))
}

func _main(args []string) int {
	_ = args // TODO: Implementation
	var env environmentConfig
	if err := envconfig.Process("", &env); err != nil {
		log.Printf("[ERROR] Failed to process env var: %s\n", err)
		return 1
	}

	log.Printf("[INFO] Start slack event listening")
	client := slack.New(env.BotToken)

	res, err := client.AuthTest()
	if err != nil {
		log.Printf("[ERROR] Failed to AuthTest: %s\n", err)
	}
	pp.Printf("response: %v", res)
	return 0
}
