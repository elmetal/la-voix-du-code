//
//  ArticleLayout.swift
//  LaVoixDuCode
//  
//  Created by elmetal on 2025/09/24
//  
//

import Ignite

struct BlogArticle: ArticlePage {
    @Environment(\.articles) private var articles

    var body: some HTML {
        Text(article.title).font(.title1).padding(.vertical, 10)
        if let image = article.image {
            Image(image, description: article.imageDescription)
                .resizable().cornerRadius(16).frame(maxHeight: 320)
        }
        if let tags = article.tags {
            Text("Tags: " + tags.joined(separator: ", "))
                .foregroundStyle(.secondary)
        }
        Divider()
        RawHTML(article.text)
        ArticlePager(
            previousArticle: previousArticle,
            nextArticle: nextArticle
        )
        Footer()
    }

    private var currentArticleIndex: Int? {
        articles.all.firstIndex { $0.path == article.path }
    }

    private var previousArticle: Article? {
        guard let currentArticleIndex, currentArticleIndex < articles.all.index(before: articles.all.endIndex) else {
            return nil
        }

        return articles.all[currentArticleIndex + 1]
    }

    private var nextArticle: Article? {
        guard let currentArticleIndex, currentArticleIndex > articles.all.startIndex else {
            return nil
        }

        return articles.all[currentArticleIndex - 1]
    }
}

private struct RawHTML: HTML {
    let html: String

    var body: some HTML { self }
    var isPrimitive: Bool { true }

    init(_ html: String) {
        self.html = html
    }

    func markup() -> Markup {
        html.markup()
    }
}

private struct ArticlePager: HTML {
    @Environment(\.site) private var site

    let previousArticle: Article?
    let nextArticle: Article?

    var body: some HTML {
        if previousArticle != nil || nextArticle != nil {
            Divider()
            Section {
                if let previousArticle {
                    Link("← 前の記事: \(previousArticle.title)", target: site.sitePath(previousArticle.path))
                }
                if let nextArticle {
                    Link("次の記事: \(nextArticle.title) →", target: site.sitePath(nextArticle.path))
                }
            }
            .class("d-flex", "flex-column", "flex-md-row", "justify-content-between", "gap-3")
            .padding(.vertical, .large)
        }
    }
}

struct Footer: HTML {
    var body: some HTML {
        Divider()
        Text("© \(Date().formatted(.dateTime.year())) La voix du code")
            .foregroundStyle(.tertiary)
            .padding(.top, 40)
    }
}
