# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_306_052_747) do
  create_table 'blocks', force: :cascade,
                         options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.integer 'blocker_id'
    t.integer 'blocked_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'comments', force: :cascade,
                           options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.integer 'user_id'
    t.integer 'cordinate_id'
    t.string 'comment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'cordinates', force: :cascade,
                             options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.integer 'user_id'
    t.integer 'item_id'
    t.integer 'comment_id'
    t.integer 'likecordinate_id'
    t.integer 'season'
    t.integer 'tpo'
    t.string 'picture'
    t.integer 'si_shoes'
    t.integer 'si_bottoms'
    t.integer 'si_tops'
    t.integer 'si_outer'
    t.text 'memo'
    t.float 'rating', limit: 24
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'items', force: :cascade,
                        options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.integer 'user_id'
    t.integer 'cordinate_id'
    t.integer 'super_item'
    t.integer 'season'
    t.integer 'tpo'
    t.integer 'color'
    t.integer 'content'
    t.text 'memo'
    t.string 'picture'
    t.integer 'rating'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'likecordinates', force: :cascade,
                                 options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.integer 'user_id'
    t.integer 'cordinate_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'notifications', force: :cascade,
                                options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.integer 'sender_id'
    t.integer 'receiver_id'
    t.integer 'cordinate_id'
    t.integer 'comment_id'
    t.integer 'likecordinate_id'
    t.string 'action'
    t.boolean 'checked'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'relationships', force: :cascade,
                                options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.integer 'follower_id'
    t.integer 'followed_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade,
                        options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.string 'name'
    t.string 'email'
    t.string 'picture'
    t.integer 'cordinate_id'
    t.integer 'item_id'
    t.integer 'comment_id'
    t.boolean 'admin'
    t.string 'password_digest'
    t.string 'remember_digest'
    t.string 'reset_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'activation_digest'
    t.boolean 'activated'
    t.datetime 'activated_at'
    t.boolean 'friend'
  end
end
