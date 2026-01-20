variable "credentials" {
  description = "credentials to the service account"
  default     = "/workspaces/datazoomcamp-homework-module-1/data_analysis/datazoomcamp-484706-d87b906ee518.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "datazoomcamp-484706"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default     = "asia-south1"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "EU"
}

variable "bq_dataset_name" {
  description = "BigQuery Dataset Name"
  #Update the below to what you want your dataset to be called
  default     = "demo_hw_dataset"
}

variable "gcs_bucket_name" {
  description = "Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "terraform-hw-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}