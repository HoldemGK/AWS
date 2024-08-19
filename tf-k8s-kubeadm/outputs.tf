output "master_private_ip" {
  value = module.ec2_master.private_ip
}

# output "worker_security_group_id" {
#   value = module.k8s_worker_sg.security_group_id
# }