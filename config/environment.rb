# frozen_string_literal: true
# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name:  ENV['SENDGRID_USERNAME'],
  password:   ENV['SENDGRID_PASSWORD'],
#   domain:     ENV['SENDGRID_U'],
  address:    ENV['SENDGRID_ADRESS'],
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}


  if Rails.env.production?
    CarrierWave.configure do |config|
      config.fog_credentials = {
        # Amazon S3用の設定
        :provider              => 'AWS',
        :region                => ENV['S3_REGION'],  # S3に設定したリージョン。
        :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
        :aws_secret_access_key => ENV['S3_SECRET_KEY']
      }
      config.fog_directory     =  ENV['S3_BUCKET']
    end
  end