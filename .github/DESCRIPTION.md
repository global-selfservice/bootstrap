# Self Service Bootstrap
We use terraform to build our infrastructure, terraform needs some pre-req to be handled before setting up and running the code using a CI server like jenkins.

## Pre-req
1. Terraform s3 backend 
2. Terraform lock via dynamodb table
3. To build and deploy via jenkins, jenkins IAM assumable roles with policies need to be in place.

## How we run it for the first time?

For the first time, we need to run terraform plan and apply via our laptops using the ADFS-Fullaccess. This can be done as below

**Note**: comment the terraform backend section in [this](provider.tf) file before proceeding, this will create the terrform state file locally on laptops

```
git clone git@github.com:global-self-service/bootstrap.git
cd bootstrap
terraform init
terraform plan -var-file="vars/dev.tfvars" -out plan.txt
terraform apply plan.txt
```
Once the terraform apply works as expected, we need to make sure the backend is copied to the s3 backend, to do this make sure you run the below command once complete

**Note**: uncomment the terraform backend section in [this](provider.tf) file before proceeding

```
cd bootstrap
terraform init
Initializing modules...

Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "s3" backend. No existing state was found in the newly
  configured "s3" backend. Do you want to copy this state to the new "s3"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes


Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
```
In case of multiple AWS accounts, we need to 

1. Pass appropriate variable files in the commands aforementioned. 
2. Overwrite the terraform backend via backend config file 

For ex: 

On Prod AWS account:

**Note**: In case of production aws account, we need to overwrite the terraform backend via a config file, because the default backend configuration is pointing to dev

```
cd bootstrap
terraform init -reconfigure -backend-config="vars/live.backend.tfvars"
Initializing modules...

Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "s3" backend. No existing state was found in the newly
  configured "s3" backend. Do you want to copy this state to the new "s3"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes


Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
```

## Troubleshoot

### 1. Corrupt .terrform folder

We can always delete the .terraform folder and start fresh, when the terraform init command is executed it will always create a .terraform folder locally and initialises all required modules.
