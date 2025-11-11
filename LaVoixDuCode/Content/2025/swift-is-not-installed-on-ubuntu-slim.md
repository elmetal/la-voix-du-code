---
title: ubuntu-slimにSwiftが入っていなかった
date: 2025-11-10
description: 
tags: [Swift, Blog, GitHub Actions]
layout: BlogArticle
path: swift-is-not-installd-on-ubuntu-slim
---

# ubuntu-slimにSwiftが入っていなかった

GitHub Actionsの新しいランナー[`ubuntu-slim`](https://github.blog/changelog/2025-10-28-1-vcpu-linux-runner-now-available-in-github-actions-in-public-preview/)が発表されました。

このランナーでDocCのデプロイなどを置き換えたついでに、軽量な`swift test`も置き換えようとしました。

しかし、このランナーはSwiftが入っておらず、この目論見は外れたのでした。

