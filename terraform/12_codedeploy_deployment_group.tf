resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group" {
  app_name = aws_codedeploy_app.aws_codedeploy.name

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  autoscaling_groups = [aws_autoscaling_group.autoscaling_group.name]

  deployment_config_name = "CodeDeployDefault.OneAtATime"
  deployment_group_name  = var.CD_DEPLOYMENT_GROUP

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  # ec2_tag_set {
  #   ec2_tag_filter {
  #     key   = "Name"
  #     type  = "KEY_AND_VALUE"
  #     value = "${var.TAG_PREFIX}-ec2-instance"
  #   }
  # }

  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.target_group.name
    }
  }

  service_role_arn = aws_iam_role.CodeDeployServiceRole.arn
}
