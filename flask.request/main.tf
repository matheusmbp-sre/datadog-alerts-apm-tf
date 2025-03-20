terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
      version = "3.2.0"
    }
  }
}

locals {
  default_tags = [
    "env:${var.environment}",
    "service:${var.service_name}",
    "managed-by:terraform"
  ]
}

resource "datadog_monitor" "error_percentage" {
  name = format( "%s :: Increased error percentage", upper(var.service_name))

  type    = "metric alert"
  message = "An increased number of errors has been detected in the service named ${var.service_name}.\n Please, check the logs and latest deployments \n\n ${var.notification_channels}" 

  query = "avg(last_30m):(sum:trace.flask.request.errors{service:${var.service_name}, env:${var.environment}}.as_rate() * 100) / sum:trace.flask.request.hits{service:${var.service_name}, env:${var.environment}}.as_rate() > ${var.error_critical_threshold}"

  monitor_thresholds {
    critical = var.error_critical_threshold
    critical_recovery = var.error_recovery_threshold
  }

  include_tags = true

  tags = local.default_tags
}

resource "datadog_monitor" "latency" {
  name = format("%s :: Abnormal change in latency", upper(var.service_name))

  type    = "query alert"
  message = "${var.service_name} has an abnormal change in latency for $env. The 75th percentile latency has deviated significantly. \n\n ${var.notification_channels}" 

  query = "avg(last_12h):anomalies(p75:trace.flask.request{service:${var.service_name}, env:${var.environment}}.as_count(), 'agile', 2, direction='both', interval=120, alert_window='last_30m', count_default_zero='true', seasonality='hourly') > 0.75"

  monitor_thresholds {
    critical          = 0.75
	critical_recovery = 0
  }

  monitor_threshold_windows {
		trigger_window  = "last_30m"
		recovery_window = "last_15m"
	}

  include_tags = true

  tags = local.default_tags
}

resource "datadog_monitor" "watchdog" {
  name = format("%s :: Watchdog Anomaly :: {{event.title}} for {{service}}", upper(var.service_name))

  type    = "event-v2 alert"
  message = "{{event.title}} detected on {{service}} \n {{event.text}}\n \n ${var.notification_channels}"

  query = "events(\"source:watchdog (story_category:apm service:${var.service_name}) env:${var.environment}\").rollup(\"count\").by(\"story_key,datacenter,service,resource_name\").last(\"30m\") > 0"
  monitor_thresholds {

    critical = 0
  }

  include_tags = true

  tags = local.default_tags
}

resource "datadog_monitor" "request" {  
  name = format("%s :: Increased number of requests/s", upper(var.service_name))

  type    = "query alert"
  message = "An increased number of requests has been detected in the service named ${var.service_name}.\n Please contact Sec team, we might be under attack \n\n ${var.notification_channels}" 

  query = "avg(last_30m):sum:trace.flask.request.hits{service:${var.service_name}, env:${var.environment}}.as_rate() > ${var.request_critical_threshold}"

  monitor_thresholds {
    critical = var.request_critical_threshold
    critical_recovery = var.request_recovery_threshold
  }

  include_tags = true

  tags = local.default_tags
}