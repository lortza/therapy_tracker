Sentry.init do |config|
  config.dsn = Rails.application.credentials.sentry_dsn
  config.enabled_environments = %w[production]

  # enable performance monitoring
  config.enable_tracing = true

  # get breadcrumbs from logs
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 1.0
  # or
  # config.traces_sampler = lambda do |context|
  #   true
  # end
end
