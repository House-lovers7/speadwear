# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* .



controllerにpostとstaticpagesを入れてないけど大丈夫なのか？



Itemモデルの中で表示する(showアクションかな？)
 Cordinate.where(si_tops: @item.id).count + Cordinate.where(si_bottoms: @item.id).count + Cordinate.where(si_shoes: @item.id).count + Cordinate.where(si_outer: @item.id).count 



Itemモデル内の該当ユーザーのデータを集合をつくる。
集合の全てに対して、条件に該当するものをカウントして並びかえる
並び替えたものを1~3までを表示する。


傾向分析もできる
Top３分析
Usearの登録分析


1番おおく、使用している服は何のか？

どんな服が多いのか、季節、TPOが多いのか、



 <Cordinate id: 1, user_id: 1, item_id: 24, comment_id: nil, likecordinate_id: nil, season: "秋", tpo: "リラックス♪", picture: "cordinate1.JPG", si_shoes: 3, 
 si_bottoms: 2, si_tops: 1, si_outer: nil, memo: "これは1個目のコーディネートです", rating: "4", created_at: "2021-03-06 08:16:36", updated_at: "2021-03-08 12:23:00">