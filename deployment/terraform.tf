# It would be good here to use a bucket to manage the state, the bucket needs to be created in advance
# You can do this in the console, or using another terraform directory then uncomment the following code. 

# terraform {
#   backend "s3" {
#     bucket = "<bucket-name>"
#     key    = "path/to/my/key"
#     region = "eu-west-1" # variable intrapolation isn't allowed here
#   }
# }