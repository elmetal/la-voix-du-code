import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"
    
    @Environment(\.articles) private var articles
    @Environment(\.site) private var site
    
    var body: some HTML {
        Section {
            Text("Latest posts").font(.title1)
            ForEach(articles.all.prefix(upTo: 5)) { article in
                HStack {
                    Text(article.date.formatted(Date.FormatStyle().year(.defaultDigits).month(.twoDigits).day(.twoDigits).locale(Locale(identifier: "ja_JP"))))
                        .class("font-monospace")
                    Text {
                        Link(article.title, target: site.sitePath(article.path))
                    }
                }
            }
        }
        .padding(.vertical, .large)
    }
}
