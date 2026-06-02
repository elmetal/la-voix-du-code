import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"
    
    @Environment(\.articles) private var articles
    @Environment(\.site) private var site
    
    var body: some HTML {
        Text("La voix du code")
            .font(.title1)
        
        Section {
            Text("Latest posts").font(.title2)
            ForEach(articles.all) { article in
                HStack {
                    Text(article.date.formatted(Date.FormatStyle().year(.defaultDigits).month(.twoDigits).day(.twoDigits)))
                    Text {
                        Link(article.title, target: site.sitePath(article.path))
                    }
                }
            }
        }
        .padding(.vertical, .large)
        
        Section {
            List {
                Link("Tag: Swift", target: site.sitePath("tags/swift"))
                Link("All posts", target: site.sitePath("tags"))
            }
        }
    }
}
