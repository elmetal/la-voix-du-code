//
//  Tags.swift
//  LaVoixDuCode
//  
//  Created by elmetal on 2025/11/11
//  
//

import Foundation
import Ignite

struct Tags: TagPage {
    var body: some HTML {
        Text(tag.name)
            .font(.title1)

        Section {
            VStack(alignment: .leading) {
                ForEach(tag.articles) { article in
                    HStack {
                        Text(article.date.formatted(Date.FormatStyle().year(.defaultDigits).month(.twoDigits).day(.twoDigits)))
                        Text { Link(article) }
                    }
                }
            }
        }
    }
}
