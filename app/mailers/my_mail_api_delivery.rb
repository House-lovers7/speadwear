class MyMailApiDelivery

    def initialize(settings)
        @settings = settings
    end

    def deliver!(mail)
    # ここでAPI送信処理を呼び出す
    MailApi.deliver({from: mail.from.first,
                  to: mail.to.first,
                  subject: mail.subject,
                  text_body: mail.text_part.body.raw_source,
                  html_body: mail.html_part.body.raw_source,
                  reply_to: @settings[:reply_to],
                  return_path: @settings[:return_path]
                })    
    end
end