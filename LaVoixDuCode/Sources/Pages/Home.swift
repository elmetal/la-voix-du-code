import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"
    
    @Environment(\.articles) private var articles
    
    var body: some HTML {
        Text("La voix du code")
            .font(.title1)
        
        Section {
            Text("Latest posts").font(.title2)
            ForEach(articles.all) { article in
                HStack {
                    Text(article.date.formatted(Date.FormatStyle().year(.defaultDigits).month(.twoDigits).day(.twoDigits)))
                    Text { Link(article) }
                }
            }
        }
        .padding(.vertical, .large)
        
        Section {
            List {
                Link("Tag: Swift", target: "/la-voix-du-code/tags/swift")
                Link("All tags", target: "/la-voix-du-code/tags")
            }
        }
    }
}
