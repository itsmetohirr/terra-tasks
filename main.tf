provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project = "epam-tf-lab",
      ID      = "cmtr-o84gfl9h"
    }
  }
}
