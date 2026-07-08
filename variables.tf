variable "key_name" {
  description = "Name of the existing EC2 key pair to use"
  type        = string
}

variable "docker_image" {
  description = "Legacy Docker image input retained for compatibility"
  type        = string
  default     = ""
}
