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
    @Environment(\.site) private var site

    var body: some HTML {
        NavigationBar(logo: Link(site.name, target: site.sitePath(""))) {
            Link("Home", target: site.sitePath(""))
            Link("All posts", target: site.sitePath("tags"))
            Dropdown("Tags") {
                Link("Swift", target: site.sitePath("tags/swift"))
                Link("ぽこあポケモン", target: site.sitePath("tags/pokopia"))
            }
        }
        .navigationItemAlignment(.trailing)
        .padding(.bottom, .large)
    }
}
