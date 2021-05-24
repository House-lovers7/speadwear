# frozen_string_literal: true

module NotificationsHelper
  def notification_form(notification)
    @sender = notification.sender
    @receiver = notification.receiver
    @cordinate = notification.cordinate
    @comment = nil
    your_cordinate = link_to 'あなたの投稿', user_show_path(notification),
                             style: 'font-weight: bold;'
    @sender_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentか

    case notification.action

    when 'follow'
      tag.a(@sender.name, href: user_show_path(@sender),
                          style: 'font-weight: bold;') + 'が' + tag.a(@receiver.name, href: user_show_path(@receiver),
                                                                                     style: 'font-weight: bold;') + 'をフォローしました'

    when 'cordinatelike'
      tag.a(@sender.name, href: user_show_path(@sender),
                          style: 'font-weight: bold;') + 'が' + tag.a(@receiver.name + 'のコーディネート',
                                                                      href: cordinate_show_path(user_id: current_user.id, id: notification.cordinate.id), style: 'font-weight: bold;') + 'にいいねしました'
    when 'comment'
      @comment = Comment.find_by(id: @sender_comment)&.comment
      tag.a(@sender.name, href: user_show_path(@sender),
                          style: 'font-weight: bold;') + 'が' + tag.a(@receiver.name + 'のコーディネート',
                                                                      href: cordinate_show_path(user_id: current_user.id, id: notification.cordinate.id), style: 'font-weight: bold;') + 'にコメントしました'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
