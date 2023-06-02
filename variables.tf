variable "bucket_name" {
  description = "The name of the S3 bucket to be created"
  type        = string
  validation {
    condition     = can(regex("^([a-z0-9][a-z0-9-]{1,61}[a-z0-9])$", var.bucket_name))
    error_message = "Bucket names can't contain dots and must match the regex '^([a-z0-9][a-z0-9-]{1,61}[a-z0-9])$'."
  }
}

variable "kms_key" {
  default     = null
  description = "The ARN of the KMS key for bucket's encryption. If not set, the default AWS/S3 key will be used"
  type        = string
}

variable "logging_configuration" {
  default = {
    bucket_name = null
    enabled     = false
    prefix      = null
  }
  description = "Logging configuration block"
  type = object({
    bucket_name = optional(string)
    enabled     = optional(bool, false)
    prefix      = optional(string)
  })
}

variable "public_access_configuation" {
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
  description = "Public access configuration block"
  type = object({
    block_public_acls       = optional(bool, true)
    block_public_policy     = optional(bool, true)
    ignore_public_acls      = optional(bool, true)
    restrict_public_buckets = optional(bool, true)
  })
}

variable "versioning_status" {
  default     = "Disabled"
  description = "Enable versioning on the bucket"
  type        = string
  validation {
    condition     = contains(["Enabled", "Disabled", "Suspended"], var.versioning_status)
    error_message = "Versioning status can be: ['Enabled', 'Disabled', 'Suspended']"
  }
}
