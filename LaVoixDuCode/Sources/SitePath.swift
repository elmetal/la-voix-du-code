import Foundation
import Ignite

extension SiteMetadata {
    func sitePath(_ path: String) -> String {
        let basePath = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        let contentPath = path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))

        if basePath.isEmpty {
            return contentPath.isEmpty ? "/" : "/\(contentPath)"
        } else if contentPath.isEmpty {
            return "/\(basePath)"
        } else {
            return "/\(basePath)/\(contentPath)"
        }
    }
}
