# AWS 리소스에 대한 권한이 필요하기 때문에 IAM의 access_key와 secret_key를 입력, 리전 변경이 필요한 경우 다른 리전값을 입력
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "ap-northeast-2"
}