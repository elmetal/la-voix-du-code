---
title: WWDC26 - TabRole: prominentの感想 
date: 2026-06-10
description:
tags: WWDC, WWDC26, SwiftUI
layout: BlogArticle
path: wwdc26-tabrole-prominent-thoughts
---

WWDC26で`TabRole`に新しいAPI`prominent`ができると発表されました。

[prominent | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/tabrole/prominent)


さて、このビジュアルで果たしてTabと認識できるでしょうか？

Floating Action Button(FAB)が既にデザインイディオムとして成立している中で、このビジュアルでprominent roleの`Tab`がTabファミリーと認知されることを期待するのは無理があると思います。  
一つだけラベルが無く他タブと要素が異なりますし、目立たせるために距離も離されています。

HIGにも
> Use a tab bar to support navigation, not to provide actions.

とあります[^1]が、このビジュアルではアクションを期待されるでしょう。

ディベロッパーも認識せずにアクションを提供してしまいそうですし、守れないガイドラインでは実効性を保てません。

Tabと認知されるために、せめてラベルは必要だと思います。

[^1]: [Tab bars | Apple Developer Documentation](https://developer.apple.com/design/human-interface-guidelines/tab-bars)
