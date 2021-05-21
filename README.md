
##  制作背景

**テンションがアガル**服に袖を通して1日を過ごしたい。 いまあるクローゼットの中から季節・気分・TPOに合わせたコーディネートを選んでファッションを楽しみたい。でも、服選びに時間をかけたくない。そんなワガママを叶えるためにアプリを作成しました。 100人いたら、100通りの個性と好きなファッションがある、そんな個性を尊重していきたい.

## 要件定義とアイディア出し
服を選ぶ時の重要な要素を考えてみました。
さぁ外出しようかという時、何を考えて服を選んでいるか振り返りました:pencil2:

大きく3つに分けられます。

- :bell:人からどう見られるか：**客観軸**
- :bell: 自分が好きな服かどうか：**主観軸**
- :bell:動きやすさ・重さ・着心地：**機能軸**

**衣替え**という言葉があるように、機能軸は先人の知恵に従い、季節にあった服を着れば満たせると考えました。
客観軸と主観軸には、**TPO**という便利な言葉があリます。時と場合によって私たちは服を選んでいます。
[マインド・マップを使い、アイディアの展開・深堀・整理しました。](https://www.mindmeister.com/ja/1401463492/_ )

やりたいことを発散させた後は、技術的にできるできない問題があり、(未経験の初学者であるため）、現実と折り合いをつけて、
[ブラッシュアップした結果です。](https://www.mindmeister.com/ja/1405225759/brush-up)

学習しながら、データベースの設計を考えて行き着いた
[最終結果です。](https://www.mindmeister.com/ja/1515140019/model-2021)

## 使用技術

:keyboard:  Rails 5.1.6  
:keyboard:  DB: Mysql 8.0.23  
:keyboard:  AWS(EC2, Elastic IP, RDS, Route53, VPC, IAM )  
:keyboard:  API:[OpenWeather](https://openweathermap.org/api)  
:keyboard:  Docker（Dockerfile, docker-compose.yml)  
:keyboard:  HTML  
:keyboard:  CSS  
:keyboard:  Javascript  
:keyboard:  Capistrano 


## アプリケーションの概要


[アイテム機能](https://twitter.com/i/status/1393862119037169670)
<div style="text-align: center;">
アイテム機能
</div>

![アイテムとコーデの絞り込み検索機能](https://gyazo.com/4a4edcf0464530f8e52532e2d68b97cd/raw)
<div style="text-align: center;">
アイテムとコーデの絞り込み検索機能
</div>

![コーデへのいいね機能](https://gyazo.com/ed6e7969c498d4ae9339ce3b2a28cce3/raw)
<div style="text-align: center;">
コーデへのいいね機能
</div>

![ブロック機能](https://gyazo.com/0f6e0ca72797c5a446802e99bfd6ab25/raw)
<div style="text-align: center;">
ブロック機能
</div>


[フォロー＆アンフォロー機能](https://twitter.com/i/status/1393895042486476811)
<div style="text-align: center;">
フォロー＆アンフォロー機能
</div>






## アプリケーショの機能一覧

:large_orange_diamond: ユーザー  
  &emsp;&ensp;メール認証  
  &emsp;&ensp;新規作成/表示/編集/削除

:large_orange_diamond: フォロー&アンフォロー(Relationモデル)  
  &emsp;&ensp;新規作成(フォロー)/削除（アンフォロー)  
  &emsp;&ensp;権限管理(フォローしているユーザーのみ相手のコーディネートが提案できる)

:large_orange_diamond: ブロック  
  &emsp;&ensp;新規作成(ブロック)/削除（ブロック解除)  
  &emsp;&ensp;ブロックされたユーザーはブロックしたユーザーのページ閲覧と機能実行ができない。

:large_orange_diamond: アイテム  
  &emsp;&nbsp;新規作成/表示/編集/削除

:large_orange_diamond: アイテムの絞り込み検索機能（Ransack)  
  &emsp;&ensp;TPO（どんな気分の時に着るのか） ⇨ デート・リラックス・スポーツ・おでかけ・仕事 から選択  
  &emsp;&ensp;Season（どの季節で着るのか) ⇨　春・夏・秋・冬　から選択  
  &emsp;&ensp;Rating（どの評価の服を選ぶのか)　⇨　1〜５の5段階から選択  
  &emsp;&ensp;Color（何色の服を着るのか） ⇨　14色対応  
  &emsp;&ensp;カテゴリー（どのカテゴリーの着るのか)　⇨　アウター・トップス・ボトムス・シューズ の4つから選択

:large_orange_diamond: コーディネート  
&emsp;&ensp;新規作成/表示/編集/削除

:large_orange_diamond: コーディネートの絞り込み検索機能（Ransack)  
  &emsp;&ensp;TPO（どんな気分の時に着るのか） ⇨ デート・リラックス・スポーツ・おでかけ・仕事 から選択  
  &emsp;&ensp;Season（どの季節で着るのか) ⇨　春・夏・秋・冬　から選択  
  &emsp;&ensp;Rating（どの評価の服を選ぶのか)　⇨　1〜５の5段階から選択

:large_orange_diamond: コーディネートいいね(Ajax) いいねボタン   
 &emsp;&ensp;新規作成/表示(コメントといいねしたユーザー表示)/削除

:large_orange_diamond: コメント（コーディネートへ)  
 &emsp;&ensp;新規作成/表示/削除

:large_orange_diamond: 通知(コメント・コーデへのいいね)  
&emsp;&ensp;新規作成/表示/削除


## ER図

<img width="980" alt="スクリーンショット 2021-05-03 11 43 39" src="https://user-images.githubusercontent.com/50302869/116837312-db0f6d00-ac04-11eb-8b45-cb922278510a.png">


## インフラ図


<img width="980" alt="スクリーンショット 2021-05-03 11 43 39" src="https://user-images.githubusercontent.com/50302869/116837312-db0f6d00-ac04-11eb-8b45-cb922278510a.png">


## Usersテーブル

|  Column  |  Type  |  Options  |
| ---- | ---- | ---- |
|   item_id |  integer  |    |
|  cordinate_id  |  integer   |    |
|  name  |  string   |  null: false  |
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
|  rating  |  float   |    |
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
|  rating  |  float   |  null: false  |
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
|  comment |  string  | null: false   |


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
|  action |  string  |    |
|  cordinate_id  |  integer   |    |
|  action  |  string   |    |
|  checked  |  boolean   |    |









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
:large_orange_diamond:
:small_red_triangle_down:
