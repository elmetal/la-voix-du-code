import Foundation
import Ignite

struct FootnoteArticleRenderer: ArticleRenderer {
    let title: String
    let description: String
    let body: String
    let removeTitleFromBody: Bool

    init(markdown: String, removeTitleFromBody: Bool) {
        self.removeTitleFromBody = removeTitleFromBody

        let processed = Self.extractFootnotes(from: markdown)
        let markdownWithReferences = Self.renderFootnoteReferences(
            in: processed.markdown,
            definitions: processed.definitions
        )

        let parser = MarkdownToHTML(
            markdown: markdownWithReferences,
            removeTitleFromBody: removeTitleFromBody
        )

        title = parser.title
        description = parser.description
        body = parser.body + Self.renderFootnotes(processed.definitions)
    }

    private static func extractFootnotes(from markdown: String) -> (markdown: String, definitions: [FootnoteDefinition]) {
        var bodyLines: [String] = []
        var definitions: [FootnoteDefinition] = []
        var currentDefinition: FootnoteDefinition?

        for line in markdown.split(separator: "\n", omittingEmptySubsequences: false).map(String.init) {
            if let match = line.firstMatch(of: #/^\[\^([A-Za-z0-9_-]+)\]:\s?(.*)$/#) {
                if let currentDefinition {
                    definitions.append(currentDefinition)
                }

                currentDefinition = FootnoteDefinition(
                    id: String(match.1),
                    markdown: String(match.2)
                )
            } else if var definition = currentDefinition, line.first?.isWhitespace == true {
                definition.markdown += "\n" + line.trimmingCharacters(in: .whitespaces)
                currentDefinition = definition
            } else {
                if let definition = currentDefinition {
                    definitions.append(definition)
                    currentDefinition = nil
                }

                bodyLines.append(line)
            }
        }

        if let currentDefinition {
            definitions.append(currentDefinition)
        }

        return (bodyLines.joined(separator: "\n"), definitions)
    }

    private static func renderFootnoteReferences(
        in markdown: String,
        definitions: [FootnoteDefinition]
    ) -> String {
        var footnoteNumbers: [String: Int] = [:]

        for (index, definition) in definitions.enumerated() {
            footnoteNumbers[definition.id] = index + 1
        }

        return markdown.replacing(#/\[\^([A-Za-z0-9_-]+)\]/#) { match in
            let id = String(match.1)

            guard let number = footnoteNumbers[id] else {
                return String(match.0)
            }

            return "<sub id=\"fnref-\(id)\"><a href=\"#fn-\(id)\">\(number)</a></sub>"
        }
    }

    private static func renderFootnotes(_ definitions: [FootnoteDefinition]) -> String {
        guard definitions.isEmpty == false else {
            return ""
        }

        let items = definitions.map { definition in
            let html = renderMarkdownFragment(definition.markdown)
            return "<li id=\"fn-\(definition.id)\">\(html) <a href=\"#fnref-\(definition.id)\">&#8617;</a></li>"
        }

        return #"<section class="footnotes"><hr /><ol>\#(items.joined())</ol></section>"#
    }

    private static func renderMarkdownFragment(_ markdown: String) -> String {
        let parser = MarkdownToHTML(markdown: markdown, removeTitleFromBody: true)
        let body = parser.body

        if body.hasPrefix("<p>"), body.hasSuffix("</p>"), body.contains("</p><p>") == false {
            return String(body.dropFirst(3).dropLast(4))
        } else {
            return body
        }
    }
}

private struct FootnoteDefinition {
    let id: String
    var markdown: String
}
