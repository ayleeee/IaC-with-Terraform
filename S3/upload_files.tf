resource "aws_s3_object" "index" {
  bucket        = aws_s3_bucket.bucket1.id  # 생성된 S3 버킷 이름 사용
  key           = "index.html"
  source        = "index.html"
  content_type  = "text/html"
  cache_control = "no-cache"

  etag = filemd5("index.html")  # 파일이 변경된 경우에만 다시 업로드되도록 설정
  
}
resource "aws_s3_object" "main" {
  bucket        = aws_s3_bucket.bucket1.id  # 생성된 S3 버킷 이름 사용
  key           = "main.html"
  source        = "main.html"
  content_type  = "text/html"
  cache_control = "no-cache"

  etag = filemd5("main.html")  # 파일이 변경된 경우에만 다시 업로드되도록 설정
  
}