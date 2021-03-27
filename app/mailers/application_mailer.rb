# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@speadwear.com'
  layout 'mailer'
end
