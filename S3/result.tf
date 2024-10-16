# S3 버킷의 웹사이트 호스팅 설정
resource "aws_s3_bucket_website_configuration" "xweb_bucket_website" {
  bucket = aws_s3_bucket.bucket1.id  # 생성된 S3 버킷 이름 사용

  index_document {
    suffix = "index.html"
  }
}

output "website_endpoint" {
  value = aws_s3_bucket.bucket1.website_endpoint
  description = "The endpoint for the S3 bucket website."
}
