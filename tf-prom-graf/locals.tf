locals {
  prometheus_name = "${var.prefix}-pm"
  grafana_name    = "${var.prefix}-grf"
  environment     = "dev"
  pm_script_path  = "./install_pm_server_ubu.sh"
}