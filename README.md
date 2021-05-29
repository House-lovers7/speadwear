
##  :octocat: 制作背景

**テンションがアガル**服に袖を通して1日を過ごしたい。 いまあるクローゼットの中から季節・気分・TPOに合わせたコーディネートを選んでファッションを楽しみたい。でも、服選びに時間をかけたくない。そんなワガママを叶えるためにアプリを作成しました。 100人いたら、100通りの個性と好きなファッションがある、そんな個性を尊重していきたい.

[Qiitaの詳細説明はこちら!!](https://qiita.com/House-lovers7/private/c74c584d9c9dcfba18a8)


## :memo: 要件定義とアイディア出し
服を選ぶ時の重要な要素を考えてみました。
さぁ外出しようかという時、何を考えて服を選んでいるか振り返りました:pencil2:

大きく3つに分けられます。

- 人からどう見られるか：**客観軸**
- 自分が好きな服かどうか：**主観軸**
- 動きやすさ・重さ・着心地：**機能軸**

**衣替え**という言葉があるように、機能軸は先人の知恵に従い、季節にあった服を着れば満たせると考えました。
客観軸と主観軸には、**TPO**という便利な言葉があリます。時と場合によって私たちは服を選んでいます。
[マインド・マップを使い、アイディアの展開・深堀・整理しました。](https://www.mindmeister.com/ja/1401463492/_ )

やりたいことを発散させた後は、技術的にできるできない問題があり、(未経験の初学者であるため）、現実と折り合いをつけて、
[ブラッシュアップした結果です。](https://www.mindmeister.com/ja/1405225759/brush-up)

学習しながら、データベースの設計を考えて行き着いた
[最終結果です。](https://www.mindmeister.com/ja/1515140019/model-2021)


## :keyboard:使用技術

- Rails 5.1.6  
- DB: Mysql 8.0.23  
- AWS(EC2, Elastic IP, RDS, Route53, VPC, IAM )  
- API:[OpenWeather](https://openweathermap.org/api)  
- Docker（Dockerfile, docker-compose.yml)  
- HTML  
- CSS  
- Javascript  
- Capistrano 


## :key: ER図

<img width="980" alt="スクリーンショット 2021-05-03 11 43 39" src="https://user-images.githubusercontent.com/50302869/116837312-db0f6d00-ac04-11eb-8b45-cb922278510a.png">


## :bell: インフラ図

![スクリーンショット 2021-05-26 17 11 02](https://user-images.githubusercontent.com/50302869/119625801-8f3b9680-be45-11eb-94ea-b6db8ab5e588.png)


## :black_nib: 機能一覧

:small_red_triangle_down: ユーザー  
  &emsp;&ensp;メール認証  
  &emsp;&ensp;新規作成/表示/編集/削除

:small_red_triangle_down: フォロー&アンフォロー(Relationモデル)  
  &emsp;&ensp;新規作成(フォロー)/削除（アンフォロー)  
  &emsp;&ensp;権限管理(フォローしているユーザーのみ相手のコーディネートが提案できる)

:small_red_triangle_down: ブロック  
  &emsp;&ensp;新規作成(ブロック)/削除（ブロック解除)  
  &emsp;&ensp;ブロックされたユーザーはブロックしたユーザーのページ閲覧と機能実行ができない。

:small_red_triangle_down: アイテム  
  &emsp;&nbsp;新規作成/表示/編集/削除

:small_red_triangle_down: アイテムの絞り込み検索機能（Ransack)  
  &emsp;&ensp;TPO（どんな気分の時に着るのか） ⇨ デート・リラックス・スポーツ・おでかけ・仕事 から選択  
  &emsp;&ensp;Season（どの季節で着るのか) ⇨　春・夏・秋・冬　から選択  
  &emsp;&ensp;Rating（どの評価の服を選ぶのか)　⇨　1〜５の5段階から選択  
  &emsp;&ensp;Color（何色の服を着るのか） ⇨　14色対応  
  &emsp;&ensp;カテゴリー（どのカテゴリーの着るのか)　⇨　アウター・トップス・ボトムス・シューズ の4つから選択

:small_red_triangle_down: コーディネート  
&emsp;&ensp;新規作成/表示/編集/削除

:small_red_triangle_down: コーディネートの絞り込み検索機能（Ransack)  
  &emsp;&ensp;TPO（どんな気分の時に着るのか） ⇨ デート・リラックス・スポーツ・おでかけ・仕事 から選択  
  &emsp;&ensp;Season（どの季節で着るのか) ⇨　春・夏・秋・冬　から選択  
  &emsp;&ensp;Rating（どの評価の服を選ぶのか)　⇨　1〜５の5段階から選択

:small_red_triangle_down: コーディネートいいね(Ajax) いいねボタン   
 &emsp;&ensp;新規作成/表示(コメントといいねしたユーザー表示)/削除

:small_red_triangle_down: コメント（コーディネートへ)  
 &emsp;&ensp;新規作成/表示/削除

:small_red_triangle_down: 通知(コメント・コーデへのいいね)  
&emsp;&ensp;新規作成/表示/削除





## 📉 機能の動画説明


![アイテム作成・表示](https://gyazo.com/dda1237d317e6712c6772cc005724f78/raw)
<div style="text-align: center;">アイテム作成・表示機能</div>

***

![アイテム編集](https://gyazo.com/9cd6d7641f705073b7fb4334659c6901/raw)
<div style="text-align: center;">アイテム編集機能</div>

***

![コーディネートの作成](https://gyazo.com/a6d546ffa1f94c3189603235842d5d2a/raw)
<div style="text-align: center;">コーディネートの作成機能</div>

***

![アイテムとコーデの絞り込み検索機能](https://gyazo.com/4a4edcf0464530f8e52532e2d68b97cd/raw)
<div style="text-align: center;">アイテムとコーデの絞り込み検索機能</div>

***

![コーデへのいいね機能](https://gyazo.com/ed6e7969c498d4ae9339ce3b2a28cce3/raw)
<div style="text-align: center;">コーデへのいいね機能</div>

***

![ブロック機能](https://gyazo.com/0f6e0ca72797c5a446802e99bfd6ab25/raw)
<div style="text-align: center;">ブロック機能</div>

***


![通知機能](https://gyazo.com/0d4ff92b11b66a4520b11f961bd774e1/raw)
<div style="text-align: center;">通知機能</div>

***

![Friendメソッドのテスト：前編](https://gyazo.com/5ba9ed0cc381cf638bee948c671e12ed/raw)
<div style="text-align: center;">コメント機能（フォローされてない）状態の時</div>

***

![Friendメソッドのテスト：後編](https://gyazo.com/b76beff6a1d56d503868617ad42097c9/raw)
<div style="text-align: center;">コメント機能（フォローされている）状態の時</div>

***


## :pushpin: テーブル詳細



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
:four_leaf_clover:
:bell:
:paperclip:
:information_source:
:heavy_check_mark:
:link:
:large_blue_diamond:
:large_orange_diamond:
:small_red_triangle_down:
