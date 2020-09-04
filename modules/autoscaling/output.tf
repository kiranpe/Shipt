locals {
  this_launch_configuration_id   = var.launch_configuration == "" && var.create_lc ? concat(aws_launch_configuration.this.*.id, [""])[0] : var.launch_configuration
  this_launch_configuration_name = var.launch_configuration == "" && var.create_lc ? concat(aws_launch_configuration.this.*.name, [""])[0] : ""

  this_autoscaling_group_id                        = aws_autoscaling_group.this.*.id
  this_autoscaling_group_name                      = aws_autoscaling_group.this.*.name
  this_autoscaling_group_arn                       = aws_autoscaling_group.this.*.arn
  this_autoscaling_group_min_size                  = aws_autoscaling_group.this.*.min_size
  this_autoscaling_group_max_size                  = aws_autoscaling_group.this.*.max_size
  this_autoscaling_group_desired_capacity          = aws_autoscaling_group.this.*.desired_capacity
  this_autoscaling_group_default_cooldown          = aws_autoscaling_group.this.*.default_cooldown
  this_autoscaling_group_health_check_grace_period = aws_autoscaling_group.this.*.health_check_grace_period
  this_autoscaling_group_health_check_type         = aws_autoscaling_group.this.*.health_check_type
  this_autoscaling_group_availability_zones        = aws_autoscaling_group.this.*.availability_zones
  this_autoscaling_group_vpc_zone_identifier       = aws_autoscaling_group.this.*.vpc_zone_identifier
  this_autoscaling_group_load_balancers            = aws_autoscaling_group.this.*.load_balancers
  this_autoscaling_group_target_group_arns         = aws_autoscaling_group.this.*.target_group_arns
}

output "this_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = local.this_launch_configuration_id
}

output "this_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = local.this_launch_configuration_name
}

output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = local.this_autoscaling_group_id
}

output "this_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = local.this_autoscaling_group_name
}

output "this_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = local.this_autoscaling_group_arn
}

output "this_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = local.this_autoscaling_group_min_size
}

output "this_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = local.this_autoscaling_group_max_size
}

output "this_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = local.this_autoscaling_group_desired_capacity
}

output "this_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = local.this_autoscaling_group_default_cooldown
}

output "this_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = local.this_autoscaling_group_health_check_grace_period
}

output "this_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = local.this_autoscaling_group_health_check_type
}

output "this_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = local.this_autoscaling_group_availability_zones
}

output "this_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = local.this_autoscaling_group_vpc_zone_identifier
}

output "this_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = local.this_autoscaling_group_load_balancers
}

output "this_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = local.this_autoscaling_group_target_group_arns
}
