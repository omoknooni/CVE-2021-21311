# target 버킷
resource "aws_s3_bucket" "secret_s3_bucket" {
  bucket = "secret-s3-bucket-ssrfdemo"
  force_destroy = true
  tags = {
    Name = "secret-s3-bucket-ssrfdemo"
  }
}

# target 버킷의 탈취할 object
resource "aws_s3_object" "hidden-file" {
  bucket = aws_s3_bucket.secret_s3_bucket.id
  key = "hidden-file.txt"
  source = "../assets/hidden-file.txt"
  tags = {
    Name = "hidden-file"
  }
}

resource "aws_s3_bucket_acl" "secret_s3_bucket_acl" {
  bucket = aws_s3_bucket.secret_s3_bucket.id
  acl = "private"
}