package entity

import (
	"github.com/ksd-mx/mx-bank-service/services/trading/pkg/entity"
	"golang.org/x/crypto/bcrypt"
)

type User struct {
	ID        entity.ID          `json:"id"`
	Username  string             `json:"username"`
	Email     string             `json:"email"`
	Password  string             `json:"-"`
	Balance   map[string]float64 `json:"balance"`
	CreatedAt string             `json:"created_at"`
}

func NewUser(username, email, password string) (*User, error) {
	hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return nil, err
	}

	return &User{
		ID:       entity.NewID(),
		Username: username,
		Email:    email,
		Password: string(hash),
		Balance: map[string]float64{
			"USD": 0.0,
			"BTC": 0.0,
			"ETH": 0.0,
		},
	}, nil
}

func (u *User) ValidatePassword(password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(password))
	return err == nil
}
