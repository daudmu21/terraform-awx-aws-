resource "aws_iam_role" "admine_admin_worker1" {
  name = "admine_admin_worker1"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "admine_profile_worker1" {
  name = "admine_profile_worker1"
  role = "${aws_iam_role.admine_admin_worker1.name}"
}

resource "aws_iam_role_policy" "admine_admin_policy_worker1" {
  name = "admine_admin_policy_worker1"
  role = "${aws_iam_role.admine_admin_worker1.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}
