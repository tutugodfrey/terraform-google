# Working with Terraform in Google Cloud

https://www.cloudskillsboost.google/course_templates/636/labs/555703

```bash
terraform init

terraform plan -out=plan

terraform apply plan

terraform import module.instances.google_compute_instance.tf-instance-1 tf-instance-1

terraform import module.instances.google_compute_instance.tf-instance-2 tf-instance-2

```
