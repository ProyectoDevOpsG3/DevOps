# Terraform Block
terraform {
  required_version = "~> 1.8.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


# Provider Block
provider "aws" {
  region  = "us-east-1"
  profile = "default" 
}






# Create S3 Bucket Resource


resource "aws_s3_bucket" "s3_bucket_dev_g3" {
  bucket = "dev-bucket-g3"
  tags = {
    Name        = "dev-bucket-g3"
    Environment = "dev"
  }
}


resource "aws_s3_bucket_public_access_block" "public_acces_bucket_dev" {
  bucket = aws_s3_bucket.s3_bucket_dev_g3.id

  block_public_acls       = false
  block_public_policy     = false
}



resource "aws_s3_bucket_policy" "error_data_dev" {
  bucket = aws_s3_bucket.s3_bucket_dev_g3.id
  policy = data.aws_iam_policy_document.error_policy_dev.json
}




data "aws_iam_policy_document" "error_policy_dev" {
  
    statement {
        sid       = "1"
        effect    = "Allow"
        principals {
          type = "AWS"
          identifiers =  [ "*" ]
          
        }
        actions    = [
          "s3:GetObject"
          ]
        resources  = [
          "arn:aws:s3:::dev-bucket-g3/*"
          ]
      }

}

resource "aws_s3_bucket_website_configuration" "website_s3_bucket_dev_g3" {
  bucket = aws_s3_bucket.s3_bucket_dev_g3.id
  index_document {
    suffix = "index.html"
  }
}

//--------- MAIN ----------


resource "aws_s3_bucket" "s3_bucket_main_g3" {
  bucket = "m-bucket-g3"
  tags = {
    Name        = "m-bucket-g3"
    Environment = "main"
  }
}


resource "aws_s3_bucket_public_access_block" "public_acces_bucket_main" {
  bucket = aws_s3_bucket.s3_bucket_main_g3.id

  block_public_acls       = false
  block_public_policy     = false
}



resource "aws_s3_bucket_policy" "error_data_main" {
  bucket = aws_s3_bucket.s3_bucket_main_g3.id
  policy = data.aws_iam_policy_document.error_policy_main.json
}


data "aws_iam_policy_document" "error_policy_main" {
  
    statement {
        sid       = "1"
        effect    = "Allow"
        principals {
          type = "AWS"
          identifiers =  [ "*" ]
          
        }
        actions    = [
          "s3:GetObject"
          ]
        resources  = [
          "arn:aws:s3:::m-bucket-g3/*"
          ]
      }

}

resource "aws_s3_bucket_website_configuration" "website_s3_bucket_main_g3" {
  bucket = aws_s3_bucket.s3_bucket_main_g3.id
  index_document {
    suffix = "index.html"
  }
}

//------- TEST ---------------------
resource "aws_s3_bucket" "s3_bucket_test_g3" {
  bucket = "t-bucket-g3"
  tags = {
    Name        = "t-bucket-g3"
    Environment = "test"
  }
}


resource "aws_s3_bucket_public_access_block" "public_acces_bucket_test" {
  bucket = aws_s3_bucket.s3_bucket_test_g3.id

  block_public_acls       = false
  block_public_policy     = false
}



resource "aws_s3_bucket_policy" "error_data_test" {
  bucket = aws_s3_bucket.s3_bucket_test_g3.id
  policy = data.aws_iam_policy_document.error_policy_test.json
}




data "aws_iam_policy_document" "error_policy_test" {
  
    statement {
        sid       = "1"
        effect    = "Allow"
        principals {
          type = "AWS"
          identifiers =  [ "*" ]
          
        }
        actions    = [
          "s3:GetObject"
          ]
        resources  = [
          "arn:aws:s3:::t-bucket-g3/*"
          ]
      }

}

resource "aws_s3_bucket_website_configuration" "website_s3_bucket_test_g3" {
  bucket = aws_s3_bucket.s3_bucket_test_g3.id
  index_document {
    suffix = "index.html"
  }
}
