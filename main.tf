module "terraform" {
  source = "github.com/global-devops-terraform/terraform?ref=v1.3.1"

  bucket_name = var.bucket_name
}

module "jenkins" {
  source = "github.com/global-devops-terraform/jenkins-roles?ref=v1.7.0"

  bucket_name      = module.terraform.bucket_name
  jenkins_instance = "selfservice"
}
