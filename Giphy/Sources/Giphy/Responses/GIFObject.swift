import Foundation

struct GIFObject: Codable {
    let id: String
    let url: String
    let slug: String
    //    let bitlyGIFURL: String
    //    let bitlyURL: String
    //    let embedURL: String
    //    let username: String
    /// External source of GIF
    let source: String
    let title: String
    let rating: GiphyMPAARating?
    /// Top level domain displayable string of sourrce
    let sourceTLD: String
    let sourcePostURL: String
    //    let isSticker: Int
    let importDatetime, trendingDatetime: String
    let images: ImagesObject
    //    let user: UserObject?
    //    let analyticsResponsePayload: String
    //    let analytics: AnalyticsObject

    enum CodingKeys: String, CodingKey {
        //        case type,
        case id, url, slug
        //        case bitlyGIFURL = "bitly_gif_url"
        //        case bitlyURL = "bitly_url"
        //        case embedURL = "embed_url"
        //        case username
        case source, title, rating
        case sourceTLD = "source_tld"
        case sourcePostURL = "source_post_url"
        //        case isSticker = "is_sticker"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images
        //        case user
        //        case analyticsResponsePayload = "analytics_response_payload"
        //        case analytics
    }
}

public enum GiphyMPAARating: String, Codable {
    case y = "y"
    case g = "g"
    case pg = "pg"
    case pg13 = "pg-13"
    case r = "r"
}
