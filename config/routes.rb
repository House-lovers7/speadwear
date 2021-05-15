# frozen_string_literal: true
Rails.application.routes.draw do
  root 'users#new'
  # root "/LP"
  get '/lp', to: redirect('/lp.html')

  resources :items
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :relationships, only: %i[create destroy]
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users do
    member do
      get :blocking, :blockers
    end
  end

  delete '/logout', to: 'sessions#destroy'
  get 'search', to: 'items#search'
  get '/help', to: 'static_pages#help'
  get '/home', to: 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  # かんたんログインの実装
  post '/sessions/guest_log_in', to: 'sessions#guest_login', as: 'guest_login'
  # 全てのUserのItemとCordinateをみる
  get '/:user_id/cordinates/allusers', to: 'cordinates#all_cordinate_show',
                                       as: 'all_cordinate_show'
  get '/:user_id/items/allusers', to: 'items#all_item_show', as: 'all_item_show'

  # Rasnsackで全てのUserのItemをみる
  get '/:user_id/items/items_search/tpo', to: 'items#all_item_tpo_search',
                                          as: 'items_tpo_search'
  get '/:user_id/items/items_search/rating',
      to: 'items#all_item_rating_search', as: 'items_rating_search'
  get '/:user_id/items/items_search/season',
      to: 'items#all_item_season_search', as: 'items_serch_season'
  get '/:user_id/items/items_search/color', to: 'items#all_item_color_search',
                                            as: 'items_search_color'
  get '/:user_id/items/items_search/super_item',
      to: 'items#all_item_super_item_search', as: 'items_search_super_item'

  # Rasnsackで全てのUserのCordinateをみる
  get '/:user_id/cordinates/cordinates_search/tpo', to: 'cordinates#all_cordinate_tpo_search',
                                                    as: 'cordinates_tpo_search'
  get '/:user_id/cordinates/cordinates_search/season', to: 'cordinates#all_cordinate_season_search',
                                                       as: 'cordinates_season_search'
  get '/:user_id/cordinates/cordinates_search/rating', to: 'cordinates#all_cordinate_rating_search',
                                                       as: 'cordinates_rating_search'

  get '/:user_id/items/cordinates_search',
      to: 'cordinates#all_cordinate_search', as: 'cordinates_serch'

  # userコントローラー
  get '/users/:user_id/index', to: 'users#index', as: 'allusers_index'
  get '/users/new', to: 'users#new', as: 'user_new'
  get '/users/:id/', to: 'users#show', as: 'user_show'
  # get '/users/:id/ranking', to: 'users#ranking', as: 'user_ranking'

  # itemsコントローラー(個別User)
  get '/users/:user_id/items/all', to: 'items#user_all_item_show',
                                   as: 'user_item'
  get '/users/:user_id/items/new', to: 'items#new', as: 'item_new'
  get '/users/:user_id/items/:id', to: 'items#show', as: 'item_show'
  patch '/users/:user_id/items/:id/edit', to: 'items#update', as: 'item_update'
  get '/users/:user_id/items/:id/edit', to: 'items#edit', as: 'item_edit'
  get '/users/:user_id/cordinates/:cordinate_id/items',
      to: 'items#cordinate_show', as: 'cordinate_item_show'
  get '/users/:user_id/cordinates/:cordinate_id/items/search', to: 'items#cordinate_search_si',
                                                               as: 'cordinate_search_si'
  post '/users/:user_id/items/', to: 'items#create', as: 'item_create'
  delete '/users/:user_id/items/:id', to: 'items#destroy', as: 'item_delete'

  # cordinateコントローラー(個別のUser)
  get '/users/:user_id/cordinates/all',
      to: 'cordinates#user_all_cordinate_show', as: 'user_cordinate'
  get '/users/:user_id/cordinates/new', to: 'cordinates#new', as: 'cordinate_new'
  get '/users/:user_id/cordinates/:id', to: 'cordinates#show',
                                        as: 'cordinate_show'
  get '/users/:user_id/cordinates/:id/edit', to: 'cordinates#edit',
                                             as: 'cordinate_edit'
  post '/users/:user_id/cordinates', to: 'cordinates#create',
                                     as: 'cordinate_create'

  # get '/users/:user_id/cordinates/:id/modal', to: 'cordinates#cordinate_modal',

  # saveに関してリファクタリングの可能性を検討する
  get '/users/:user_id/cordinates/:id/items/:item_id/edit',
      to: 'cordinates#item_edit', as: 'cordinate_item_edit'

  get '/users/:user_id/cordinates/:id/save', to: 'cordinates#cordinate_save',
                                             as: 'cordinate_edit_save'
  post '/users/:user_id/cordinates/:id/edit', to: 'cordinates#cordinate_save',
                                              as: 'cordinate_save'

  # controllerを変える必要はあるのか？
  patch '/users/:user_id/cordinates/:id/', to: 'cordinates#update',
                                           as: 'cordinate_patch'
  delete '/users/:user_id/cordinates/:id', to: 'cordinates#destroy',
                                           as: 'cordinate_delete'
  patch '/users/:user_id/cordinates/:id/items/:item_id',
        to: 'cordinates#item_update', as: 'items_patch'

  # Commentシリーズ(個別のUser)
  post '/users/:user_id/cordinates/:id/comments', to: 'comments#create',
                                                  as: 'comment_create'
  delete '/users/:user_id/cordinates/:id/comments/:comment_id',
         to: 'comments#destroy', as: 'comment_delete'

  # Likecordinateシリーズ(個別のUser)
  post '/users/:user_id/cordinates/:id/likecordinates',
       to: 'likecordinates#create', as: 'likecordinate_create'
  delete '/users/:user_id/cordinates/:id/likecordinates/:likecordinate_id', to: 'likecordinates#destroy',
                                                                            as: 'likecordinate_delete'
  # Notificationsコントローラー(個別のUser)
  get '/users/:user_id/notifications/', to: 'notifications#index',
                                        as: 'notifications'
  delete '/users/notifications/alldelete', to: 'notifications#destroy_all',
                                           as: 'destroy_all_users_notifications'
end
