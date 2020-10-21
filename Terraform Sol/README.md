# Scenario:

The Application team requires 2 EC2 instances to be provisioned. They have already written a module for EC2 instances.
Your job is to reuse the `ec2` and `key-pair` modules to provision 3 instances with the following properties passed in as input parameters:

- Instance Type: `t3.micro`
- Tags: Add a `Name` tag that is unique for each instance.

It has also been decided that each EC2 instance needs to be provisioned in the following Availability Zones and Subnets.

| Subnet | Availability Zone |
|--------|-------------------|
| subnet-az-2a | ap-southeast-2a |
| subnet-az-2b | ap-southeast-2b |
| subnet-az-2c | ap-southeast-2c |

<br>

Also output the following values:

1. A list of all Instance IDs.
2. The Public and Private key of the Key Pair as a Map

<br>

## Deliverables:

1. Write a clear and understandable README.md file which details deployment process, any input parameters and any outputs.
2. A `private` repository with the code.
3. A blueprint Terraform file that uses the modules to provision the resources.

<br>

## Extras:

You can either code or explain how the following could be accomplished:

1. CI/CD pipeline for deployment to a Terraform Cloud workspace.
2. Any tests to check for success or failure of the pipeline.

<br>

## "SOLUTION"

The IAM access should have permission to deploy EC2 instance and create Key. 

  ## Blueprint Terraform file -- modules.tf
    3 set of EC2 and key modules along with the output defined.

  ## Output of the Terrafrom apply
    module.key01.tls_private_key.this: Refreshing state... [id=27c05eb61ed91ab4e17d068d97f79c3df4f175e3]
    module.key02.tls_private_key.this: Refreshing state... [id=6ce1499d421c29b8d667e7f00e073a7085facfa3]
    module.key03.tls_private_key.this: Refreshing state... [id=5da722548ace4f786c55250af243d0fb3e27a925]
    module.key03.aws_key_pair.this: Refreshing state... [id=Key3]
    module.key01.aws_key_pair.this: Refreshing state... [id=Key1]
    module.key02.aws_key_pair.this: Refreshing state... [id=Key2]
    module.ec2-03.data.aws_subnet.this: Refreshing state...
    module.ec2-01.data.aws_subnet.this: Refreshing state...
    module.ec2-02.data.aws_subnet.this: Refreshing state...
    module.ec2-03.aws_instance.this: Refreshing state... [id=i-05dbe9a51f1999ab0]
    module.ec2-01.aws_instance.this: Refreshing state... [id=i-0a56e021d22702d98]
    module.ec2-02.aws_instance.this: Refreshing state... [id=i-010e955cbf358f9f8]

  ## Input Parameters:

    For EC2 instance 01 , 02 and 03
    ami, instance_type, name_tag, availability_zone, subnet_name, key_name

    For Key
    key_name 


  ## Output Parameters:

    Instance ID
        ec2-01-id = i-0a56exxxxxxxxxxxx
        ec2-02-id = i-010e9xxxxxxxxxxxx
        ec2-03-id = i-05dbexxxxxxxxxxxx

    Public and private key
        Pub-pri-key01 = {
            "Public-Key" = "ssh-rsa AAAAB3NzaC1
            "private-Key" = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQI
        }
        Pub-pri-key02 = {
            "Public-Key" = "ssh-rsa LUJl0Su1Xug
            "private-Key" = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAI
        }
        Pub-pri-key03 = {
            "Public-Key" = "ssh-rsa AAAAB3NzaC1
            "private-Key" = "-----BEGIN RSA PRIVATE KEY-----\nMIIEowI
        }


Note: -- Since we are suppose to create the EC2 in different subnets, we are not using the loops in here.


## Extra's

## 1. CI/CD pipeline for deployment to a Terraform Cloud workspace.

    Steps
    1. Create an private repo in the github
    2. Create an account in terraform cloud
    3. Link the private repo of github to terraform cloud by authorizing it to access the repo.
    4. Create AWS IAM user with programmatic access. Attach the policy with "EC2fullaccess".
    5. In the Terraform Cloud, plugins for aws, enter the AWS Env Variables.
    6. Then click on the "queue plan" and provide the reason for the same, (This would pause the build and wait for the manual approval for the pipeline )
    
