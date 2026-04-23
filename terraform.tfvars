environments = {
  default = {
    # Global variables
    cluster_name                   = "codedevops-cluster"
    env                            = "default"
    region                         = "ap-south-1"
    vpc_id                         = "vpc-0cc3ab2dbe259dec0"
    vpc_cidr                       = "10.0.0.0/16"
    public_subnet_ids              = ["subnet-0fecaf4d8c34fce2b"]
    cluster_version                = "1.29"
    cluster_endpoint_public_access = true
    ecr_names                      = ["codedevops"]

    # EKS variables
    eks_managed_node_groups = {
      generalworkload-v4 = {
        min_size       = 1
        max_size       = 1
        desired_size   = 1
        instance_types = ["t3.micro"]
        capacity_type  = "SPOT"
        disk_size      = 60
        ebs_optimized  = true
        iam_role_additional_policies = {
          ssm_access        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
          cloudwatch_access = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
          service_role_ssm  = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
          default_policy    = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
        }
      }
    }
    cluster_security_group_additional_rules = {}

    # EKS Cluster Logging
    cluster_enabled_log_types = ["audit"]
    eks_access_entries = {
      viewer = {
        user_arn = []
      }
      admin = {
        user_arn = ["arn:aws:iam::342831714463:user/kubernetes"]
      }
    }
    # EKS Addons variables 
    coredns_config = {
      replicaCount = 1
    }
  }

}
