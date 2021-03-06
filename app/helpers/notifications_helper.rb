module NotificationsHelper

    def notification_form(notification)
       @sender = notification.sender
       @cordinate = notification.cordinate
       @comment = nil
       your_cordinate = link_to 'あなたの投稿', user_show_path(notification), style:"font-weight: bold;"
       @sender_comment = notification.comment_id
       #notification.actionがfollowかlikeかcommentか
       case notification.action
         when "follow" then
            tag.a(notification.sender.name, href:user_show_path(@sender), style:"font-weight: bold;")+"があなたをフォローしました"
         when "cordinatelike" then
            tag.a(notification.sender.name, href:user_show_path(@sender), style:"font-weight: bold;")+"が" +tag.a('あなたの投稿', href:cordinate_show_path(user_id: current_user.id, id: notification.cordinate.id ), style:"font-weight: bold;")+"にいいねしました"
         when "comment" then
          @comment = Comment.find_by(id: @sender_comment)&.comment
               tag.a(@sender.name, href:user_show_path(@sender), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:cordinate_show_path(user_id: current_user.id, id: notification.cordinate.id), style:"font-weight: bold;")+"にコメントしました"
       end
     end
     def unchecked_notifications
      @notifications = current_user.passive_notifications.where(checked: false)
  end
  
  end
  
  # get "/users/:user_id/cordinates/:id", to: "cordinates#show", as: "cordinate_show"
  
  
  
  # create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  #    t.integer "sender_id", null: false
  #    t.integer "receiver_id", null: false
  #    t.integer "cordinate_id"
  #    t.integer "comment_id"
  #    t.integer "likecordinate_id"
  #    t.string "action", default: "", null: false
  #    t.boolean "checked", default: false, null: false
  #    t.datetime "created_at", null: false
  #    t.datetime "updated_at", null: false
  #    t.index ["comment_id"], name: "index_notifications_on_comment_id"
  #    t.index ["cordinate_id"], name: "index_notifications_on_cordinate_id"
  #    t.index ["likecomment_id"], name: "index_notifications_on_likecomment_id"
  #    t.index ["likecordinate_id"], name: "index_notifications_on_likecordinate_id"
  #    t.index ["receiver_id"], name: "index_notifications_on_receiver_id"
  #    t.index ["sender_id"], name: "index_notifications_on_sender_id"
  #  end
  
  
  #  create_table "cordinates", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  #    t.integer "user_id"
  #    t.integer "item_id"
  #    t.integer "season"
  #    t.integer "tpo"
  #    t.integer "rating"
  #    t.string "memo"
  #    t.string "picture"
  #    t.integer "si_shoes"
  #    t.integer "si_bottoms"
  #    t.integer "si_tops"
  #    t.integer "si_suits"
  #    t.integer "si_outer"
  #    t.datetime "created_at", null: false
  #    t.datetime "updated_at", null: false
  #    t.integer "comment_id"
  #    t.integer "likecordinate_id"
  #  end
  