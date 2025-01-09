# ai-agent-terraform

Terraform project for deploying [elizaos/eliza, swarms, any other ai chat] api infrastructure across multiple environments and regions, following best practices with modular structure and automated syntax checks (GitHub Actions)

## Repo structure

```
terraform-template/                   # Root directory of the Terraform template repository
├── README.md                         # Project documentation and overview
├── environments                      
│   ├── swarms-aws-agent-api
│   │   ├── dev                       # Development environment configuration for the demo-azure-vm setup
│   │   │   └── us-east-1
├── modules                           # Directory containing reusable Terraform modules
│   ├── swarms
```

