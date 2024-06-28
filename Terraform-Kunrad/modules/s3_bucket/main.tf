resource "aws_s3_bucket" "seyi-bucket" {
  bucket= var.bucket_name
  force_destroy = true
}

resource "aws_s3_object" "webpage" {
    bucket=aws_s3_bucket.seyi-bucket.bucket
   for_each = fileset("modules/s3_bucket/webpage/", "**/*.*") 
   key = each.value
   source = "modules/s3_bucket/webpage/${each.value}"
   content_type = each.value

  
}