# MX-BANK ( WORK IN PROGRESS 🚧 )

MX Bank Service is a microservices based banking application that leverages Kubernetes for deployment and orchestration. The application is composed of multiple services such as transaction, balance, pix and many more, each with its own Dockerfile for containerization.

The application also comes with a front-end client built with Next.js, styled with Tailwind CSS, and follows a highly modular structure for easy maintenance and scalability.

## Requirements

- [Docker](https://www.docker.com/products/docker-desktop): Needed to create, deploy and run the application containers.
- [Skaffold](https://skaffold.dev/): Handles the workflow for building, pushing and deploying your application on Kubernetes. Install instructions provided in the next section.
- [Terraform](https://www.terraform.io/downloads.html) & [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/): Used for specifying and providing data center infrastructure.
- [Kubectl](https://kubernetes.io/docs/tasks/tools/): Kubernetes command-line tool required to run commands against Kubernetes clusters.
- [Helm](https://helm.sh/docs/intro/install/): Helps you manage Kubernetes applications.
- [Node.js](https://nodejs.org/en/download/): JavaScript runtime needed to run the front-end client.
- [AWS Vault](https://github.com/99designs/aws-vault): Securely manages and uses your AWS access keys.

## Setup

1. Clone the repository: `git clone https://github.com/ksd-mx/mx-bank-service.git`
2. Navigate to the project directory: `cd mx-bank-service`
3. Install Husky hooks: `yarn husky install`
4. Run Skaffold to build and deploy your application: `skaffold dev`
5. Install Node.js dependencies for the frontend: `cd frontend && yarn install`
6. Deploy your application: `skaffold dev`

## Deploying with Terraform and Terragrunt

Terraform is used for creating and managing infrastructure. Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules. AWS Vault is used for securely managing and accessing AWS credentials.

Before deploying with Terraform and Terragrunt, make sure you have AWS access keys and have installed AWS Vault.

1. Add your AWS credentials to AWS Vault: `aws-vault add <profile_name>`. You will be prompted to enter your AWS Access Key ID and Secret Access Key.

> **IMPORTANT:** These IaC scripts include IAM resources like Roles and Permissions, so in order to deploy these remotelly, you need to make sure the user can assume a role with elevated priviledges, or that this user has MFA authentication enabled. Don't forget to include the MFA serial number in your `~/.aws/config` file.

2. To plan the infrastructure changes: `aws-vault exec <profile_name> -- terragrunt plan`
3. To apply the changes: `aws-vault exec <profile_name> -- terragrunt apply`

Your infrastructure should now be set up and running on AWS.

# Installing and Understanding Skaffold

[Skaffold](https://skaffold.dev/) is a command line tool that facilitates continuous development for Kubernetes applications. It handles the workflow for building, pushing, and deploying applications, allowing you to focus on writing your code.

To install Skaffold, follow the [official installation instructions](https://skaffold.dev/docs/install/). In short, if you're using macOS, you can use Homebrew:

```bash
brew install skaffold

# Running Services Locally with Skaffold

To run the services locally with Skaffold, navigate to the root directory of the project and run:

```shell
skaffold dev
```

Skaffold will build your Docker image(s), push them to a registry, and then start your application. Any code changes you make will trigger a new build and deployment process. 

# Running Frontend Locally

To run the front-end locally, navigate to the `frontend` directory:

```shell
cd frontend
```

Then install the required packages:

```shell
yarn install
```

After all packages are installed, you can start the local development server:

```shell
yarn dev
```

You can now access the application at `localhost:3000`

# Initializing the Local Work Environment with Husky & Commitlint

First, navigate to the root directory of the project. You will need to install the required packages:

```shell
yarn install
```

This will install Husky and Commitlint, as well as any other dependencies specified in your `package.json`.

Husky and Commitlint are used to ensure that your Git commit messages adhere to a consistent standard. Husky creates a Git hook that is triggered every time you commit. This hook runs Commitlint, which checks the commit message against the rules specified in `commitlint.config.ts`.

Since Husky and Commitlint are already set up in the provided project, no further configuration is necessary. Simply stage your changes (`git add .`), and then commit them (`git commit -m "Your message here"`). If your commit message does not adhere to the standard defined in `commitlint.config.ts`, the commit will be rejected.

Please replace `Your message here` with a meaningful commit message.

> **Note:** If you're using Windows, you might need to enable scripts to run Git hooks. If the hook is not working, you might need to run `Set-ExecutionPolicy RemoteSigned` in a PowerShell window with administrative privileges.

For more details on these tools:
- [Husky](https://typicode.github.io/husky/#/)
- [Commitlint](https://commitlint.js.org/#/)

<br><br>

![alt text](./architecture.png?raw=true)
