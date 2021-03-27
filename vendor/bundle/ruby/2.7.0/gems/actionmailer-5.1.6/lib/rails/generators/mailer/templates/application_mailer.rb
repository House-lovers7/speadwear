<% module_namespacing do -%>
class ApplicationMailer < ActionMailer::Base
  default from: 'admin@speadwear.com'
  layout 'mailer'
end
<% end %>
