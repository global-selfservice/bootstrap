module "terraform" {
  source = "github.com/global-devops-terraform/terraform?ref=v1.0.0"

  bucket_name = var.bucket_name
}

module "jenkins" {
  source = "github.com/global-devops-terraform/jenkins-roles?ref=v1.1.0"

  bucket_name  = module.terraform.bucket_name
  jenkins_role = module.common.jenkins_oidc_roles["self-service"]
}
