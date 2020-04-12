package main

import (
	"conf-demo/config"
	"log"
)

func main() {
 log.Println(config.Conf.GetString("server.port"))
}


