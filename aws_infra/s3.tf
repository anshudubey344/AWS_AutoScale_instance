resource "aws_s3_bucket" "bucket" {

	bucket = "${var.my_env}-anshu-bucket"
    tags = {
        Name = "${var.my_env}-anshu-bucket"
    }
}
