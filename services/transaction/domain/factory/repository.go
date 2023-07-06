package factory

import (
	"github.com/ksd-mx/mx-bank/services/transaction/domain/repository"
)

type RepositoryFactory interface {
	CreateTransactionRepository() repository.TransactionRepository
}
