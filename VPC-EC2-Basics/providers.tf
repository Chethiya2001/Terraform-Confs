
provider "aws" {
  region = "us-east-1"
  #  profile = "default"

}
provider "aws" {
  region = "us-west-1"
  #profile = "default"
  alias = "west"

}
