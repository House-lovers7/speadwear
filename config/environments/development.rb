# frozen_string_literal: true

Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.serve_static_files = true

  # Don't care if the mailer can't send.
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true

  # 自分の環境に合わせて設定。
  host = 'localhost:3000'
  Rails.application.routes.default_url_options[:host] = host
  config.action_mailer.default_url_options = { host: host, protocol: 'https' }
  config.action_mailer.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: '587',
    authentication: :plain,
    user_name: 'apikey',
    password: ENV['SENDGRID_API_KEY'],
    domain: 'heroku.com',
    enable_starttls_auto: true
  }

  config.action_mailer.perform_caching = false
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Cloud9 への接続を許可する
  # config.hosts.clear
end
