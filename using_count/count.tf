resource "null_resource" "nothing" {

  count = var.create == false ? "0" : "1"

  provisioner "local-exec" {
    command = "echo 'True...lets create something'"
  }
}

variable "create" {
  type        = bool
  description = "create"
}