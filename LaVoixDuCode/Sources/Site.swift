import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        var site = Blog()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Blog: Site {
    var name = "La voix du code"
//    var titleSuffix = " – My Awesome Site"
    var url = URL(static: "https://elmetal.github.io/la-voix-du-code/")
    var builtInIconsEnabled = true

    var author = "elmetal"

    var homePage = Home()
    var layout = MainLayout()
    var articlePages: [any ArticlePage] { BlogArticle() }
}
