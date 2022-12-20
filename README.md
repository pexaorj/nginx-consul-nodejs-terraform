# Readme First

This repository works as an example of how to create and deploy applications on Amazon AWS using some DevOps tools.
The intent here is to put you in a new perspective of how do those things, running aways the old fashion of do things manually at AWS console, at the end of this tutorial you will have had deployed at least one simple application on AWS using the new way of do things, called IaC (Infrastructure as code).

### What you will need to use this repository as example ###

* [Nodejs](https://nodejs.org/)
* [express lib for Nodejs](http://expressjs.com/)
* [Docker](https://www.docker.com/)
* [Terraform](https://www.terraform.io)
* [Ubuntu Server](https://www.ubuntu.com/download/server)
* [aws cli](http://docs.aws.amazon.com/pt_br/cli/latest/userguide/installing.html)

### Repository Structure ###
```
├── docker
│   ├── docker-nginx-consul
│   └── nodejs
├── scripts
│   └── stress_test.sh
├── terraform
│   ├── arch-main-state.tf
│   ├── gera-chave-ssh.sh
│   ├── makeconfig.sh
│   ├── modules
│   │   ├── eip
│   │   ├── env
│   │   ├── instances
│   │   │   ├── app-instances
│   │   │   └── arch-instances
│   │   ├── routes
│   │   ├── security-group
│   │   ├── subnets
│   │   └── vpc
│   ├── README.md
│   ├── ssh_keys
│   │   ├── debug-key
│   │   └── debug-key.pub
│   ├── ssh-key.tf
└── vagrant
```

#### Folders

>Docker - contain all files to build docker images
Scripts - contain all scripts
Terraform - contain all tf files used to deploy the infrastructure during this demo
Vagrant - used to build one Ubuntu test machine


### Requirements

 - One AWS account created
 - Enough permissions to use this AWS account to deploy this tutorial on N.Virginia Region
 - Basic knowledge working with AWS
 - Use bash on your console (this example assume that you are one Linux User or are familiar with bash commands)

### What will be deployed ###

![nginx-consul-template.png](img/nginx-consul-template.png)

 - 1 Instance to work as load balancer with (Nginx + Consul + Consul-template + Register)
 - 2 Instances acting as application instances ( Nodejs + Register)
 - 1 Route53 Zone + records to instances interact using dns names instead directly ip's
 - All other things are not described here in detail since it's not the main purpose of this tutorial.

#### Points to pay attention and have in mind

As this repository works as an simple example, some important aspects are not covered here, like:

 - One ELB to split the load between frontend servers
 - High Availability over Nat Instances
 - Auto Scaling group
 - Bastion Host
 - Log improvements and tools (ELK, graylog, datadog, cloudwatch, etc)
 

### Deploy the example Stack.

1) Create one S3 Bucket in N.Virginia (us-east-1) region using the AWS Console

2)Create one IAM user and download the API/key to use during this example

3) Configure your console to use this credential with the command:
```
aws config
```

4) Open this file `arch-main-state.tf`, and update the bucket name, using the name of the s3 bucket created on the 1 step.
```hcl
terraform {
    backend "s3" {
    bucket = "terraform-chaordic"
    key    = "arch-state/terraform.tfstate"
    region = "us-east-1"
    shared_credentials_file = "/root/.aws/credentials"
    profile                 = "default"
  }
}
```

4) Run this script to generate one SSH Key pair. This key will be used to access all servers if needed.

```
terraform/gera-chave-ssh.sh
```

5) Download the terraform version 0.9.0
 `-[terraform_0.9.0](https://releases.hashicorp.com/terraform/0.9.0/)`

6) Run this script to perform the planning over your AWS Account.

```
terraform/makeconfig.sh
```

If all ran well and you started to see in the console output all resources that will be created on your AWS account, you can go to the next step, it will apply this code over your AWS account.

7) Apply the code using terraform

```
terraform apply
```

### So far so good, but explain me how it works ###

After performing one `terraform apply`, terraform will start to interact with amazon cli using your api/key to do some instructions to create your described infrastructure using your code.
It can take a while and you will see all steps from your console output.

To test this example and check if all those actions worked as expected you should now open your AWS account console and:

 - Go to EC2>>Instances and look for the instance of `nginx-web-proxy`, grab the public DNS (ipv4).
 - Use this address to paste it on your browser URL to get access to this example application.
 - If you reload the page, you will see 2 responses, each of them coming from one server (in this example we have 2).


### Clean up

After perform all tests, remember that maintain resources running on AWS can generate costs to you or to your organisation, so to avoid you any kind of billing problems, remember to delete this stack at the end of your tests, as you saw, using IaC is simple to have the complete environment up and running in a few moments.

To clean running this command:
`terraform destroy`
It will ask if you want to perform this action, please type yes.
