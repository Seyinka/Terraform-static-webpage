provider "aws" {
  region = var.aws-region
}

module "aws_bucket" {
  source="./modules/s3_bucket"
  bucket_name = var.s3-bucket-name
}

module "aws_cloudfront" {
  source="./modules/cloudfront"
  s3-bucket=module.aws_bucket.s3-bucket

}
module "route53" {
  source = "./modules/route53"
  domain-name = var.domain-name
  env = var.env
  cloudfront_domain_name = module.aws_cloudfront.aws_cloudfront.domain_name
  cloudfront_hosted_zone_id = module.aws_cloudfront.aws_cloudfront.hosted_zone_id
  
}

module "certificate" {
  source = "./modules/certificate"
  domain-name = var.domain-name
  aws_route53_zone_id=module.route53.route53.zone_id
}
