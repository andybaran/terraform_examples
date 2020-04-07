# terraform_examples
Simple examples for learning and testing TF logic

This quick example uses a [Null](https://www.terraform.io/docs/providers/null/resource.html) resource to demostrate using the [count](https://www.terraform.io/docs/configuration/resources.html#count-multiple-resource-instances-by-count) meta-argument to create 1 or many resources.

At apply you'll be asked to provide a value for the boolean variable `create`.  Let's breakdown what we're using this for.  

```
resource "null_resource" "nothing" {
    count = var.create == false ? "0" : "1" 
    provisioner  "local-exec" {
        command = "echo 'True...lets create something'"
    } 
}

variable "create" {
  type        = bool
  description = "create"
}
```

The first line of code creates a null_resource.  We then setup our count meta-argument to equal "0" if the create variable is false and "1" if it is true.  By using an input variable to change the count meta-argument we control how many resources are created.  We just happen to have our number of resources set to "1" in this example so a single resource is either created or not; that 1 could just as well be 100. The resource being created is simply a local provisioner that runs the `echo` command.  

In a more realistic use case we might have a string variable called `environment`.  Maybe if the environment is production we want to create 5 resources but only a single resource if it's anything other than production:

`count = var.environment == "production" ? "1" : "5"`