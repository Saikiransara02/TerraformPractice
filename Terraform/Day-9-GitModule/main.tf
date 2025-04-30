module "basic_module" {
  source = "git::https://github.com/Saikiransara02/terraform-0900am.git//Day-2-basic-code-for-module-source?ref=main"
  
  # Pass any required variables for the module here
  # Example:
   ami_id = "ami-0f1dcc636b69a6438"
   type   = "t2.micro"
}
    
  
