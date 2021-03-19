# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'cokomo.gt@gmail.com'
  layout 'mailer'
end
