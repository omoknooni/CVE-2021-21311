# ec2에 적용시킬 role
resource "aws_iam_role" "vuln_role" {
  name = "ec2-vuln-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
  EOF
  tags = {
    Name = "ec2-vuln-role"
    
  }
}

# role에 적용시킬 policy, exploit 시연용으로 생성한 버킷에만 접근가능하게 작성
resource "aws_iam_policy" "s3_policy" {
  name = "demobucket_access"
  description = "demo bucket access for secret-s3-bucket-ssrfdemo"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::secret-s3-bucket-ssrfdemo"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListAllMyBuckets"
            ],
            "Resource": "*"
        }
    ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "ec2-role-policy-attachment" {
  name = "ec2-role-policy-attachment"
  roles = [
    "${aws_iam_role.s3_policy.name}"
  ]
  policy_arn = "${aws_iam_policy.s3_policy.arn}"
}