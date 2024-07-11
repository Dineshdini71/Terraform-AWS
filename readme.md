How multiple user can access same statefile.

terraform state list
terraform state mv (changing the resource name but not changed the aws display name).
terraform state rm (Remove data from the state file).

Terraform import:

terraform import aws_vpc.Yourvpc vpc-073f94eac057521a4

Terraform Debugging:

Linux - export TF_LOG="DEBUG"
Linux - export TF_LOG="ERROR"
Linux - export TF_LOG="TRACE"
Linux - export TF_LOG_PATH="C:\tmp\terraform.log"

Powershell - $env:TF_LOG="DEBUG"
Powershell - $env:TF_LOG="ERROR"
Powershell - $env:TF_LOG="TRACE"
Powershell - $env:TF_LOG_PATH="C:\tmp\terraform.log" 