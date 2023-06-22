# MX BANK SERVICE ( PoC )

A simple service in Golang with its CI and Kubernetes deployment manifests.

## Requirements

[x] The service must be deployable with a Docker image.

[x] The service is meant to be deployed in at least two environments.

[x] The artifacts must be built in an automated way in a CI environment.

[] The service can be deployed with Helm or plain Kubernetes manifests.

[x] Even if not implemented/used in the service, we assume the service will require three environment variables: DB_USER, DB_HOST, and DB_PASSWORD.

[x] Even if not implemented/used in the service, we assume the service will require a config file that should be loaded with a ConfigMap.

[] Users can access the frontend of the application.

[x] The application requires a SQL database (Postgres, MariaDB, etc..)

[] Network flows must be described.

[] Security elements must be described.

# CHECKPOINTS

Created the following IAM artifacts:
* terraform-deployment-role (role)
* terraform-deployment-policy (adminsitrator privileges for speed/simplicity)
* terraform (user)
* access keys/secret (terraform user)

Activated the Terraform backend storage in S3
* using terraform-deployment-role (assume-role in profile)