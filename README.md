
## 使用技術

- Rails 5.1.6
- DB: Mysql 8.0.23 
- AWS(EC2, Elastic IP, RDS, Route53, VPC, IAM )
- API:[OpenWeather](https://openweathermap.org/api)
- Docker（Dockerfile, docker-compose.yml） 
- HTML
- CSS
- Javascript 
- Capistrano 

## アプリケーションの概要

:herb:
:octocat:
:four_leaf_clover:
:bell:
:key:
:memo:
:black_nib:
:paperclip:
:pushpin:
:coffee:
:tea:
:information_source:
:heavy_check_mark:
:link:
:large_blue_diamond:
:black_circle:
:large_orange_diamond:
:small_red_triangle_down:


## 作戦1
- :keyboard: めちゃくちゃタイピングするのでうるさいです



## アプリケーショの機能一覧

:large_orange_diamond: ユーザー  
  &emsp;&nbsp;メール認証  
  &emsp;&ensp;新規作成/表示/編集/削除

:large_orange_diamond: フォロー&アンフォロー(Relationモデル)  
  &emsp;&emsp;新規作成(フォロー)/削除（アンフォロー)  
  &emsp;&thinsp;権限管理(フォローしているユーザーのみ相手のコーディネートが提案できる)

:large_orange_diamond: ブロック  
  新規作成(ブロック)/削除（ブロック解除)  
  ブロックされたユーザーはブロックしたユーザーのページ閲覧と機能実行ができない。

:large_orange_diamond: アイテム  
  新規作成/表示/編集/削除

:large_orange_diamond: アイテムの絞り込み検索機能（Ransack)  
  TPO（どんな気分の時に着るのか） ⇨ デート・リラックス・スポーツ・おでかけ・仕事 から選択  
  Season（どの季節で着るのか) ⇨　春・夏・秋・冬　から選択  
  Rating（どの評価の服を選ぶのか)　⇨　1〜５の5段階から選択  
  Color（何色の服を着るのか） ⇨　14色対応  
  カテゴリー（どのカテゴリーの着るのか)　⇨　アウター・トップス・ボトムス・シューズ の4つから選択

:large_orange_diamond: コーディネート  
新規作成/表示/編集/削除

:large_orange_diamond: コーディネートの絞り込み検索機能（Ransack)  
  TPO（どんな気分の時に着るのか） ⇨ デート・リラックス・スポーツ・おでかけ・仕事 から選択  
  Season（どの季節で着るのか) ⇨　春・夏・秋・冬　から選択  
  Rating（どの評価の服を選ぶのか)　⇨　1〜５の5段階から選択

:large_orange_diamond: コーディネートいいね(Ajax) いいねボタン   
 新規作成/表示(コメントといいねしたユーザー表示)/削除

:large_orange_diamond: コメント（コーディネートへ)  
 新規作成/表示/削除

:large_orange_diamond: 通知(コメント・コーデへのいいね)  
新規作成/表示/削除



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


## Usersテーブル

|  Column  |  Type  |  Options  |
| ---- | ---- | ---- |
|   item_id |  integer  |    |
|  cordinate_id  |  integer   |    |
|  email  |  string   |  null: false  |
|  password_digest  |  integer   |
|  picture  |  integer   |     |
|  admin  |  boolean   |    |
|  activated  |  boolean   |    |


## Cordinatesテーブル

|  Column  |  Type  |  Options  |
| ---- | ---- | ---- |
|   user_id |  integer  |  null: false  |
|  item_id  |  integer   |    |
|  comment_id  |  string   |    |
|  si_outer  |  integer   |    |
|  si_tops  |  integer   |    |
|  si_bottoms  |  integer   |    |
|  si_shoes  |  integer   |    |
|  season  |  integer   |    |
|  tpo  |  integer   |    |
|  rating  |  integer   |    |
|  picture  |  integer   |    |
|  memo  |  integer   |    |

## Itemsテーブル

|  Column  |  Type  |  Options  |
| ---- | ---- | ---- |
|   user_id |  integer  |  null: false  |
|  cordinate_id  |  integer   |    |
|  comment_id  |  string   |    |
|  season  |  integer   |  null: false  |
|  tpo  |  integer   |  null: false  |
|  color  |  integer   |  null: false  |
|  rating  |  integer   |  null: false  |
|  content  |  integer   |  null: false |  
|  memo  |  text   |    |
|  picture  |  integer   |    |

## Relationshipsテーブル

|  Column  |  Type  |  Options  |
| ---- | ---- | ---- |
|   follower_id |  integer  |  null: false  |
|  folloewd_id  |  integer   | null: false   |


## Blocksテーブル

|  Column  |  Type  |  Options  |
| ---- | ---- | ---- |
|  blocker_id |  integer  |  null: false  |
|  blocked_id |  integer  | null: false   |

## Commentsテーブル

|  Column  |  Type  |  Options  |
| ---- | ---- | ---- |
|  user_id |  integer  |  null: false  |
|  cordinate_id |  integer  | null: false   |
|  comment |  text  | null: false   |


## Like＿Cordinatesテーブル

|  Column  |  Type  |  Options  |
| ---- | ---- | ---- |
|   user_id |  integer  |  null: false  |
|  cordinate_id  |  integer   | null: false   |

## Notificationsテーブル

|  Column  |  Type  |  Options  |
| ---- | ---- | ---- |
|  sender_id |  integer  |    |
|  receiver_id  |  integer   |    |
|  cordinate_id |  integer  |    |
|  comment_id  |  integer   |    |
|  like_cordinate_id |  integer  |    |
|  blocker_id  |  integer   |    |
|  action |  string  |    |
|  cordinate_id  |  integer   |    |
|  action  |  string   |    |
|  checked  |  boolean   |    |









