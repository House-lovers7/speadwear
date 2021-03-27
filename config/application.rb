# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Action Mailerのdelivery_methodの設定
# ActionMailer::Base.add_delivery_method :my_mail_api_delivery, MyMailApiDelivery
# config.action_mailer.delivery_method = :my_mail_api_delivery
# config.action_mailer.my_mail_api_delivery_settings = {
#     reply_to:     'reply_to@example.com',
#     return_path:  'return_path@example.com'
# }

module Speadwear_development
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end

  # 最後
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :ja # 追加
  end
end
