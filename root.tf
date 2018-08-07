resource "aws_s3_bucket" "com-programmez-terraform" {
    bucket = "${var.aws_s3_bucket_terraform}"
    acl    = "private"

    tags {
        Tool    = "${var.tags-tool}"
        Contact = "${var.tags-contact}"
    }
}
