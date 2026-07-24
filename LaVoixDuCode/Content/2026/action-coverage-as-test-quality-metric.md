---
title: Actionのカバレッジをテスト品質指標に用いる
date: 2026-07-24
description:
tags: Swift, Testing, Blog
layout: BlogArticle
path: action-coverage-as-test-quality-metric
prettifyHTML: false
---

この記事は、[CYBOZU SUMMER BLOG FES '26](https://summer-blog-fes.cybozu.io/2026/)の記事です。

---

Claudeを使ってコードを書く際にはテストコードの品質が非常に重要です。  
私たちのチームでは、テストコードの品質指標を作成することでClaudeが自律的に判断できるようにしています。  
いくつかあるテスト品質指標のうち、カバレッジはわかりやすく計測も難しくないため取り入れやすいです。  

この記事ではTCAを採用している私たちが使っているActionのカバレッジを紹介します。

## なぜActionのカバレッジ？

Xcode が標準で計測する行カバレッジは、SwiftUI View の `body` プロパティも対象に含みます。  
また、Swift には LCOV の `LCOV_EXCL_START` に相当する行単位の除外マーカーがありません。  
ファイル単位の除外はできますが、ReducerとViewを同じファイルに書くスタイルだったため、コードの変更なしには実現できませんでした。  
SwiftUIのViewは直接テストしないものも多いでしょう。その際に行カバレッジを用いると、ノイズが多く意図に沿った結果が得られにくくなることがあります。

そこで、Actionに対するカバレッジに着目しました。

私たちのアプリではTCAを使って開発しています。TCAのActionには振る舞いが列挙されています。

```swift
@Reducer
struct ArticleList {
    enum Action {
        case onAppear
        case refreshPulled
        case articleTapped(Article.ID)
        case fetchCompleted(Result<[Article], Error>)
        case detail(ArticleDetail.Action)
        case binding(BindingAction<State>) 
        case delegate(DelegateAction)
    }
    // ...
}
```

この enum は閉じた集合です。  
ユーザー操作も、非同期処理の完了も、子フィーチャーからの通知も、Reducer に入るイベントは必ずこの enum のどれかの case です。case にないイベントは存在しません。

一方、TCA のテストでは `TestStore` に Action を送り、状態遷移と受けとる Action を検証します。

```swift
@Test
func refreshPulled_記事一覧が更新される() async {
    let store = TestStore(initialState: ArticleList.State()) {
        ArticleList()
    }
    await store.send(.refreshPulled) {
        $0.isLoading = true
    }
    await store.receive(\.fetchCompleted.success) {
        $0.isLoading = false
        $0.articles = [.stub]
    }
}
```

テストコードには Action 名がそのまま使われます。

よって、Source 側で `enum Action` の case を列挙し、Test 側で `store.send` / `store.receive` に現れる Action 名を抽出して突き合わせると、振る舞いのカバレッジが計算できます。

## カバレッジの計算

計算式は単純です。
```
対象 Action 数   = 全 Action case 数 − (子 Reducer 委譲 + binding)
カバレッジ       = テスト済み Action 数 / 対象 Action 数
```

## 例外ルールの設計

単純に全 case 数分のテスト済み case 数でも良かったのですが、いくつかチューニングをしています。

| カテゴリ | 例 | 扱い |
|---|---|---|
| 子 Reducer 委譲 | `case detail(ArticleDetail.Action)` | 子 Reducer 側の責務なので分母から除外 |
| binding | `case binding(BindingAction<State>)` | TCAのインフラなので分母から除外 |
| delegate | `case delegate(DelegateAction)` | 子の分母から除外し、親のテストでカバーされているかを見る |

特にdelegate Action は子が親に通知するためのもので、子の Reducer 自身は `.none` を返すだけの実装になりやすいです。  
そこで delegate は子の分母から除外し、親のテストで `store.receive` されていれば親側でカバー済みとみなすことにしました。  
責務を元にテストすることを前提に指標を設計しています。

## 閾値の設計

閾値は 3 段階にしています。

| カバレッジ | 判定 |
|---|---|
| 80% 以上 | 🟢 良好 |
| 50–79% | 🟡 注意 |
| 50% 未満 | 🔴 要改善 |

100%に設定していないのは意図的です。
例えばアニメーション完了通知などのUI通知系Actionの中にはテストの価値が薄いものがあるため、テストがない状態を許容できる設計にしています。

## 導入してわかったこと

この指標を導入した前後で、Claudeが書くテストのカバレッジは大幅に改善しました。  
また、既存コード(テスト数にして約620件)に対しても実施したところ、概ね`🟢 良好`だったものの`🔴 要改善`が3件検出されました。

この指標はTCA固有のものではなく、イベントが列挙される設計であれば同様に使えます。  
また、ビルドが不要で軽量に計測できるところもメリットです。

## おわりに

「振る舞いが列挙されている」という設計上の性質を、そのままテスト品質指標に変換したのがこの取り組みです。
同じような設計を採用しているチームであれば、Claude のテスト品質を安定させる手段としてぜひ試してみてください。
