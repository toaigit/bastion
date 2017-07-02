terraform {
  backend "s3" {
    bucket = "your.remotestate.domain.name"
    key    = "bastion.tfstate"
    region = "us-west-2"
  }
}
