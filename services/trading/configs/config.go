package configs

import (
	"sync"

	"github.com/go-chi/jwtauth"
	"github.com/spf13/viper"
)

var (
	cfg  *config
	once sync.Once
)

type Configuration interface {
	GetDbName() string
	GetDbUser() string
	GetDbPass() string
	GetDbHost() string
	GetDbPort() string
	GetWebServerPort() string
	GetJwtSecret() string
	GetJwtExpiresIn() int
	GetTokenAuth() *jwtauth.JWTAuth
}

type config struct {
	dbName        string
	dbUser        string
	dbPass        string
	dbHost        string
	dbPort        string
	webServerPort string
	jwtSecret     string
	jwtExpiresIn  int
	tokenAuth     *jwtauth.JWTAuth
}

func (c *config) GetDbName() string              { return c.dbName }
func (c *config) GetDbUser() string              { return c.dbUser }
func (c *config) GetDbPass() string              { return c.dbPass }
func (c *config) GetDbHost() string              { return c.dbHost }
func (c *config) GetDbPort() string              { return c.dbPort }
func (c *config) GetWebServerPort() string       { return c.webServerPort }
func (c *config) GetJwtSecret() string           { return c.jwtSecret }
func (c *config) GetJwtExpiresIn() int           { return c.jwtExpiresIn }
func (c *config) GetTokenAuth() *jwtauth.JWTAuth { return c.tokenAuth }

func GetConfiguration() Configuration {
	once.Do(func() {
		viper.SetConfigType("env")
		viper.SetConfigFile(".env")
		viper.AutomaticEnv()

		err := viper.ReadInConfig()
		if err != nil {
			panic(err)
		}

		cfg = &config{
			dbName:        viper.GetString("db_name"),
			dbUser:        viper.GetString("db_user"),
			dbPass:        viper.GetString("db_pass"),
			dbHost:        viper.GetString("db_host"),
			dbPort:        viper.GetString("db_port"),
			webServerPort: viper.GetString("web_server_port"),
			jwtSecret:     viper.GetString("jwt_secret"),
			jwtExpiresIn:  viper.GetInt("jwt_expires_in"),
			tokenAuth:     jwtauth.New("HS256", []byte(viper.GetString("jwt_secret")), nil),
		}

		cfg.tokenAuth = jwtauth.New("HS256", []byte(cfg.jwtSecret), nil)
	})

	return cfg
}
