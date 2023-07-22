package entity

import (
	"testing"

	"github.com/ksd-mx/mx-bank-service/services/trading/internal/entity"
	"github.com/stretchr/testify/assert"
)

func TestUser_NewUser(t *testing.T) {
	username := "test"
	email := "test@test.com"
	password := "test"

	user, err := entity.NewUser(username, email, password)
	assert.Nil(t, err)
	assert.NotNil(t, user)
	assert.NotEmpty(t, user.ID)
	assert.NotEmpty(t, user.Username)
	assert.NotEmpty(t, user.Password)
	assert.NotEmpty(t, user.Email)

	assert.Equal(t, username, user.Username)
	assert.Equal(t, email, user.Email)
}

func TestUser_ValidatePassword(t *testing.T) {
	username := "test"
	email := "test@test.com"
	validPassword := "test"
	invalidPassword := "test_"

	user, err := entity.NewUser(username, email, validPassword)
	assert.Nil(t, err)
	assert.NotNil(t, user)
	assert.True(t, user.ValidatePassword(validPassword))
	assert.False(t, user.ValidatePassword(invalidPassword))
	assert.NotEqual(t, validPassword, user.Password)
}
