import Foundation
import Ignite

struct MainLayout: Layout {
    var body: some Document {
        Body {
            SiteNavigation()
            content
            IgniteFooter()
        }
    }
}

private struct SiteNavigation: HTML {
    @Environment(\.articles) private var articles
    @Environment(\.site) private var site

    private var tags: [String] {
        Set(articles.all.compactMap(\.tags).flatMap(\.self)).sorted()
    }

    var body: some HTML {
        NavigationBar(logo: Link(site.name, target: site.sitePath(""))) {
            Link("Home", target: site.sitePath(""))
            Link("All posts", target: site.sitePath("tags"))
            Dropdown("Tags") {
                for tag in tags {
                    Link(tag, target: site.sitePath("tags/\(tag.convertedToSlug())"))
                }
            }
            Link(Label("GitHub", systemImage: "github"), target: "https://github.com/elmetal/la-voix-du-code")
                .target(.blank)
                .relationship(.external, .noOpener)
        }
        .navigationItemAlignment(.trailing)
        .padding(.bottom, .large)
    }
}
