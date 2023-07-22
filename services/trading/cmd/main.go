package main

import (
	"fmt"

	"github.com/ksd-mx/mx-bank-service/services/trading/configs"
)

func main() {
	config := configs.GetConfiguration()

	fmt.Printf(config.GetDbName())
}
