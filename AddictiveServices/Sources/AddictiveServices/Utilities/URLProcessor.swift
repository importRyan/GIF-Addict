import Foundation

public typealias DefaultURLProcessor = DirtyGiphyURLProcessor

public protocol URLProcessor {
    func getURL() -> URL?
    init(url: URL?)
}

public struct DirtyGiphyURLProcessor: URLProcessor {

    public  func getURL() -> URL? {
        processURL(url: sourceURL)
    }

    public init(url: URL?) {
        self.sourceURL = url
    }

    private var sourceURL: URL?
}

private extension DirtyGiphyURLProcessor {

    func processURL(url: URL?) -> URL? {
        guard let url = url else { return nil }
        guard hasHTTPPScheme(url) else {
            return recoverWhenLackingHTTPS(url)
        }
        return url
    }

    func recoverWhenLackingHTTPS(_ url: URL) -> URL? {
        if isRecoverableRedditURL(url) {
            return recoverRedditShorthand(url)
        } else {
            let recovery = URL(string: "http://\(url.absoluteString)")
            return processURL(url: recovery)
        }
    }

    func isRecoverableRedditURL(_ url: URL) -> Bool {
        url.absoluteString.prefix(3) == "/r/"
    }

    func recoverRedditShorthand(_ url: URL) -> URL? {
        URL(string: "https://www.reddit.com\(url.absoluteString)")
    }

    func hasHTTPPScheme(_ url: URL) -> Bool {
        url.scheme == "http" || url.scheme == "https"
    }
}
