module "sskmodule" {
    source = "../Day-8-BasicCode"
    ami_id = var.ami_id
    instance_type = var.instance_type
}

