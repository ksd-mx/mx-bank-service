package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	ck "github.com/confluentinc/confluent-kafka-go/kafka"
	"github.com/joho/godotenv"
	"github.com/ksd-mx/mx-bank/services/transaction/adapter/broker"
	"github.com/ksd-mx/mx-bank/services/transaction/adapter/broker/kafka"
	"github.com/ksd-mx/mx-bank/services/transaction/adapter/factory"
	"github.com/ksd-mx/mx-bank/services/transaction/adapter/presenter/transaction"
	"github.com/ksd-mx/mx-bank/services/transaction/usecase/process_transaction"
	_ "github.com/lib/pq"
)

func main() {
	err := godotenv.Load()

	if err != nil {
		log.Fatal("Could not read environment variables", err)
	}

	http.HandleFunc("/healthz", healthHandler)
	http.HandleFunc("/readyz", readyHandler)

	prepareBroker()
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Healthy"))
}

func readyHandler(w http.ResponseWriter, r *http.Request) {
	// TODO: Add any logic needed to check if the service is ready to handle requests.
	// For example, if your service depends on a database or another service,
	// we will check if a connection can be established.
	status := true
	if status {
		w.WriteHeader(http.StatusOK)
	} else {
		w.WriteHeader(http.StatusInternalServerError)
	}

	w.Write([]byte("Ready"))
}

func prepareBroker() {
	db, err := sql.Open("postgres", fmt.Sprintf("user=%s password=%s dbname=%s host=%s sslmode=%s",
		os.Getenv("POSTGRES_USER"),
		os.Getenv("POSTGRES_PASSWORD"),
		os.Getenv("POSTGRES_DB"),
		os.Getenv("POSTGRES_HOST"),
		os.Getenv("POSTGRES_SSLMODE")))

	if err != nil {
		log.Fatal("Failed connecting to the database", err)
	}

	repositoryFactory := factory.NewRepositoryDatabaseFactory(db)
	transactionRepository := repositoryFactory.CreateTransactionRepository()

	configMsgProducer := &ck.ConfigMap{
		"bootstrap.servers": os.Getenv("BOOTSTRAP_SERVERS"),
	}
	kafkaPresenter := transaction.NewTransactionKakfaPresenter()
	producer := kafka.NewKafkaProducer(configMsgProducer, kafkaPresenter)

	var msgChan = make(chan *ck.Message)
	configMsgConsumer := &ck.ConfigMap{
		"bootstrap.servers": os.Getenv("BOOTSTRAP_SERVERS"),
		"client.id":         os.Getenv("CLIENT_ID"),
		"group.id":          os.Getenv("GROUP_ID"),
	}

	topics := []string{broker.TransactionTopic}
	consumer := kafka.NewKafkaConsumer(configMsgConsumer, topics)
	go consumer.Consume(msgChan)

	usecase := process_transaction.NewProcessTransaction(transactionRepository, producer, broker.TransactionResultTopic)
	log.Println(
		"Listening ",
		os.Getenv("BOOTSTRAP_SERVERS"),
		" on topic ",
		broker.TransactionTopic,
		" and ",
		broker.TransactionResultTopic,
		" for results")

	for msg := range msgChan {
		var input process_transaction.TransactionInputDTO

		json.Unmarshal(msg.Value, &input)
		_, err = usecase.Execute(input)
		if err != nil {
			log.Panicln(err)
		}
	}
}
