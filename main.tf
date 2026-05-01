

module "ec2_dev" {
  count = var.env == "dev" ? 1 : 0

  source = "./module/ec2"
  env    = "dev"

  instance_type = "t2.micro"
}

module "ec2_stage" {
  count = var.env == "stage" ? 1 : 0

  source = "./module/ec2"
  env    = "stage"

  instance_type = "t2.micro"
}

module "ec2_prod" {
  count = var.env == "prod" ? 2 : 0

  source = "./module/ec2"
  env    = "prod"

  instance_type = "t2.micro"
}
module "s3_dev" {
  count = var.env == "dev" ? 1 : 0
  source = "./module/S3-bucket"
  bucket_name = "${var.my_project}-${var.env}-bucket-ubaid12345-s3"
  my_project = var.my_project
  env = var.env 
  account_id = "872515260579"
   depends_on = [module.iam_test] 
}

module "s3_stage" {
  count = var.env == "stage" ? 1 : 0
  source       = "./module/S3-bucket"
  bucket_name = "${var.my_project}-${var.env}-bucket-ubaid12345-s3"
  my_project  = var.my_project
  env          = var.env
  account_id = "872515260579"
}


module "s3_prod" {
  count = var.env == "prod" ? 1 : 0
  source       = "./module/S3-bucket"
  bucket_name = "${var.my_project}-${var.env}-bucket-ubaid12345-s3"
  my_project = var.my_project
  env          = var.env
  account_id = "872515260579"
}

module "iam_test" {
  count = var.env == "dev" ? 1 : 0
  source     = "./module/iam-role"
  env        = var.env
  s3_actions = ["s3:*"]
  role_name   = "test-role"
}

module "iam_stage" {
  count = var.env == "stage" ? 1 : 0
  source     = "./module/iam-role"
  env        = "stage"
  s3_actions = ["s3:GetObject", "s3:PutObject"]  
  role_name   = "stage-role"
  }

module "iam_prod" {
  count = var.env == "prod" ? 1 : 0
  source     = "./module/iam-role"
  env        = "prod"
  s3_actions = ["s3:GetObject", "s3:ListBucket"]
  role_name   = "prod-role"

}

module "pipeline" {
  source = "./module/Pipeline"   # match EXACT folder name

  project_name         = "ubaid-project-v1"
  artifact_bucket_name = "ubaid-artifacts-12345"
  deploy_bucket_name   = "ubaid-deploy-12345"

  github_owner = "Ubaid-kathjoo"
  github_repo  = "Aiiots-Geek--Repository"
  github_token = var.github_token
}