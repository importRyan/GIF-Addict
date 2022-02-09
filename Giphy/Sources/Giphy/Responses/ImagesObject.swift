import Foundation

struct ImagesObject: Codable {
    let original: WebPMP4
    //    let downsized, downsizedLarge, downsizedMedium: WEBP
    //    let downsizedSmall: MP4
    //    let downsizedStill: WEBP
    let fixedHeight: WebPMP4
//    let fixedHeightDownsampled: WebPMP4
//    let fixedHeightSmall: WebPMP4
    //    let fixedHeightSmallStill, fixedHeightStill: WEBP
    //    let fixedWidth, fixedWidthDownsampled, fixedWidthSmall: WebPMP4
    //    let fixedWidthSmallStill, fixedWidthStill: WEBP
    //    let looping: LoopingMP4
    //    let originalStill: WEBP
    //    let originalMp4: MP4
    //    let preview: MP4
    //    let previewGIF, previewWebp, the480WStill: WEBP
    //    let hd: MP4?

    enum CodingKeys: String, CodingKey {
        case original
        //        case downsized
        //        case downsizedLarge = "downsized_large"
        //        case downsizedMedium = "downsized_medium"
        //        case downsizedSmall = "downsized_small"
        //        case downsizedStill = "downsized_still"
        case fixedHeight = "fixed_height"
//        case fixedHeightDownsampled = "fixed_height_downsampled"
//        case fixedHeightSmall = "fixed_height_small"
        //        case fixedHeightSmallStill = "fixed_height_small_still"
        //        case fixedHeightStill = "fixed_height_still"
        //        case fixedWidth = "fixed_width"
        //        case fixedWidthDownsampled = "fixed_width_downsampled"
        //        case fixedWidthSmall = "fixed_width_small"
        //        case fixedWidthSmallStill = "fixed_width_small_still"
        //        case fixedWidthStill = "fixed_width_still"
        //        case looping
        //        case originalStill = "original_still"
        //        case originalMp4 = "original_mp4"
        //        case preview
        //        case previewGIF = "preview_gif"
        //        case previewWebp = "preview_webp"
        //        case the480WStill = "480w_still"
        //        case hd
    }
}

struct WEBP: Codable {
    let height, width, size: String
    let url: String
}

struct MP4: Codable {
    let height, width, mp4Size: String
    let mp4: String

    enum CodingKeys: String, CodingKey {
        case height, width
        case mp4Size = "mp4_size"
        case mp4
    }
}

struct WebPMP4: Codable {
    let height, width, size: String
    let url: String
    //    let mp4Size: String?
    let mp4: String?
    //    let webpSize: String?
    //    let webp: String?
    //    let frames, hash: String?

    enum CodingKeys: String, CodingKey {
        case height, width, size, url
        //        case mp4Size = "mp4_size"
        case mp4
        //        case webpSize = "webp_size"
        //        case webp, frames, hash
    }
}

struct LoopingMP4: Codable {
    let mp4Size: String
    let mp4: String

    enum CodingKeys: String, CodingKey {
        case mp4Size = "mp4_size"
        case mp4
    }
}
