アプリケーションの概要



アプリケーショの機能一蘭



アプリケーションで使用している技術一覧





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
