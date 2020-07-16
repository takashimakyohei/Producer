# README

## 概要
農家と消費者を結びつけるアプリ

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

