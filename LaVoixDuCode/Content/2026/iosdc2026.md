---
title: iOSDC Japan 2026に参加しました
date: 2026-09-15
description: 
tags: Swift, Blog, iOSDC
layout: BlogArticle
path: iosdc2026
---

iOSDC Japan 2026に参加しました。

2本登壇することになり、今までで一番大変でした。

## day0
ブースの設営を確認した後、主にブースを周回していました。

その場にいた同僚と食事に行き、ホテルに帰った後は翌日のセッションの内容を調整していました。

## day1
自分のセッションのことで頭が支配されていました。

ブースで交流しつつ、もくもくエリアでスライドを調整しつつ、自分のセッションのタイムテーブルとApple Watchを交互に見つつ、といった感じでそわそわした過ごし方をしていました。

### 2Dモーショングラフィクスを空間体験へ翻訳する
[fortee](https://fortee.jp/iosdc-japan-2026/proposal/9dd82415-1e4e-494e-bef0-77080437056e)  
すごく面白い取り組みで空間の演出に感動しました。動画でもう一回復習したい。

### プロダクトコードからライブラリの境界を見つける 〜「ほかでも使えそう」を、公開できるSwift Packageへ再設計するまで〜
[fortee](https://fortee.jp/iosdc-japan-2026/proposal/5e9d7bee-6839-4eb9-b78f-33a156f63bbb)  
サイボウズで既存のコードからライブラリ化する過程でどんなことをやっているのか紹介しました。

このブログを書いていて気づいたのですが、ライブラリ化された後プロダクトコードがライブラリを利用する形に移行する話が揃って初めて全体が共通ライブラリを利用する形になりますね。　　
その話はどこかでまたご紹介できればと思います。

Q&Aでコントリビューションポリシーの話題が出て、勉強になりました。  
[swift-configurationのCONTRIBUTING.md](https://github.com/apple/swift-configuration/blob/main/CONTRIBUTING.md)

### SwiftUI Text Rendering Deep Dive ~Text("\(price)") がピクセルになるまで~
[fortee](https://fortee.jp/iosdc-japan-2026/proposal/e17a5523-ef89-4ca8-a859-a2a99caeeaf5)
`Text`は基本的な`View`の割に、周辺で非常に多くの仕組みが動いていて、何かカスタムしたいと思った時に良い選択をするのが難しいと感じていました。

トークでは登場人物の紹介と全体像の提示はできましたが、もう少し詳細な話を入れても良かったと感じているのでまた何かできればと思います。

## day2
前日で自分のセッションが終わって解放されたので、気になっていたトークを見たり押せてなかったスタンプを押したりしていました。

スタンプカードはほぼ揃ったのですが、抽選が終わってしまって間に合いませんでした。ガチャ間に合わなかった。

### モジュールの視点からSwiftを読み解く
[fortee](https://fortee.jp/iosdc-japan-2026/proposal/08515687-40e9-4fed-adb4-f7b99bc02a93)  
この時間は魅力的なトークが多く迷ったのですが当日はこちらを聞きました。

Swiftのモジュールについてとてもよくまとめられており、学びが多かったです。  
Xでコード公開前提で適当につぶやいていたら、非常に良い補足が差し込まれQ&Aに持って行かれたのが良かったです。  

### Heart of Swift Concurrency
[fortee](https://fortee.jp/iosdc-japan-2026/proposal/a82899ff-52ef-4906-85d6-20137312bcd3)  
Heart ofシリーズでSwift Concurrencyがどのような形で扱われるのか気になっていました。

実際にトークを聞いていて、Concurrencyで迷っている方にまずおすすめしたい内容だと思いました。

## 感想
今年も無事参加できました。  
来年も登壇できるよう一年間精進したいなと思います。
