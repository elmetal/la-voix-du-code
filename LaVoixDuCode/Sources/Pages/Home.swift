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
                Text {
                    Link(article)
                }
            }
        }
        .padding(.vertical, .large)
    }
}
