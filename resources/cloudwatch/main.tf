resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = "PhotoShare-Monitor"

  dashboard_body = jsonencode({
    widgets = [
        {
            type = "metric"
            x      = 0
            y      = 0
            width  = 12
            height = 6

            properties = {
                view = "timeSeries"
                metrics = [
                    [
                        "AWS/EC2",
                        "CPUUtilization",
                        "InstanceId",
                        var.instance_id
                    ]
                ]
                period = 300
                stat   = "Average"
                title  = "EC2 Instance CPU"
            }
        },
        {
            type = "metric"
            x      = 12
            y      = 0
            width  = 6
            height = 6

            properties = {
                view    = "singleValue"
                metrics = [
                    [
                        "AWS/Lambda",
                        "Invocations",
                        "FunctionName",
                        var.lambda_functiona_name
                    ]
                ]
                stat   = "Sum"
                period = 300
                title  = "Lambda Invocations"
            }
        }
    ]
  })
}