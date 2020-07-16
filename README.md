# README

## 概要
農家と消費者を結びつけるアプリ

## 機能要件】
- ログイン機能(User,Producerの２つの視点でログインする)
  - プロフィール編集、削除ができる。
- 投稿機能(Producerとしてログインした時にのみ投稿できる)
  - 画像を添付して投稿ができる。
  - 投稿をデータベースに保存する。
- いいね機能
  - Producerの投稿に対して、Userがいいね、いいね解除ができる。
- コメント機能
  - Producerの投稿に対して、Userがコメント、コメント削除ができる。
- DM機能
- UserとProducer間で、DMが出来る
  - Userが商品詳細画面に行った時のみDMができる。Producer側としてログインした時は、「DMリスト」に、チャットしたことあるユーザー一覧が表示され、そこからProducerとDMが出来る。
## 環境
- Docker
- ruby 2.5
- rails 5.2.2
- mysql 5.7

## 使い方
1. リポジトリのクローン
2. docker-compose upで、webコンテナとrailsコンテナを立ち上げる
3. docker-compose run web rails db:create
4. docker-compose run web rails db:migrate でアプリが使えるようになります。

