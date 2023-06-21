# MX BANK SERVICE ( PoC )

A simple service in Golang with its CI and Kubernetes deployment manifests.

## Requirements

[x] The service must be deployable with a Docker image.
[] The service is meant to be deployed in at least two environments.
[] The artifacts must be built in an automated way in a CI environment.
[] The service can be deployed with Helm or plain Kubernetes manifests.
[] Even if not implemented/used in the service, we assume the service will require three environment variables: DB_USER, DB_HOST, and DB_PASSWORD.
[] Even if not implemented/used in the service, we assume the service will require a config file that should be loaded with a ConfigMap.

[] Users can access the frontend of the application.
[] The application requires a SQL database (Postgres, MariaDB, etc..)
[] Network flows must be described.
[] Security elements must be described.