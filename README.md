# MX BANK SERVICE ( PoC )

The "mx-bank-service" project on GitHub is a Proof of Concept (PoC) for a simple banking service built in Golang, with its CI/CD pipeline and Kubernetes deployment manifests. The languages used in the project include HCL (HashiCorp Configuration Language), Go, Shell, and Dockerfile​1​.

The CI/CD pipeline for the 'dev' environment is described in a GitHub Actions workflow file called "dev.yml". This workflow triggers upon a push to the main branch, and it's divided into several jobs and steps:

- [x] The workflow checks out the code.
- [x] It then configures AWS credentials using an AWS Action.
- [x] It installs Terragrunt, a thin wrapper for Terraform that provides extra tools for keeping your Terraform configurations DRY, working with multiple Terraform modules, and managing remote state.
- [x] The workflow applies Terraform scripts using Terragrunt and stores the outputs such as ECR Repository, EKS Cluster Name, EKS Cluster ARN, and DB Endpoint.
- [x] It installs and configures AWS CLI.
- [x] The workflow gets the kubeconfig from the EKS cluster.
- [x] Finally, it uploads the kubeconfig and k8s templates as artifacts​2​.
- [x] The infrastructure modules for the project are found within the tf/modules directory. 

The modules include definitions for an AWS API Gateway and a VPC link:

- [x] The 1-api.tf file describes the resource for the AWS API Gateway. It specifies that the API is of protocol type 'HTTP'. The API Gateway has a 'dev' stage that is set to auto-deploy​3​.
- [x] The 2-private-link.tf file describes the resources for a VPC link and a security group. The security group is associated with the VPC link. The VPC link is associated with the API Gateway and uses the security group's id​4​.


![alt text](./architecture.png?raw=true)