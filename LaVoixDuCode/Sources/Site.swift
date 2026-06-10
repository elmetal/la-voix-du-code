import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        var site = Blog()

        do {
            try await site.publish()
            // Work around Ignite's subsite script paths until Script uses assetPath().
            try PublishedScriptPaths.fix(in: "Build", basePath: site.url.path)
        } catch {
            print(error.localizedDescription)
        }
    }
}

private enum PublishedScriptPaths {
    static func fix(in buildDirectory: String, basePath: String) throws {
        let basePath = normalized(basePath)

        guard basePath.isEmpty == false else {
            return
        }

        let buildDirectoryURL = URL(fileURLWithPath: buildDirectory)

        guard let files = FileManager.default.enumerator(
            at: buildDirectoryURL,
            includingPropertiesForKeys: nil
        ) else {
            return
        }

        for case let fileURL as URL in files where fileURL.pathExtension == "html" {
            let html = try String(contentsOf: fileURL, encoding: .utf8)
            let fixedHTML = html.replacingOccurrences(
                of: #"src="/js/"#,
                with: #"src="\#(basePath)/js/"#
            )

            if fixedHTML != html {
                try fixedHTML.write(to: fileURL, atomically: true, encoding: .utf8)
            }
        }
    }

    private static func normalized(_ path: String) -> String {
        let components = path.split(separator: "/")
        return components.isEmpty ? "" : "/" + components.joined(separator: "/")
    }
}

struct Blog: Site {
    var name = "La voix du code"
//    var titleSuffix = " – My Awesome Site"
    var url = URL(static: "https://elmetal.github.io/la-voix-du-code/")
    var builtInIconsEnabled = true

    var author = "elmetal"

    var homePage = Home()
    var tagPage = Tags()
    var layout = MainLayout()
    var articlePages: [any ArticlePage] { BlogArticle() }
    var articleRenderer: FootnoteArticleRenderer.Type { FootnoteArticleRenderer.self }
    var prettifyHTML = false
}
