---
title: Styling with Liquid Glass Availability
date: 2025-10-03
description:
tags: [Swift, Liquid Glass, Blog]
layout: BlogArticle
path: ios26-styling-with-liquid-glass-availability
prettifyHTML: false
---

# Styling with Liquid Glass Availability

この記事は[CYBOZU SUMMER BLOG FES '25](https://cybozu.github.io/summer-blog-fes-2025/)の記事です。

---

iOS26では`Button`や`TextField`がLiquid Glassに対応するコンポーネントになりましたが、2025/10/03現在ではOSバージョンによる分岐が必要です。

しかしこの分岐はlayoutとstylingの問題で、SwiftUIコード上のセマンティックな部分は共通のため、View全体を分岐するのは避けたいところです。

この要求を満たすため、stylingの問題はView styleコードの中に押し込めると、既存のコードとも適合します。

### TextFieldStyle

`TextFieldStyle`は`configuration`がそのまま`TextField`になっているため、シンプルです。

```swift
struct MyGlassTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        if #available(iOS 26.0, *) {
            configuration
                .padding(8)
                .glassEffect()
        } else {
            configuration
                .textFieldStyle(.roundedBorder)
        }
    }
}
```

### ButtonStyle

`ButtonStyle`は`TextFieldStyle`より少し複雑です。

既存のボタンの多くはbuilt-inもしくはユーザー定義の`ButtonStyle`が活用されていると思いますが、`configuration`は`ButtonStyleConfiguration`のため、`TextFieldStyle`のようなstyleの中では適用されません。

```swift
@available(iOS 26.0, *)
struct MyGlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(8)
            .glassEffect()
    }
}

struct MyGlassButton: ViewModifier {
    var fallBack: FallBack
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .buttonStyle(MyGlassButtonStyle())
        } else {
            content
                .buttonStyle(.myButtonStyle)
        }
    }
}

extension View {
    func myGlassButton() -> some View {
        self.modifier(MyGlassButton())
    }
}
```

これを`Button`に適用します。


```swift
struct MyButton: View {
    var body: some View {
        Button("Tap me") { print("hello") }
            .myGlassButton()
    }
}
```
