resource "aws_iam_role" "tower_admin" {
  name = "tower_admin"

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

resource "aws_iam_instance_profile" "tower_profile" {
  name = "tower_profile"
  role = "${aws_iam_role.tower_admin.name}"
}

resource "aws_iam_role_policy" "tower_admin_policy" {
  name = "tower_admin_policy"
  role = "${aws_iam_role.tower_admin.id}"

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
