//
//  ArticleLayout.swift
//  LaVoixDuCode
//  
//  Created by elmetal on 2025/09/24
//  
//

import Ignite

struct BlogArticle: ArticlePage {
    var body: some HTML {
        Text(article.title).font(.title1).padding()
        if let image = article.image {
            Image(image, description: article.imageDescription)
                .resizable().cornerRadius(16).frame(maxHeight: 320)
        }
        if let tags = article.tags {
            Text("Tags: " + tags.joined(separator: ", "))
                .foregroundStyle(.secondary)
        }
        Divider()
        Text(article.text)
        Footer()
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
