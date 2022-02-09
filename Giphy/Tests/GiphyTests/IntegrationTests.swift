import Combine
import XCTest
import Giphy

final class IntegrationTests: XCTestCase {

    // TODO: - Use GiphyMockDataTaskService

    func testParses_ValidJSON() {
        let mock = GiphyMockDataTaskService()
        mock.sendData = jsonA.data(using: .utf8)!
        var subs = Set<AnyCancellable>()
        let exp = XCTestExpectation()
        let sut = GiphyService(key: testAPIKey, dataTaskService: mock)

        sut
            .search(.init())
            .sinkAssertNoError(completesExp: exp) { result in
                XCTAssertEqual(result.gifs.count, 1)
                XCTAssertEqual(result.gifs.first?.title, "art flying GIF by Nelson Diaz")
                XCTAssertEqual(result.startIndex, 0)
                XCTAssertEqual(result.resultsCount, 932)
            }
            .store(in: &subs)

        wait(for: [exp], timeout: timeout)
    }

    func testParses_ProblematicJSON() {
        XCTExpectFailure()
        let mock = GiphyMockDataTaskService()
        mock.sendData = crashingJsonB.data(using: .utf8)!
        var subs = Set<AnyCancellable>()
        let exp = XCTestExpectation()
        GiphyService(key: testAPIKey, dataTaskService: mock).search(.init())
            .sinkAssertNoError(completesExp: exp) { result in

            }
            .store(in: &subs)
        
        wait(for: [exp], timeout: timeout)
    }
}


let jsonA = """
{"data":[{"type":"gif","id":"cnp5B63gSse2c","url":"https://giphy.com/gifs/nelsart-art-nelson-diaz-cnp5B63gSse2c","slug":"nelsart-art-nelson-diaz-cnp5B63gSse2c","bitly_gif_url":"http://gph.is/1f0FMkt","bitly_url":"http://gph.is/1f0FMkt","embed_url":"https://giphy.com/embed/cnp5B63gSse2c","username":"nelsart","source":"http://nelsart.tumblr.com/post/78150072482/last-post-of-the-month-have-a-happy-friday-nels","title":"art flying GIF by Nelson Diaz","rating":"g","content_url":"","source_tld":"nelsart.tumblr.com","source_post_url":"http://nelsart.tumblr.com/post/78150072482/last-post-of-the-month-have-a-happy-friday-nels","is_sticker":0,"import_datetime":"2014-02-28 23:23:00","trending_datetime":"1970-01-01 00:00:00","images":{"original":{"height":"400","width":"550","size":"430669","url":"https://media2.giphy.com/media/cnp5B63gSse2c/giphy.gif?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=giphy.gif&ct=g","mp4_size":"266592","mp4":"https://media2.giphy.com/media/cnp5B63gSse2c/giphy.mp4?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=giphy.mp4&ct=g","webp_size":"452198","webp":"https://media2.giphy.com/media/cnp5B63gSse2c/giphy.webp?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=giphy.webp&ct=g","frames":"40","hash":"6bdf38bc26b547454f9b12d7a89bd72b"},"fixed_height":{"height":"200","width":"275","size":"213009","url":"https://media2.giphy.com/media/cnp5B63gSse2c/200.gif?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200.gif&ct=g","mp4_size":"130600","mp4":"https://media2.giphy.com/media/cnp5B63gSse2c/200.mp4?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200.mp4&ct=g","webp_size":"193142","webp":"https://media2.giphy.com/media/cnp5B63gSse2c/200.webp?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200.webp&ct=g"},"fixed_height_downsampled":{"height":"200","width":"275","size":"33633","url":"https://media2.giphy.com/media/cnp5B63gSse2c/200_d.gif?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200_d.gif&ct=g","webp_size":"30718","webp":"https://media2.giphy.com/media/cnp5B63gSse2c/200_d.webp?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200_d.webp&ct=g"},"fixed_height_small":{"height":"100","width":"138","size":"93807","url":"https://media2.giphy.com/media/cnp5B63gSse2c/100.gif?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=100.gif&ct=g","mp4_size":"54624","mp4":"https://media2.giphy.com/media/cnp5B63gSse2c/100.mp4?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=100.mp4&ct=g","webp_size":"81558","webp":"https://media2.giphy.com/media/cnp5B63gSse2c/100.webp?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=100.webp&ct=g"},"fixed_width":{"height":"145","width":"200","size":"147307","url":"https://media2.giphy.com/media/cnp5B63gSse2c/200w.gif?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200w.gif&ct=g","mp4_size":"88918","mp4":"https://media2.giphy.com/media/cnp5B63gSse2c/200w.mp4?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200w.mp4&ct=g","webp_size":"131090","webp":"https://media2.giphy.com/media/cnp5B63gSse2c/200w.webp?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200w.webp&ct=g"},"fixed_width_downsampled":{"height":"145","width":"200","size":"23167","url":"https://media2.giphy.com/media/cnp5B63gSse2c/200w_d.gif?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200w_d.gif&ct=g","webp_size":"20266","webp":"https://media2.giphy.com/media/cnp5B63gSse2c/200w_d.webp?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=200w_d.webp&ct=g"},"fixed_width_small":{"height":"73","width":"100","size":"62248","url":"https://media2.giphy.com/media/cnp5B63gSse2c/100w.gif?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=100w.gif&ct=g","mp4_size":"34946","mp4":"https://media2.giphy.com/media/cnp5B63gSse2c/100w.mp4?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=100w.mp4&ct=g","webp_size":"53580","webp":"https://media2.giphy.com/media/cnp5B63gSse2c/100w.webp?cid=5ce88d366k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69&rid=100w.webp&ct=g"}},"user":{"avatar_url":"https://media1.giphy.com/avatars/nelsart/bUTGfpXdwXSO.gif","banner_image":"","banner_url":"","profile_url":"https://giphy.com/nelsart/","username":"nelsart","display_name":"Nelson Diaz","description":"Animation | Illustrator from Brooklyn, NY. Animation Supervisor at There Be Dragons Creative Media.","instagram_url":"https://instagram.com/@nelsfarts","website_url":"http://www.nelsart.com","is_verified":true},"analytics_response_payload":"e=Z2lmX2lkPWNucDVCNjNnU3NlMmMmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNjZrN2cwaTRsa2d2Ymh6Z3dtdGp4azVkMWs2M2pmeWticHludmtiNjkmY3Q9Zw","analytics":{"onload":{"url":"https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWNucDVCNjNnU3NlMmMmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNjZrN2cwaTRsa2d2Ymh6Z3dtdGp4azVkMWs2M2pmeWticHludmtiNjkmY3Q9Zw&action_type=SEEN"},"onclick":{"url":"https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWNucDVCNjNnU3NlMmMmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNjZrN2cwaTRsa2d2Ymh6Z3dtdGp4azVkMWs2M2pmeWticHludmtiNjkmY3Q9Zw&action_type=CLICK"},"onsent":{"url":"https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWNucDVCNjNnU3NlMmMmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNjZrN2cwaTRsa2d2Ymh6Z3dtdGp4azVkMWs2M2pmeWticHludmtiNjkmY3Q9Zw&action_type=SENT"}}}],"pagination":{"total_count":932,"count":1,"offset":0},"meta":{"status":200,"msg":"OK","response_id":"6k7g0i4lkgvbhzgwmtjxk5d1k63jfykbpynvkb69"}}
"""

let crashingJsonB = """
{
  "data": [
    {
      "type": "gif",
      "id": "l0HlxB64LOpt3E8OQ",
      "url": "https://giphy.com/gifs/rain-skeleton-flood-l0HlxB64LOpt3E8OQ",
      "slug": "rain-skeleton-flood-l0HlxB64LOpt3E8OQ",
      "bitly_gif_url": "http://gph.is/2aLvBmR",
      "bitly_url": "http://gph.is/2aLvBmR",
      "embed_url": "https://giphy.com/embed/l0HlxB64LOpt3E8OQ",
      "username": "jjjjjohn",
      "source": "http://jjjjjjjjjjohn.tumblr.com/post/124381301745",
      "title": "flood leak GIF by jjjjjohn",
      "rating": "g",
      "content_url": "",
      "source_tld": "jjjjjjjjjjohn.tumblr.com",
      "source_post_url": "http://jjjjjjjjjjohn.tumblr.com/post/124381301745",
      "is_sticker": 0,
      "import_datetime": "2016-08-02 22:07:42",
      "trending_datetime": "1970-01-01 00:00:00",
      "images": {
        "original": {
          "height": "540",
          "width": "540",
          "size": "1159216",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "309340",
          "mp4": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "440920",
          "webp": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "23",
          "hash": "0d8ddc18aa649ce6dfae1f6d4bc93f33"
        },
        "downsized": {
          "height": "540",
          "width": "540",
          "size": "1159216",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "540",
          "width": "540",
          "size": "1159216",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "540",
          "width": "540",
          "size": "1159216",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "368",
          "width": "368",
          "mp4_size": "103160",
          "mp4": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "540",
          "width": "540",
          "size": "1159216",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "245882",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "81202",
          "mp4": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "106268",
          "webp": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "64920",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "37846",
          "webp": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "74293",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "30439",
          "mp4": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "43406",
          "webp": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "4022",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "11868",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "245882",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "81202",
          "mp4": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "106268",
          "webp": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "64920",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "37846",
          "webp": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "74293",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "30439",
          "mp4": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "43406",
          "webp": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "4022",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "11868",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1693001",
          "mp4": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "540",
          "width": "540",
          "size": "79947",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "309340",
          "mp4": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "284",
          "width": "284",
          "mp4_size": "42395",
          "mp4": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "87",
          "width": "87",
          "size": "49249",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "208",
          "width": "208",
          "size": "46836",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "1159216",
          "url": "https://media0.giphy.com/media/l0HlxB64LOpt3E8OQ/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/jjjjjohn/BhAd8YA6kvsp.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/jjjjjohn/",
        "username": "jjjjjohn",
        "display_name": "jjjjjohn",
        "description": "homemade CGI :)",
        "instagram_url": "https://instagram.com/jjjjjohn",
        "website_url": "http://jjjjjjjjjjohn.tumblr.com/",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPWwwSGx4QjY0TE9wdDNFOE9RJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwwSGx4QjY0TE9wdDNFOE9RJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwwSGx4QjY0TE9wdDNFOE9RJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwwSGx4QjY0TE9wdDNFOE9RJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "l2YOy09UFUZWu71Cw",
      "url": "https://giphy.com/gifs/vhs-photoshop-spinning-l2YOy09UFUZWu71Cw",
      "slug": "vhs-photoshop-spinning-l2YOy09UFUZWu71Cw",
      "bitly_gif_url": "http://gph.is/1UubckT",
      "bitly_url": "http://gph.is/1UubckT",
      "embed_url": "https://giphy.com/embed/l2YOy09UFUZWu71Cw",
      "username": "anthonyantonellis",
      "source": "http://antonell.is",
      "title": "vhs spinning GIF by Anthony Antonellis",
      "rating": "g",
      "content_url": "",
      "source_tld": "antonell.is",
      "source_post_url": "http://antonell.is",
      "is_sticker": 0,
      "import_datetime": "2016-03-14 22:17:43",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "300",
          "width": "400",
          "size": "1506971",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "485363",
          "mp4": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "387562",
          "webp": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "135",
          "hash": "698cc1481f7b59467360c8b6826bf064"
        },
        "downsized": {
          "height": "300",
          "width": "400",
          "size": "1506971",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "300",
          "width": "400",
          "size": "1506971",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "300",
          "width": "400",
          "size": "1506971",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "228",
          "width": "304",
          "mp4_size": "136701",
          "mp4": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "300",
          "width": "400",
          "size": "1506971",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "267",
          "size": "724080",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "198560",
          "mp4": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "306902",
          "webp": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "267",
          "size": "44662",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "45742",
          "webp": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "134",
          "size": "277306",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "74735",
          "mp4": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "138982",
          "webp": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "134",
          "size": "4997",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "267",
          "size": "12636",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "150",
          "width": "200",
          "size": "472252",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "119260",
          "mp4": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "179314",
          "webp": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "150",
          "width": "200",
          "size": "24124",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "19046",
          "webp": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "75",
          "width": "100",
          "size": "187943",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "46370",
          "mp4": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "92742",
          "webp": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "75",
          "width": "100",
          "size": "2811",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "150",
          "width": "200",
          "size": "6013",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1313375",
          "mp4": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "300",
          "width": "400",
          "size": "27723",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "360",
          "width": "480",
          "mp4_size": "485363",
          "mp4": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "240",
          "width": "320",
          "mp4_size": "30913",
          "mp4": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "93",
          "width": "124",
          "size": "49350",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "150",
          "width": "200",
          "size": "38660",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "360",
          "width": "480",
          "size": "1506971",
          "url": "https://media2.giphy.com/media/l2YOy09UFUZWu71Cw/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/anthonyantonellis/daQLolrwWo4o.gif",
        "banner_image": "https://media3.giphy.com/headers/anthonyantonellis/SqsFmi8lZMtI.gif",
        "banner_url": "https://media3.giphy.com/headers/anthonyantonellis/SqsFmi8lZMtI.gif",
        "profile_url": "https://giphy.com/anthonyantonellis/",
        "username": "anthonyantonellis",
        "display_name": "Anthony Antonellis",
        "description": "Art, the internet and everything.",
        "instagram_url": "https://instagram.com/anthonyantonellis",
        "website_url": "http://anthonyantonellis.com",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPWwyWU95MDlVRlVaV3U3MUN3JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwyWU95MDlVRlVaV3U3MUN3JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwyWU95MDlVRlVaV3U3MUN3JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwyWU95MDlVRlVaV3U3MUN3JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "l41lMAzNZfYAiyR0s",
      "url": "https://giphy.com/gifs/nadrient-90s-80s-computer-l41lMAzNZfYAiyR0s",
      "slug": "nadrient-90s-80s-computer-l41lMAzNZfYAiyR0s",
      "bitly_gif_url": "http://gph.is/1DQNAAF",
      "bitly_url": "http://gph.is/1DQNAAF",
      "embed_url": "https://giphy.com/embed/l41lMAzNZfYAiyR0s",
      "username": "nadrient",
      "source": "nadrient.tumblr.com",
      "title": "90S 80S GIF by Nadrient",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "nadrient.tumblr.com",
      "is_sticker": 0,
      "import_datetime": "2015-03-23 23:16:47",
      "trending_datetime": "2015-04-07 06:26:48",
      "images": {
        "original": {
          "height": "500",
          "width": "500",
          "size": "1784618",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "699441",
          "mp4": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "924654",
          "webp": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "12",
          "hash": "a53decd7b1b1da51ab78100305ce681b"
        },
        "downsized": {
          "height": "500",
          "width": "500",
          "size": "1784618",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "500",
          "width": "500",
          "size": "1784618",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "500",
          "width": "500",
          "size": "1784618",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "234",
          "width": "234",
          "mp4_size": "21052",
          "mp4": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "500",
          "width": "500",
          "size": "1784618",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "227165",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "35357",
          "mp4": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "91064",
          "webp": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "119677",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "61442",
          "webp": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "61128",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "8818",
          "mp4": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "31386",
          "webp": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "5849",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "19665",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "227165",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "35357",
          "mp4": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "91064",
          "webp": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "119677",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "61442",
          "webp": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "61128",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "8818",
          "mp4": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "31386",
          "webp": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "5849",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "19665",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "5776706",
          "mp4": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "500",
          "width": "500",
          "size": "166881",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "699441",
          "mp4": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "200",
          "width": "200",
          "mp4_size": "14916",
          "mp4": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "78",
          "width": "78",
          "size": "48043",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "78",
          "width": "78",
          "size": "17292",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "1784618",
          "url": "https://media2.giphy.com/media/l41lMAzNZfYAiyR0s/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media2.giphy.com/avatars/nadrient/F3uJ0UdyMoFy.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/nadrient/",
        "username": "nadrient",
        "display_name": "Nadrient",
        "description": "A creator of worlds.",
        "instagram_url": "https://instagram.com/nadrient",
        "website_url": "http://nadrient.com/",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPWw0MWxNQXpOWmZZQWl5UjBzJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWw0MWxNQXpOWmZZQWl5UjBzJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWw0MWxNQXpOWmZZQWl5UjBzJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWw0MWxNQXpOWmZZQWl5UjBzJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "3oEdv1nHdklOt0LiEw",
      "url": "https://giphy.com/gifs/laurynsiegel-3oEdv1nHdklOt0LiEw",
      "slug": "laurynsiegel-3oEdv1nHdklOt0LiEw",
      "bitly_gif_url": "http://gph.is/1Rs2DoY",
      "bitly_url": "http://gph.is/1Rs2DoY",
      "embed_url": "https://giphy.com/embed/3oEdv1nHdklOt0LiEw",
      "username": "laurynsiegel",
      "source": "",
      "title": "lamp GIF by Lauryn Siegel",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2015-05-10 18:16:05",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "393296",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "201315",
          "mp4": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "225214",
          "webp": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "24",
          "hash": "8e7398aae4987e26844cbb00a54c6319"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "393296",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "393296",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "393296",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "432",
          "width": "432",
          "mp4_size": "72305",
          "mp4": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "393296",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "77034",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "30428",
          "mp4": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "61646",
          "webp": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "24177",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "19490",
          "webp": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "34703",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "11298",
          "mp4": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "25476",
          "webp": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "3410",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "7437",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "77034",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "30428",
          "mp4": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "61646",
          "webp": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "24177",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "19490",
          "webp": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "34703",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "11298",
          "mp4": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "25476",
          "webp": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "3410",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "7437",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1277170",
          "mp4": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "113533",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "201315",
          "mp4": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "368",
          "width": "368",
          "mp4_size": "26190",
          "mp4": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "148",
          "width": "148",
          "size": "49575",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "338",
          "width": "338",
          "size": "49968",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "393296",
          "url": "https://media0.giphy.com/media/3oEdv1nHdklOt0LiEw/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media1.giphy.com/avatars/laurynsiegel/7xmSXMtFfI7X.JPG",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/laurynsiegel/",
        "username": "laurynsiegel",
        "display_name": "Lauryn Siegel",
        "description": "",
        "instagram_url": "https://instagram.com/flockofsiegel",
        "website_url": "http://www.laurynsiegel.com",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTNvRWR2MW5IZGtsT3QwTGlFdyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvRWR2MW5IZGtsT3QwTGlFdyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvRWR2MW5IZGtsT3QwTGlFdyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvRWR2MW5IZGtsT3QwTGlFdyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "yoJC2lRIOnJSw7tD7G",
      "url": "https://giphy.com/gifs/devindixon4597-yoJC2lRIOnJSw7tD7G",
      "slug": "devindixon4597-yoJC2lRIOnJSw7tD7G",
      "bitly_gif_url": "http://gph.is/1CPXGzk",
      "bitly_url": "http://gph.is/1CPXGzk",
      "embed_url": "https://giphy.com/embed/yoJC2lRIOnJSw7tD7G",
      "username": "devindixon4597",
      "source": "http://tv.devincollections.com",
      "title": "future head GIF by devindixon4597",
      "rating": "g",
      "content_url": "",
      "source_tld": "tv.devincollections.com",
      "source_post_url": "http://tv.devincollections.com",
      "is_sticker": 0,
      "import_datetime": "2015-02-01 23:25:45",
      "trending_datetime": "1970-01-01 00:00:00",
      "images": {
        "original": {
          "height": "380",
          "width": "480",
          "size": "272321",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "142622",
          "mp4": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "187000",
          "webp": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "5",
          "hash": "f441a3c27ff7767b1148a16d0c67e61f"
        },
        "downsized": {
          "height": "380",
          "width": "480",
          "size": "272321",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "380",
          "width": "480",
          "size": "272321",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "380",
          "width": "480",
          "size": "272321",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "380",
          "width": "480",
          "mp4_size": "147751",
          "mp4": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "380",
          "width": "480",
          "size": "272321",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "253",
          "size": "81097",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "29142",
          "mp4": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "44872",
          "webp": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "253",
          "size": "81097",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "50390",
          "webp": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "127",
          "size": "26053",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "8836",
          "mp4": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "10104",
          "webp": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "127",
          "size": "5831",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "253",
          "size": "17807",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "158",
          "width": "200",
          "size": "65456",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "19107",
          "mp4": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "26180",
          "webp": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "158",
          "width": "200",
          "size": "65456",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "29516",
          "webp": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "79",
          "width": "100",
          "size": "17325",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "6151",
          "mp4": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "6742",
          "webp": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "79",
          "width": "100",
          "size": "4090",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "158",
          "width": "200",
          "size": "14444",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "4309968",
          "mp4": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "380",
          "width": "480",
          "size": "72964",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "380",
          "width": "480",
          "mp4_size": "142622",
          "mp4": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "220",
          "width": "277",
          "mp4_size": "23370",
          "mp4": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "113",
          "width": "143",
          "size": "49527",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "148",
          "width": "186",
          "size": "21900",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "380",
          "width": "480",
          "size": "272321",
          "url": "https://media3.giphy.com/media/yoJC2lRIOnJSw7tD7G/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media4.giphy.com/avatars/devindixon4597/gt5sJEyRzX7x.png",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/devindixon4597/",
        "username": "devindixon4597",
        "display_name": "devindixon4597",
        "description": "",
        "instagram_url": "https://instagram.com/@devincollections",
        "website_url": "http://tv.devincollections.com",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPXlvSkMybFJJT25KU3c3dEQ3RyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXlvSkMybFJJT25KU3c3dEQ3RyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXlvSkMybFJJT25KU3c3dEQ3RyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXlvSkMybFJJT25KU3c3dEQ3RyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "XCmSTCA5gGdAPgtloB",
      "url": "https://giphy.com/gifs/80s-grid-fog-XCmSTCA5gGdAPgtloB",
      "slug": "80s-grid-fog-XCmSTCA5gGdAPgtloB",
      "bitly_gif_url": "https://gph.is/g/Z2mJRdm",
      "bitly_url": "https://gph.is/g/Z2mJRdm",
      "embed_url": "https://giphy.com/embed/XCmSTCA5gGdAPgtloB",
      "username": "leeamerica",
      "source": "",
      "title": "80S Landscape GIF by leeamerica",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2020-03-29 03:24:50",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "500",
          "width": "500",
          "size": "4776316",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "1227686",
          "mp4": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1720340",
          "webp": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "72",
          "hash": "2265cb7f8db2331bc37c49ac915eeb4f"
        },
        "downsized": {
          "height": "387",
          "width": "387",
          "size": "1925646",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "500",
          "width": "500",
          "size": "4776316",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "500",
          "width": "500",
          "size": "4776316",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "200",
          "width": "200",
          "mp4_size": "103804",
          "mp4": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "387",
          "width": "387",
          "size": "33296",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "835172",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "224036",
          "mp4": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "280242",
          "webp": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "76409",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "50590",
          "webp": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "287234",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "59122",
          "mp4": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "82816",
          "webp": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "4868",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "12607",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "835172",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "224036",
          "mp4": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "280242",
          "webp": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "76409",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "50590",
          "webp": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "287234",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "47393",
          "mp4": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "82816",
          "webp": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "4868",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "12607",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "4567298",
          "mp4": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "500",
          "width": "500",
          "size": "70252",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "1227686",
          "mp4": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "188",
          "width": "188",
          "mp4_size": "42395",
          "mp4": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "73",
          "width": "73",
          "size": "48933",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "120",
          "width": "120",
          "size": "26530",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "4776316",
          "url": "https://media4.giphy.com/media/XCmSTCA5gGdAPgtloB/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media2.giphy.com/avatars/leeamerica/gKmGZnoZzTDv.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/leeamerica/",
        "username": "leeamerica",
        "display_name": "leeamerica",
        "description": "",
        "instagram_url": "https://instagram.com/leeamerica.gif",
        "website_url": "",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPVhDbVNUQ0E1Z0dkQVBndGxvQiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVhDbVNUQ0E1Z0dkQVBndGxvQiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVhDbVNUQ0E1Z0dkQVBndGxvQiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVhDbVNUQ0E1Z0dkQVBndGxvQiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "moODeYHUQlYfm",
      "url": "https://giphy.com/gifs/inside-energy-whats-moODeYHUQlYfm",
      "slug": "inside-energy-whats-moODeYHUQlYfm",
      "bitly_gif_url": "http://gph.is/1K3g3RA",
      "bitly_url": "http://gph.is/1K3g3RA",
      "embed_url": "https://giphy.com/embed/moODeYHUQlYfm",
      "username": "",
      "source": "http://insideenergy.org/2015/06/15/ie-questions-what-is-inertia-and-whats-its-role-in-reliability/",
      "title": "national grid energy GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "insideenergy.org",
      "source_post_url": "http://insideenergy.org/2015/06/15/ie-questions-what-is-inertia-and-whats-its-role-in-reliability/",
      "is_sticker": 0,
      "import_datetime": "2015-08-05 03:17:51",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "255",
          "width": "421",
          "size": "63300",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "37910",
          "mp4": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "57444",
          "webp": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "21",
          "hash": "2f6f26dfd4a301b3bc9bfe09d17201f4"
        },
        "downsized": {
          "height": "255",
          "width": "421",
          "size": "63300",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "255",
          "width": "421",
          "size": "63300",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "255",
          "width": "421",
          "size": "63300",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "254",
          "width": "420",
          "mp4_size": "29556",
          "mp4": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "255",
          "width": "421",
          "size": "63300",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "330",
          "size": "47433",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "21683",
          "mp4": "https://media0.giphy.com/media/moODeYHUQlYfm/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "42458",
          "webp": "https://media0.giphy.com/media/moODeYHUQlYfm/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "330",
          "size": "18373",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "16020",
          "webp": "https://media0.giphy.com/media/moODeYHUQlYfm/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "165",
          "size": "19096",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "8887",
          "mp4": "https://media0.giphy.com/media/moODeYHUQlYfm/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "17026",
          "webp": "https://media0.giphy.com/media/moODeYHUQlYfm/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "165",
          "size": "3043",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "330",
          "size": "7231",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "121",
          "width": "200",
          "size": "23787",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "11251",
          "mp4": "https://media0.giphy.com/media/moODeYHUQlYfm/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "21680",
          "webp": "https://media0.giphy.com/media/moODeYHUQlYfm/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "121",
          "width": "200",
          "size": "9295",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "7800",
          "webp": "https://media0.giphy.com/media/moODeYHUQlYfm/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "61",
          "width": "100",
          "size": "10134",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "5354",
          "mp4": "https://media0.giphy.com/media/moODeYHUQlYfm/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "9580",
          "webp": "https://media0.giphy.com/media/moODeYHUQlYfm/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "61",
          "width": "100",
          "size": "1877",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "121",
          "width": "200",
          "size": "3661",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "305360",
          "mp4": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "255",
          "width": "421",
          "size": "12665",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "290",
          "width": "480",
          "mp4_size": "37910",
          "mp4": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "254",
          "width": "420",
          "mp4_size": "29556",
          "mp4": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "255",
          "width": "421",
          "size": "48299",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "255",
          "width": "421",
          "size": "36512",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "291",
          "width": "480",
          "size": "63300",
          "url": "https://media0.giphy.com/media/moODeYHUQlYfm/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "analytics_response_payload": "e=Z2lmX2lkPW1vT0RlWUhVUWxZZm0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW1vT0RlWUhVUWxZZm0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW1vT0RlWUhVUWxZZm0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW1vT0RlWUhVUWxZZm0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "MvhPwMtq4O0SY",
      "url": "https://giphy.com/gifs/vaporwave-cyberpunk-webpunk-MvhPwMtq4O0SY",
      "slug": "vaporwave-cyberpunk-webpunk-MvhPwMtq4O0SY",
      "bitly_gif_url": "http://gph.is/1ZTVWPP",
      "bitly_url": "http://gph.is/1ZTVWPP",
      "embed_url": "https://giphy.com/embed/MvhPwMtq4O0SY",
      "username": "",
      "source": "http://pixel8or.tumblr.com/post/118889194993",
      "title": "loop glow GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "pixel8or.tumblr.com",
      "source_post_url": "http://pixel8or.tumblr.com/post/118889194993",
      "is_sticker": 0,
      "import_datetime": "2016-01-09 21:28:52",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "349",
          "size": "359556",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "202015",
          "mp4": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "124976",
          "webp": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "5",
          "hash": "32f6e3c2edf94fad517c3fad9e6d5966"
        },
        "downsized": {
          "height": "480",
          "width": "349",
          "size": "359556",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "349",
          "size": "359556",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "349",
          "size": "359556",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "480",
          "width": "348",
          "mp4_size": "117303",
          "mp4": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "349",
          "size": "359556",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "145",
          "size": "82595",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "27590",
          "mp4": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "34458",
          "webp": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "145",
          "size": "82595",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "39842",
          "webp": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "73",
          "size": "17113",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "7788",
          "mp4": "https://media0.giphy.com/media/MvhPwMtq4O0SY/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "10914",
          "webp": "https://media0.giphy.com/media/MvhPwMtq4O0SY/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "73",
          "size": "3994",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "145",
          "size": "15122",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "275",
          "width": "200",
          "size": "94634",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "45407",
          "mp4": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "55934",
          "webp": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "275",
          "width": "200",
          "size": "94634",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "71070",
          "webp": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "138",
          "width": "100",
          "size": "28566",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "13707",
          "mp4": "https://media0.giphy.com/media/MvhPwMtq4O0SY/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "18906",
          "webp": "https://media0.giphy.com/media/MvhPwMtq4O0SY/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "138",
          "width": "100",
          "size": "6257",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "275",
          "width": "200",
          "size": "19333",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "4687242",
          "mp4": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "349",
          "size": "126686",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "658",
          "width": "480",
          "mp4_size": "202015",
          "mp4": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "312",
          "width": "226",
          "mp4_size": "27894",
          "mp4": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "124",
          "width": "90",
          "size": "49707",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "346",
          "width": "252",
          "size": "46464",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "660",
          "width": "480",
          "size": "359556",
          "url": "https://media0.giphy.com/media/MvhPwMtq4O0SY/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "analytics_response_payload": "e=Z2lmX2lkPU12aFB3TXRxNE8wU1kmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU12aFB3TXRxNE8wU1kmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU12aFB3TXRxNE8wU1kmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU12aFB3TXRxNE8wU1kmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "QpVUMRUJGokfqXyfa1",
      "url": "https://giphy.com/gifs/one-numbers-binary-code-QpVUMRUJGokfqXyfa1",
      "slug": "one-numbers-binary-code-QpVUMRUJGokfqXyfa1",
      "bitly_gif_url": "https://gph.is/g/ajMVAlB",
      "bitly_url": "https://gph.is/g/ajMVAlB",
      "embed_url": "https://giphy.com/embed/QpVUMRUJGokfqXyfa1",
      "username": "butler",
      "source": "http://mograph.video/Binary-4k",
      "title": "High Tech Computer GIF by Matthew Butler",
      "rating": "g",
      "content_url": "",
      "source_tld": "mograph.video",
      "source_post_url": "http://mograph.video/Binary-4k",
      "is_sticker": 0,
      "import_datetime": "2021-03-23 20:38:54",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "281",
          "width": "500",
          "size": "2348204",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "433993",
          "mp4": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1670380",
          "webp": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "72",
          "hash": "8ba3a75269eca0958fc29e80bc4dee47"
        },
        "downsized": {
          "height": "281",
          "width": "500",
          "size": "1842913",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "281",
          "width": "500",
          "size": "2348204",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "281",
          "width": "500",
          "size": "2348204",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "174",
          "width": "310",
          "mp4_size": "125513",
          "mp4": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "281",
          "width": "500",
          "size": "58981",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "356",
          "size": "1779789",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "262429",
          "mp4": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "956682",
          "webp": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "356",
          "size": "238971",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "152044",
          "webp": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "178",
          "size": "571218",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "91437",
          "mp4": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "274420",
          "webp": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "178",
          "size": "14336",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "356",
          "size": "43528",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "112",
          "width": "200",
          "size": "541034",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "102685",
          "mp4": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "316542",
          "webp": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "112",
          "width": "200",
          "size": "80103",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "57812",
          "webp": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "56",
          "width": "100",
          "size": "200284",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "35611",
          "mp4": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "105540",
          "webp": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "56",
          "width": "100",
          "size": "4852",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "112",
          "width": "200",
          "size": "18129",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1892337",
          "mp4": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "281",
          "width": "500",
          "size": "110525",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "268",
          "width": "480",
          "mp4_size": "433993",
          "mp4": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "144",
          "width": "257",
          "mp4_size": "37536",
          "mp4": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "60",
          "width": "107",
          "size": "49231",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "66",
          "width": "118",
          "size": "36152",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "270",
          "width": "480",
          "size": "2348204",
          "url": "https://media4.giphy.com/media/QpVUMRUJGokfqXyfa1/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media0.giphy.com/avatars/butler/OFHBHjjAjrAY.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/butler/",
        "username": "butler",
        "display_name": "Matthew Butler",
        "description": "Hi there, Matthew Butler is a freelance motion graphics designer specializing in After Effects & Cinema 4D since 2007.  He is currently located in Chicago and usually available to take on any freelance work you have.  Matthew considers himself to be one of the fastest & most efficient After Effects users in the Midwest.",
        "instagram_url": "https://instagram.com/butlerm",
        "website_url": "http://butlerm.com/",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPVFwVlVNUlVKR29rZnFYeWZhMSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVFwVlVNUlVKR29rZnFYeWZhMSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVFwVlVNUlVKR29rZnFYeWZhMSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVFwVlVNUlVKR29rZnFYeWZhMSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "Uqw7f8I9UDiuE2tu1H",
      "url": "https://giphy.com/gifs/mag3-grid-retrowave-mag-3-Uqw7f8I9UDiuE2tu1H",
      "slug": "mag3-grid-retrowave-mag-3-Uqw7f8I9UDiuE2tu1H",
      "bitly_gif_url": "https://gph.is/g/4b1k309",
      "bitly_url": "https://gph.is/g/4b1k309",
      "embed_url": "https://giphy.com/embed/Uqw7f8I9UDiuE2tu1H",
      "username": "mag3",
      "source": "",
      "title": "Tech Tron GIF by mag3.giphy",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2020-07-12 19:11:07",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "597589",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "179402",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "251518",
          "webp": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "15",
          "hash": "bb2c89b8114512823632545945e3f301"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "597589",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "597589",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "597589",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "432",
          "width": "432",
          "mp4_size": "77027",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "597589",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "134212",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "40857",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "54414",
          "webp": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "55241",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "26794",
          "webp": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "36192",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "13882",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "20008",
          "webp": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "3214",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "9263",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "134212",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "40857",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "54414",
          "webp": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "55241",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "26794",
          "webp": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "36192",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "13882",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "20008",
          "webp": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "3214",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "9263",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "2027905",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "57998",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "179402",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "232",
          "width": "232",
          "mp4_size": "30516",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "91",
          "width": "91",
          "size": "48723",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "194",
          "width": "194",
          "size": "36786",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "hd": {
          "height": "720",
          "width": "720",
          "mp4_size": "503284",
          "mp4": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/giphy-hd.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-hd.mp4&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "597589",
          "url": "https://media1.giphy.com/media/Uqw7f8I9UDiuE2tu1H/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media0.giphy.com/avatars/mag3/rr4OoOZ4Dc5Y.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/mag3/",
        "username": "mag3",
        "display_name": "mag3.giphy",
        "description": "",
        "instagram_url": "https://instagram.com/mag3",
        "website_url": "http://mag3.gg/",
        "is_verified": false
      },
      "analytics_response_payload": "e=Z2lmX2lkPVVxdzdmOEk5VURpdUUydHUxSCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVVxdzdmOEk5VURpdUUydHUxSCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVVxdzdmOEk5VURpdUUydHUxSCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVVxdzdmOEk5VURpdUUydHUxSCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "fjxc129Zk98KHrt31O",
      "url": "https://giphy.com/gifs/animated-technology-fjxc129Zk98KHrt31O",
      "slug": "animated-technology-fjxc129Zk98KHrt31O",
      "bitly_gif_url": "https://gph.is/2MDZSE7",
      "bitly_url": "https://gph.is/2MDZSE7",
      "embed_url": "https://giphy.com/embed/fjxc129Zk98KHrt31O",
      "username": "xponentialdesign",
      "source": "https://videohive.net/item/nanotechnology-hexagon-grid/21967362?ref=xponentialdesign",
      "title": "technology render GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "videohive.net",
      "source_post_url": "https://videohive.net/item/nanotechnology-hexagon-grid/21967362?ref=xponentialdesign",
      "is_sticker": 0,
      "import_datetime": "2018-06-18 22:56:27",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "540",
          "width": "540",
          "size": "5367599",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "738422",
          "mp4": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1514368",
          "webp": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "45",
          "hash": "810287d91ef6b6802734a361374b61ea"
        },
        "downsized": {
          "height": "299",
          "width": "299",
          "size": "1411389",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "540",
          "width": "540",
          "size": "5367599",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "540",
          "width": "540",
          "size": "4182673",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "216",
          "width": "216",
          "mp4_size": "101231",
          "mp4": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "299",
          "width": "299",
          "size": "31780",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "821449",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "191463",
          "mp4": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "280688",
          "webp": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "120090",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "72392",
          "webp": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "265150",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "72060",
          "mp4": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "100798",
          "webp": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "6749",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "18621",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "821449",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "191463",
          "mp4": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "280688",
          "webp": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "120090",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "72392",
          "webp": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "265150",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "50086",
          "mp4": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "100798",
          "webp": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "6749",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "18621",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "4232769",
          "mp4": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "540",
          "width": "540",
          "size": "119242",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "738422",
          "mp4": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "166",
          "width": "166",
          "mp4_size": "40185",
          "mp4": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "97",
          "width": "97",
          "size": "49302",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "106",
          "width": "106",
          "size": "40928",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "5367599",
          "url": "https://media4.giphy.com/media/fjxc129Zk98KHrt31O/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPWZqeGMxMjlaazk4S0hydDMxTyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWZqeGMxMjlaazk4S0hydDMxTyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWZqeGMxMjlaazk4S0hydDMxTyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWZqeGMxMjlaazk4S0hydDMxTyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "fvI7C505O1hk0MZvDc",
      "url": "https://giphy.com/gifs/cuadrado-cicle-reticula-fvI7C505O1hk0MZvDc",
      "slug": "cuadrado-cicle-reticula-fvI7C505O1hk0MZvDc",
      "bitly_gif_url": "https://gph.is/g/aRLAPAw",
      "bitly_url": "https://gph.is/g/aRLAPAw",
      "embed_url": "https://giphy.com/embed/fvI7C505O1hk0MZvDc",
      "username": "ms_fefa",
      "source": "",
      "title": "Grid Onda GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2020-08-26 19:18:12",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "1382677",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "212598",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "291068",
          "webp": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "61",
          "hash": "9dac70bb6be6a713c72bc97a2bb0c290"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "1382677",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "1382677",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "1121819",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "432",
          "width": "432",
          "mp4_size": "108880",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "1382677",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "338823",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "84291",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "108974",
          "webp": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "34578",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "25640",
          "webp": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "131685",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "32908",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "39462",
          "webp": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "2978",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "6317",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "338823",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "84291",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "108974",
          "webp": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "34578",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "25640",
          "webp": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "131685",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "32908",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "39462",
          "webp": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "2978",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "6317",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1304336",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "134470",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "212598",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "362",
          "width": "362",
          "mp4_size": "47442",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "91",
          "width": "91",
          "size": "49951",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "232",
          "width": "232",
          "size": "35776",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "hd": {
          "height": "1080",
          "width": "1080",
          "mp4_size": "1154195",
          "mp4": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/giphy-hd.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-hd.mp4&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "1382677",
          "url": "https://media0.giphy.com/media/fvI7C505O1hk0MZvDc/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media4.giphy.com/avatars/ms_fefa/9UJEaLFumwtS.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/ms_fefa/",
        "username": "ms_fefa",
        "display_name": "ms_fefa",
        "description": "",
        "instagram_url": "https://instagram.com/ms_fefa",
        "website_url": "https://www.behance.net/ms_fefa/",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPWZ2STdDNTA1TzFoazBNWnZEYyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWZ2STdDNTA1TzFoazBNWnZEYyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWZ2STdDNTA1TzFoazBNWnZEYyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWZ2STdDNTA1TzFoazBNWnZEYyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "nkAIKYsPVk4yA",
      "url": "https://giphy.com/gifs/inside-energy-whats-nkAIKYsPVk4yA",
      "slug": "inside-energy-whats-nkAIKYsPVk4yA",
      "bitly_gif_url": "http://gph.is/1g7hYNa",
      "bitly_url": "http://gph.is/1g7hYNa",
      "embed_url": "https://giphy.com/embed/nkAIKYsPVk4yA",
      "username": "",
      "source": "http://insideenergy.org/2015/06/15/ie-questions-what-is-inertia-and-whats-its-role-in-reliability/",
      "title": "national grid energy GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "insideenergy.org",
      "source_post_url": "http://insideenergy.org/2015/06/15/ie-questions-what-is-inertia-and-whats-its-role-in-reliability/",
      "is_sticker": 0,
      "import_datetime": "2015-08-05 03:15:40",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "260",
          "width": "348",
          "size": "149592",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "129969",
          "mp4": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "147506",
          "webp": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "26",
          "hash": "8da5b13e7bd9dffd1be0fe496cd4d2e8"
        },
        "downsized": {
          "height": "260",
          "width": "348",
          "size": "149592",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "260",
          "width": "348",
          "size": "149592",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "260",
          "width": "348",
          "size": "149592",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "260",
          "width": "348",
          "mp4_size": "96830",
          "mp4": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "260",
          "width": "348",
          "size": "149592",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "268",
          "size": "113121",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "65333",
          "mp4": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "103046",
          "webp": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "268",
          "size": "15136",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "16866",
          "webp": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "134",
          "size": "47382",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "29596",
          "mp4": "https://media2.giphy.com/media/nkAIKYsPVk4yA/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "43874",
          "webp": "https://media2.giphy.com/media/nkAIKYsPVk4yA/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "134",
          "size": "3434",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "268",
          "size": "9071",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "149",
          "width": "200",
          "size": "78573",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "47261",
          "mp4": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "73178",
          "webp": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "149",
          "width": "200",
          "size": "10333",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "11516",
          "webp": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "75",
          "width": "100",
          "size": "33258",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "20090",
          "mp4": "https://media2.giphy.com/media/nkAIKYsPVk4yA/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "27682",
          "webp": "https://media2.giphy.com/media/nkAIKYsPVk4yA/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "75",
          "width": "100",
          "size": "2629",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "149",
          "width": "200",
          "size": "5534",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "656710",
          "mp4": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "260",
          "width": "348",
          "size": "16190",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "358",
          "width": "480",
          "mp4_size": "129969",
          "mp4": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "260",
          "width": "348",
          "mp4_size": "24396",
          "mp4": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "134",
          "width": "179",
          "size": "48375",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "216",
          "width": "290",
          "size": "47906",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "359",
          "width": "480",
          "size": "149592",
          "url": "https://media2.giphy.com/media/nkAIKYsPVk4yA/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "analytics_response_payload": "e=Z2lmX2lkPW5rQUlLWXNQVms0eUEmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW5rQUlLWXNQVms0eUEmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW5rQUlLWXNQVms0eUEmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW5rQUlLWXNQVms0eUEmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "1GkRWmlZzcE3HLDXQw",
      "url": "https://giphy.com/gifs/mograph-futuristic-too-fast-1GkRWmlZzcE3HLDXQw",
      "slug": "mograph-futuristic-too-fast-1GkRWmlZzcE3HLDXQw",
      "bitly_gif_url": "https://gph.is/g/Zx8bvV7",
      "bitly_url": "https://gph.is/g/Zx8bvV7",
      "embed_url": "https://giphy.com/embed/1GkRWmlZzcE3HLDXQw",
      "username": "butler",
      "source": "",
      "title": "Glowing Too Fast GIF by Matthew Butler",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2022-01-12 23:50:36",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "281",
          "width": "500",
          "size": "5159970",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "1356280",
          "mp4": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1125958",
          "webp": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "75",
          "hash": "fe5939420a701af62685cd7ff0bb909b"
        },
        "downsized": {
          "height": "192",
          "width": "342",
          "size": "1981795",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "281",
          "width": "500",
          "size": "5159970",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "281",
          "width": "500",
          "size": "4017940",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "112",
          "width": "200",
          "mp4_size": "182959",
          "mp4": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "192",
          "width": "342",
          "size": "35793",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "356",
          "size": "2678531",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "770761",
          "mp4": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "551190",
          "webp": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "356",
          "size": "239663",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "110934",
          "webp": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "178",
          "size": "751505",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "264670",
          "mp4": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "182576",
          "webp": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "178",
          "size": "14336",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "356",
          "size": "42071",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "112",
          "width": "200",
          "size": "903798",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "308574",
          "mp4": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "213920",
          "webp": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "112",
          "width": "200",
          "size": "79836",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "41918",
          "webp": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "56",
          "width": "100",
          "size": "270499",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "47513",
          "mp4": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "69042",
          "webp": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "56",
          "width": "100",
          "size": "4691",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "112",
          "width": "200",
          "size": "17682",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "7633532",
          "mp4": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "281",
          "width": "500",
          "size": "67288",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "268",
          "width": "480",
          "mp4_size": "1356280",
          "mp4": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "84",
          "width": "150",
          "mp4_size": "47922",
          "mp4": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "49",
          "width": "87",
          "size": "48383",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "74",
          "width": "132",
          "size": "33566",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "270",
          "width": "480",
          "size": "5159970",
          "url": "https://media4.giphy.com/media/1GkRWmlZzcE3HLDXQw/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media2.giphy.com/avatars/butler/OFHBHjjAjrAY.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/butler/",
        "username": "butler",
        "display_name": "Matthew Butler",
        "description": "Hi there, Matthew Butler is a freelance motion graphics designer specializing in After Effects & Cinema 4D since 2007.  He is currently located in Chicago and usually available to take on any freelance work you have.  Matthew considers himself to be one of the fastest & most efficient After Effects users in the Midwest.",
        "instagram_url": "https://instagram.com/butlerm",
        "website_url": "http://butlerm.com/",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTFHa1JXbWxaemNFM0hMRFhRdyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTFHa1JXbWxaemNFM0hMRFhRdyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTFHa1JXbWxaemNFM0hMRFhRdyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTFHa1JXbWxaemNFM0hMRFhRdyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "oSYflamt3IEjm",
      "url": "https://giphy.com/gifs/loop-vaporwave-oSYflamt3IEjm",
      "slug": "loop-vaporwave-oSYflamt3IEjm",
      "bitly_gif_url": "http://gph.is/1ex39Tp",
      "bitly_url": "http://gph.is/1ex39Tp",
      "embed_url": "https://giphy.com/embed/oSYflamt3IEjm",
      "username": "",
      "source": "http://pixel8or.tumblr.com/post/117455277013",
      "title": "Glow Daft Punk GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "pixel8or.tumblr.com",
      "source_post_url": "http://pixel8or.tumblr.com/post/117455277013",
      "is_sticker": 0,
      "import_datetime": "2015-07-06 07:36:50",
      "trending_datetime": "2016-01-09 18:30:01",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "478690",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "110224",
          "mp4": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "107264",
          "webp": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "8",
          "hash": "6b63f9960a783bbae5b44f5b650951ce"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "478690",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "478690",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "478690",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "480",
          "width": "480",
          "mp4_size": "110224",
          "mp4": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "478690",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "74544",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "16328",
          "mp4": "https://media1.giphy.com/media/oSYflamt3IEjm/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "19996",
          "webp": "https://media1.giphy.com/media/oSYflamt3IEjm/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "59367",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "35080",
          "webp": "https://media1.giphy.com/media/oSYflamt3IEjm/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "29340",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "6759",
          "mp4": "https://media1.giphy.com/media/oSYflamt3IEjm/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "7992",
          "webp": "https://media1.giphy.com/media/oSYflamt3IEjm/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "4377",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "10043",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "74544",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "16328",
          "mp4": "https://media1.giphy.com/media/oSYflamt3IEjm/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "19996",
          "webp": "https://media1.giphy.com/media/oSYflamt3IEjm/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "59367",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "35080",
          "webp": "https://media1.giphy.com/media/oSYflamt3IEjm/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "29340",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "6759",
          "mp4": "https://media1.giphy.com/media/oSYflamt3IEjm/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "7992",
          "webp": "https://media1.giphy.com/media/oSYflamt3IEjm/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "4377",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "10043",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "5053814",
          "mp4": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "74700",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "110224",
          "mp4": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "322",
          "width": "322",
          "mp4_size": "18093",
          "mp4": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "99",
          "width": "99",
          "size": "49036",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "322",
          "width": "322",
          "size": "31946",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "478690",
          "url": "https://media1.giphy.com/media/oSYflamt3IEjm/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "analytics_response_payload": "e=Z2lmX2lkPW9TWWZsYW10M0lFam0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW9TWWZsYW10M0lFam0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW9TWWZsYW10M0lFam0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW9TWWZsYW10M0lFam0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "oOiwRjguRGkjbNQvNv",
      "url": "https://giphy.com/gifs/animation-dark-tropical-oOiwRjguRGkjbNQvNv",
      "slug": "animation-dark-tropical-oOiwRjguRGkjbNQvNv",
      "bitly_gif_url": "https://gph.is/2QnqCdD",
      "bitly_url": "https://gph.is/2QnqCdD",
      "embed_url": "https://giphy.com/embed/oOiwRjguRGkjbNQvNv",
      "username": "dairbiroli",
      "source": "https://cdn.dribbble.com/users/1786756/screenshots/4896376/002---tropical-grid.gif",
      "title": "animation dark GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "cdn.dribbble.com",
      "source_post_url": "https://cdn.dribbble.com/users/1786756/screenshots/4896376/002---tropical-grid.gif",
      "is_sticker": 0,
      "import_datetime": "2018-09-12 20:18:04",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "300",
          "width": "400",
          "size": "4243685",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "1773476",
          "mp4": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1402596",
          "webp": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "120",
          "hash": "8aa8c7dcf1a94f654762bc4d6cd85ca1"
        },
        "downsized": {
          "height": "300",
          "width": "400",
          "size": "1344960",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "300",
          "width": "400",
          "size": "4243685",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "300",
          "width": "400",
          "size": "4243685",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "120",
          "width": "160",
          "mp4_size": "138421",
          "mp4": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "300",
          "width": "400",
          "size": "28054",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "267",
          "size": "1650396",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "620607",
          "mp4": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "649978",
          "webp": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "267",
          "size": "108877",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "62012",
          "webp": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "134",
          "size": "604040",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "202485",
          "mp4": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "232950",
          "webp": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "134",
          "size": "6093",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "267",
          "size": "14845",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "150",
          "width": "200",
          "size": "2201141",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "402235",
          "mp4": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "425522",
          "webp": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "150",
          "width": "200",
          "size": "103682",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "38874",
          "webp": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "75",
          "width": "100",
          "size": "385668",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "48530",
          "mp4": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "148146",
          "webp": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "75",
          "width": "100",
          "size": "4130",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "150",
          "width": "200",
          "size": "12051",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "4233345",
          "mp4": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "300",
          "width": "400",
          "size": "42905",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "360",
          "width": "480",
          "mp4_size": "1773476",
          "mp4": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "136",
          "width": "181",
          "mp4_size": "45450",
          "mp4": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "69",
          "width": "92",
          "size": "48082",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "114",
          "width": "152",
          "size": "39286",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "360",
          "width": "480",
          "size": "4243685",
          "url": "https://media2.giphy.com/media/oOiwRjguRGkjbNQvNv/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/dairbiroli/b4AABhcKW8Lb.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/dairbiroli/",
        "username": "dairbiroli",
        "display_name": "Dair Biroli",
        "description": "Animator & Motion designer - Creative Director at @Motionauts",
        "instagram_url": "https://instagram.com/@dairbiroli",
        "website_url": "http://biroli.tv",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPW9PaXdSamd1UkdramJOUXZOdiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW9PaXdSamd1UkdramJOUXZOdiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW9PaXdSamd1UkdramJOUXZOdiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW9PaXdSamd1UkdramJOUXZOdiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "3oKIPtWJYitUh5QJWM",
      "url": "https://giphy.com/gifs/3oKIPtWJYitUh5QJWM",
      "slug": "3oKIPtWJYitUh5QJWM",
      "bitly_gif_url": "http://gph.is/2rSp6Y8",
      "bitly_url": "http://gph.is/2rSp6Y8",
      "embed_url": "https://giphy.com/embed/3oKIPtWJYitUh5QJWM",
      "username": "PolarisVideo",
      "source": "",
      "title": "Car Driving GIF by PolarisVideo",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2017-06-04 05:36:21",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "6854176",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "2470070",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1246320",
          "webp": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "90",
          "hash": "9ec26935cd71e1b77ff1111bff893ba5"
        },
        "downsized": {
          "height": "384",
          "width": "384",
          "size": "1506297",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "6854176",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "4768138",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "150",
          "width": "150",
          "mp4_size": "179456",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "384",
          "width": "384",
          "size": "35350",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "1188609",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "675695",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "466066",
          "webp": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "87848",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "46722",
          "webp": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "376333",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "268532",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "200712",
          "webp": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "4900",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "13907",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "1188609",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "675695",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "466066",
          "webp": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "87848",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "46722",
          "webp": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "376333",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "44793",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "200712",
          "webp": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "4900",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "13907",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "5853249",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "76625",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "2470070",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "224",
          "width": "224",
          "mp4_size": "40640",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "124",
          "width": "124",
          "size": "48646",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "154",
          "width": "154",
          "size": "39764",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "hd": {
          "height": "720",
          "width": "720",
          "mp4_size": "4761058",
          "mp4": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/giphy-hd.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-hd.mp4&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "6854176",
          "url": "https://media2.giphy.com/media/3oKIPtWJYitUh5QJWM/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/polarisradio/f3idUe7qqu4X.png",
        "banner_image": "https://media3.giphy.com/headers/PolarisVideo/L1U6MBx8qZxv.png",
        "banner_url": "https://media3.giphy.com/headers/PolarisVideo/L1U6MBx8qZxv.png",
        "profile_url": "https://giphy.com/PolarisVideo/",
        "username": "PolarisVideo",
        "display_name": "PolarisVideo",
        "description": "",
        "instagram_url": "https://instagram.com/polarisvideo_nft",
        "website_url": "https://opensea.io/PolarisVideo",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTNvS0lQdFdKWWl0VWg1UUpXTSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvS0lQdFdKWWl0VWg1UUpXTSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvS0lQdFdKWWl0VWg1UUpXTSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvS0lQdFdKWWl0VWg1UUpXTSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "nwCz29GZlx0HfZZIwF",
      "url": "https://giphy.com/gifs/loop-illustration-trippy-nwCz29GZlx0HfZZIwF",
      "slug": "loop-illustration-trippy-nwCz29GZlx0HfZZIwF",
      "bitly_gif_url": "https://gph.is/2K3DFhl",
      "bitly_url": "https://gph.is/2K3DFhl",
      "embed_url": "https://giphy.com/embed/nwCz29GZlx0HfZZIwF",
      "username": "kotutohum",
      "source": "http://kotutohum.com/post/173111180671/letranger-animation-for-the-new-single-of-ooooo",
      "title": "palm trees loop GIF by kotutohum",
      "rating": "g",
      "content_url": "",
      "source_tld": "kotutohum.com",
      "source_post_url": "http://kotutohum.com/post/173111180671/letranger-animation-for-the-new-single-of-ooooo",
      "is_sticker": 0,
      "import_datetime": "2018-04-20 23:18:31",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "540",
          "width": "540",
          "size": "3103253",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "383538",
          "mp4": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "842828",
          "webp": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "48",
          "hash": "c7104a5185e327d62f7aab51800d4212"
        },
        "downsized": {
          "height": "432",
          "width": "432",
          "size": "1590009",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "540",
          "width": "540",
          "size": "3103253",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "540",
          "width": "540",
          "size": "3103253",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "266",
          "width": "266",
          "mp4_size": "46645",
          "mp4": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "432",
          "width": "432",
          "size": "36806",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "495645",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "61023",
          "mp4": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "138922",
          "webp": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "77687",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "44546",
          "webp": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "175608",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "24839",
          "mp4": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "47498",
          "webp": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "4895",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "12247",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "495645",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "61023",
          "mp4": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "138922",
          "webp": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "77687",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "44546",
          "webp": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "175608",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "24839",
          "mp4": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "47498",
          "webp": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "4895",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "12247",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "2829521",
          "mp4": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "540",
          "width": "540",
          "size": "69957",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "383538",
          "mp4": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "216",
          "width": "216",
          "mp4_size": "28449",
          "mp4": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "126",
          "width": "126",
          "size": "48443",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "130",
          "width": "130",
          "size": "25436",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "3103253",
          "url": "https://media0.giphy.com/media/nwCz29GZlx0HfZZIwF/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media2.giphy.com/avatars/kotutohum/o4pGUJgilunA.png",
        "banner_image": "https://media2.giphy.com/headers/kotutohum/EWkyjArJVKXE.jpg",
        "banner_url": "https://media2.giphy.com/headers/kotutohum/EWkyjArJVKXE.jpg",
        "profile_url": "https://giphy.com/kotutohum/",
        "username": "kotutohum",
        "display_name": "kotutohum",
        "description": "",
        "instagram_url": "https://instagram.com/kotutohum.gif",
        "website_url": "http://batuhanperker.com/",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPW53Q3oyOUdabHgwSGZaWkl3RiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW53Q3oyOUdabHgwSGZaWkl3RiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW53Q3oyOUdabHgwSGZaWkl3RiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPW53Q3oyOUdabHgwSGZaWkl3RiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "26BoD64nDXYKHNuj6",
      "url": "https://giphy.com/gifs/3d-worm-gif-26BoD64nDXYKHNuj6",
      "slug": "3d-worm-gif-26BoD64nDXYKHNuj6",
      "bitly_gif_url": "http://gph.is/29K6QCC",
      "bitly_url": "http://gph.is/29K6QCC",
      "embed_url": "https://giphy.com/embed/26BoD64nDXYKHNuj6",
      "username": "eemilfriman",
      "source": "http://memmil.tumblr.com/",
      "title": "3D Loop GIF by Memmil",
      "rating": "g",
      "content_url": "",
      "source_tld": "memmil.tumblr.com",
      "source_post_url": "http://memmil.tumblr.com/",
      "is_sticker": 0,
      "import_datetime": "2016-07-16 14:18:30",
      "trending_datetime": "2017-11-08 11:00:02",
      "images": {
        "original": {
          "height": "284",
          "width": "500",
          "size": "654716",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "93876",
          "mp4": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "199712",
          "webp": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "24",
          "hash": "00cfd780935fcc2c9cfe8dc73d796020"
        },
        "downsized": {
          "height": "284",
          "width": "500",
          "size": "654716",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "284",
          "width": "500",
          "size": "654716",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "284",
          "width": "500",
          "size": "654716",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "284",
          "width": "500",
          "mp4_size": "106562",
          "mp4": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "284",
          "width": "500",
          "size": "654716",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "352",
          "size": "286500",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "74309",
          "mp4": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "121518",
          "webp": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "352",
          "size": "84042",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "86548",
          "webp": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "176",
          "size": "116789",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "41822",
          "mp4": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "54566",
          "webp": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "176",
          "size": "6111",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "352",
          "size": "18384",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "114",
          "width": "200",
          "size": "134848",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "49341",
          "mp4": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "64892",
          "webp": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "114",
          "width": "200",
          "size": "38316",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "41170",
          "webp": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "57",
          "width": "100",
          "size": "58685",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "25510",
          "mp4": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "25610",
          "webp": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "57",
          "width": "100",
          "size": "3465",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "114",
          "width": "200",
          "size": "8173",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1798449",
          "mp4": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "284",
          "width": "500",
          "size": "46130",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "272",
          "width": "480",
          "mp4_size": "93876",
          "mp4": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "194",
          "width": "341",
          "mp4_size": "32211",
          "mp4": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "66",
          "width": "116",
          "size": "48963",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "116",
          "width": "204",
          "size": "47962",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "273",
          "width": "480",
          "size": "654716",
          "url": "https://media3.giphy.com/media/26BoD64nDXYKHNuj6/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media2.giphy.com//avatars/default1.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/eemilfriman/",
        "username": "eemilfriman",
        "display_name": "Memmil",
        "description": "I'm a graphic designer based in Helsinki, Finland.",
        "instagram_url": "https://instagram.com/memmiliio",
        "website_url": "",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTI2Qm9ENjRuRFhZS0hOdWo2JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTI2Qm9ENjRuRFhZS0hOdWo2JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTI2Qm9ENjRuRFhZS0hOdWo2JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTI2Qm9ENjRuRFhZS0hOdWo2JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SENT"
        }
      }
    },
    {
      "type": "sticker",
      "id": "emdRjklrE9VZhwIeej",
      "url": "https://giphy.com/gifs/grid-bright-colors-6x6-emdRjklrE9VZhwIeej",
      "slug": "grid-bright-colors-6x6-emdRjklrE9VZhwIeej",
      "bitly_gif_url": "https://gph.is/g/4D81qLj",
      "bitly_url": "https://gph.is/g/4D81qLj",
      "embed_url": "https://giphy.com/embed/emdRjklrE9VZhwIeej",
      "username": "michaelpaulukonis",
      "source": "",
      "title": "Pink Color GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2021-05-12 14:54:46",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "1413143",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=s",
          "mp4_size": "404995",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=s",
          "webp_size": "404322",
          "webp": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=s",
          "frames": "33",
          "hash": "4c33bf9e6373709e3bdf85edf3017326"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "1413143",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=s"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "1413143",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=s"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "1413143",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=s"
        },
        "downsized_small": {
          "height": "202",
          "width": "202",
          "mp4_size": "43998",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=s"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "1413143",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=s"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "339835",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=s",
          "mp4_size": "63799",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=s",
          "webp_size": "50706",
          "webp": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=s"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "67968",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=s",
          "webp_size": "19680",
          "webp": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=s"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "85242",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=s",
          "mp4_size": "45535",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=s",
          "webp_size": "35858",
          "webp": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=s"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "3114",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=s"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "6805",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=s"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "339835",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=s",
          "mp4_size": "63799",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=s",
          "webp_size": "50706",
          "webp": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=s"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "67968",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=s",
          "webp_size": "19680",
          "webp": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=s"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "85242",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=s",
          "mp4_size": "45535",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=s",
          "webp_size": "35858",
          "webp": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=s"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "3114",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=s"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "6805",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=s"
        },
        "looping": {
          "mp4_size": "4833262",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=s"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "45347",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=s"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "404995",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=s"
        },
        "preview": {
          "height": "218",
          "width": "218",
          "mp4_size": "36485",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=s"
        },
        "preview_gif": {
          "height": "169",
          "width": "169",
          "size": "49631",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=s"
        },
        "preview_webp": {
          "height": "352",
          "width": "352",
          "size": "20748",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=s"
        },
        "hd": {
          "height": "720",
          "width": "720",
          "mp4_size": "2608872",
          "mp4": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/giphy-hd.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-hd.mp4&ct=s"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "1413143",
          "url": "https://media3.giphy.com/media/emdRjklrE9VZhwIeej/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=s"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/michaelpaulukonis/oeDOCJQZyNb2.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/channel/michaelpaulukonis/",
        "username": "michaelpaulukonis",
        "display_name": "michaelpaulukonis",
        "description": "I make stuff from bits and letters.",
        "instagram_url": "https://instagram.com/michaelpaulukonis",
        "website_url": "http://michaelpaulukonis.github.io/",
        "is_verified": false
      },
      "analytics_response_payload": "e=Z2lmX2lkPWVtZFJqa2xyRTlWWmh3SWVlaiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1z",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWVtZFJqa2xyRTlWWmh3SWVlaiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1z&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWVtZFJqa2xyRTlWWmh3SWVlaiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1z&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWVtZFJqa2xyRTlWWmh3SWVlaiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1z&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "3CZ3cqAHhaa21p45qX",
      "url": "https://giphy.com/gifs/iphone-grid-live-wallpaper-3CZ3cqAHhaa21p45qX",
      "slug": "iphone-grid-live-wallpaper-3CZ3cqAHhaa21p45qX",
      "bitly_gif_url": "https://gph.is/2AJqBel",
      "bitly_url": "https://gph.is/2AJqBel",
      "embed_url": "https://giphy.com/embed/3CZ3cqAHhaa21p45qX",
      "username": "chrisgannon",
      "source": "https://gannon.tv",
      "title": "iphone ios GIF by Chris Gannon",
      "rating": "g",
      "content_url": "",
      "source_tld": "gannon.tv",
      "source_post_url": "https://gannon.tv",
      "is_sticker": 0,
      "import_datetime": "2018-11-03 00:00:47",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "222",
          "size": "4058565",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "1426827",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1128556",
          "webp": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "163",
          "hash": "2271eb6dc40f247900fabcea0d83907e"
        },
        "downsized": {
          "height": "480",
          "width": "222",
          "size": "1222763",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "222",
          "size": "4058565",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "222",
          "size": "3461626",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "298",
          "width": "137",
          "mp4_size": "127653",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "222",
          "size": "30459",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "93",
          "size": "839634",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "118648",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "265032",
          "webp": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "93",
          "size": "41513",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "29394",
          "webp": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "47",
          "size": "328635",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "35601",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "76216",
          "webp": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "47",
          "size": "2343",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "93",
          "size": "5085",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "432",
          "width": "200",
          "size": "3334519",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "378514",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "954628",
          "webp": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "432",
          "width": "200",
          "size": "141189",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "96080",
          "webp": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "216",
          "width": "100",
          "size": "1081974",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "49107",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "305834",
          "webp": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "216",
          "width": "100",
          "size": "4651",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "432",
          "width": "200",
          "size": "18713",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1446181",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "222",
          "size": "39207",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "1038",
          "width": "480",
          "mp4_size": "1426827",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "378",
          "width": "174",
          "mp4_size": "40063",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "247",
          "width": "114",
          "size": "48657",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "388",
          "width": "180",
          "size": "48070",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "hd": {
          "height": "1920",
          "width": "886",
          "mp4_size": "6746709",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-hd.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-hd.mp4&ct=g"
        },
        "480w_still": {
          "height": "1038",
          "width": "480",
          "size": "4058565",
          "url": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        },
        "4k": {
          "height": "2436",
          "width": "1124",
          "mp4_size": "14542250",
          "mp4": "https://media0.giphy.com/media/3CZ3cqAHhaa21p45qX/giphy-4k.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-4k.mp4&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/chrisgannon/qEoKIoGjII5U.png",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/chrisgannon/",
        "username": "chrisgannon",
        "display_name": "Chris Gannon",
        "description": "",
        "instagram_url": "https://instagram.com/chrisgannon",
        "website_url": "https://gannon.tv",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTNDWjNjcUFIaGFhMjFwNDVxWCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNDWjNjcUFIaGFhMjFwNDVxWCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNDWjNjcUFIaGFhMjFwNDVxWCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNDWjNjcUFIaGFhMjFwNDVxWCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "ZFjChEv0Fcm7HwvHEP",
      "url": "https://giphy.com/gifs/space-universe-cosmos-ZFjChEv0Fcm7HwvHEP",
      "slug": "space-universe-cosmos-ZFjChEv0Fcm7HwvHEP",
      "bitly_gif_url": "https://gph.is/g/apbOlgB",
      "bitly_url": "https://gph.is/g/apbOlgB",
      "embed_url": "https://giphy.com/embed/ZFjChEv0Fcm7HwvHEP",
      "username": "dualvoidanima",
      "source": "https://www.patreon.com/dualvoidanima",
      "title": "Art Design GIF by dualvoidanima",
      "rating": "g",
      "content_url": "",
      "source_tld": "www.patreon.com",
      "source_post_url": "https://www.patreon.com/dualvoidanima",
      "is_sticker": 0,
      "import_datetime": "2020-04-11 20:10:02",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "540",
          "width": "540",
          "size": "2232543",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "506197",
          "mp4": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "793756",
          "webp": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "28",
          "hash": "ffffc9c0ee649228395f5e5ad37e1df9"
        },
        "downsized": {
          "height": "540",
          "width": "540",
          "size": "1288759",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "540",
          "width": "540",
          "size": "2232543",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "540",
          "width": "540",
          "size": "2232543",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "252",
          "width": "252",
          "mp4_size": "40046",
          "mp4": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "540",
          "width": "540",
          "size": "48970",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "354063",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "57515",
          "mp4": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "100152",
          "webp": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "78992",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "46798",
          "webp": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "113530",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "19030",
          "mp4": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "32736",
          "webp": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "4873",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "13851",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "354063",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "57515",
          "mp4": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "100152",
          "webp": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "78992",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "46798",
          "webp": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "113530",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "19030",
          "mp4": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "32736",
          "webp": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "4873",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "13851",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "4520331",
          "mp4": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "540",
          "width": "540",
          "size": "104244",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "506197",
          "mp4": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "216",
          "width": "216",
          "mp4_size": "27955",
          "mp4": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "72",
          "width": "72",
          "size": "49962",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "116",
          "width": "116",
          "size": "23742",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "2232543",
          "url": "https://media4.giphy.com/media/ZFjChEv0Fcm7HwvHEP/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media1.giphy.com/avatars/dualvoidanima/cdTCKmcCw2iG.gif",
        "banner_image": "https://media1.giphy.com/headers/dualvoidanima/cFKoZxPvxmbm.gif",
        "banner_url": "https://media1.giphy.com/headers/dualvoidanima/cFKoZxPvxmbm.gif",
        "profile_url": "https://giphy.com/dualvoidanima/",
        "username": "dualvoidanima",
        "display_name": "dualvoidanima",
        "description": "dualvoidanima@gmail.com",
        "instagram_url": "https://instagram.com/dualvoidanima1",
        "website_url": "https://linktr.ee/dualvoidanima",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPVpGakNoRXYwRmNtN0h3dkhFUCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVpGakNoRXYwRmNtN0h3dkhFUCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVpGakNoRXYwRmNtN0h3dkhFUCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVpGakNoRXYwRmNtN0h3dkhFUCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "7W3VbczZNkxos",
      "url": "https://giphy.com/gifs/glitch-art-roland-tr808-7W3VbczZNkxos",
      "slug": "glitch-art-roland-tr808-7W3VbczZNkxos",
      "bitly_gif_url": "http://gph.is/1Zd9jZb",
      "bitly_url": "http://gph.is/1Zd9jZb",
      "embed_url": "https://giphy.com/embed/7W3VbczZNkxos",
      "username": "",
      "source": "http://pixel8or.tumblr.com/post/115769820868/wow-808-followers-thank-you",
      "title": "glow drum machine GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "pixel8or.tumblr.com",
      "source_post_url": "http://pixel8or.tumblr.com/post/115769820868/wow-808-followers-thank-you",
      "is_sticker": 0,
      "import_datetime": "2016-01-09 21:29:28",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "472",
          "size": "688509",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "227092",
          "mp4": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "300362",
          "webp": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "8",
          "hash": "8b3fb91dda31be1235095de86422c75d"
        },
        "downsized": {
          "height": "480",
          "width": "472",
          "size": "688509",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "472",
          "size": "688509",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "472",
          "size": "688509",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "418",
          "width": "411",
          "mp4_size": "68878",
          "mp4": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "472",
          "size": "688509",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "197",
          "size": "140608",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "36933",
          "mp4": "https://media0.giphy.com/media/7W3VbczZNkxos/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "50832",
          "webp": "https://media0.giphy.com/media/7W3VbczZNkxos/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "197",
          "size": "114515",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "80730",
          "webp": "https://media0.giphy.com/media/7W3VbczZNkxos/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "99",
          "size": "46979",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "11897",
          "mp4": "https://media0.giphy.com/media/7W3VbczZNkxos/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "17450",
          "webp": "https://media0.giphy.com/media/7W3VbczZNkxos/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "99",
          "size": "7132",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "197",
          "size": "19807",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "203",
          "width": "200",
          "size": "143016",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "37895",
          "mp4": "https://media0.giphy.com/media/7W3VbczZNkxos/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "52296",
          "webp": "https://media0.giphy.com/media/7W3VbczZNkxos/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "203",
          "width": "200",
          "size": "118454",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "81320",
          "webp": "https://media0.giphy.com/media/7W3VbczZNkxos/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "102",
          "width": "100",
          "size": "48757",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "12182",
          "mp4": "https://media0.giphy.com/media/7W3VbczZNkxos/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "17494",
          "webp": "https://media0.giphy.com/media/7W3VbczZNkxos/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "102",
          "width": "100",
          "size": "7326",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "203",
          "width": "200",
          "size": "20131",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "12044859",
          "mp4": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "472",
          "size": "103826",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "488",
          "width": "480",
          "mp4_size": "227092",
          "mp4": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "208",
          "width": "204",
          "mp4_size": "19673",
          "mp4": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "94",
          "width": "92",
          "size": "48921",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "158",
          "width": "156",
          "size": "27534",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "488",
          "width": "480",
          "size": "688509",
          "url": "https://media0.giphy.com/media/7W3VbczZNkxos/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "analytics_response_payload": "e=Z2lmX2lkPTdXM1ZiY3paTmt4b3MmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTdXM1ZiY3paTmt4b3MmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTdXM1ZiY3paTmt4b3MmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTdXM1ZiY3paTmt4b3MmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "vBUz3Aoss4NzaUbO7S",
      "url": "https://giphy.com/gifs/neon-landscape-retrowave-vBUz3Aoss4NzaUbO7S",
      "slug": "neon-landscape-retrowave-vBUz3Aoss4NzaUbO7S",
      "bitly_gif_url": "https://gph.is/g/aRYo5rg",
      "bitly_url": "https://gph.is/g/aRYo5rg",
      "embed_url": "https://giphy.com/embed/vBUz3Aoss4NzaUbO7S",
      "username": "Vit_Voland",
      "source": "https://www.tiktok.com/@vit_voland/video/6827455348991937797?_d=secCgYIASAHKAESMgowXjhLr9KMGq05U%2Fo0Tf0tReY6IMSleod6YYE4%2F8jLXwjKaQHYQ5xXTBL%2BpFrPX5EoGgA%3D&language=ru&sec_user_id=MS4wLjABAAAAJ7G96daQvUBaupMo6536IIF1UBBhWFy5ktK29lzbTa3ZOYZYAumzAVxjz9F",
      "title": "Game Glitch GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "www.tiktok.com",
      "source_post_url": "https://www.tiktok.com/@vit_voland/video/6827455348991937797?_d=secCgYIASAHKAESMgowXjhLr9KMGq05U%2Fo0Tf0tReY6IMSleod6YYE4%2F8jLXwjKaQHYQ5xXTBL%2BpFrPX5EoGgA%3D&language=ru&sec_user_id=MS4wLjABAAAAJ7G96daQvUBaupMo6536IIF1UBBhWFy5ktK29lzbTa3ZOYZYAumzAVxjz9F",
      "is_sticker": 0,
      "import_datetime": "2021-06-28 20:40:53",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "270",
          "width": "480",
          "size": "1820786",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "630050",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "703050",
          "webp": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "34",
          "hash": "467918b3f43d14819eddadc7e462fe70"
        },
        "downsized": {
          "height": "270",
          "width": "480",
          "size": "1820786",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "270",
          "width": "480",
          "size": "1820786",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "270",
          "width": "480",
          "size": "1820786",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "150",
          "width": "266",
          "mp4_size": "158305",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "270",
          "width": "480",
          "size": "1820786",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "356",
          "size": "844224",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "397657",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "464648",
          "webp": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "356",
          "size": "174670",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "91936",
          "webp": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "178",
          "size": "289959",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "146799",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "163996",
          "webp": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "178",
          "size": "10173",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "356",
          "size": "26711",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "113",
          "width": "200",
          "size": "371034",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "166928",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "189440",
          "webp": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "113",
          "width": "200",
          "size": "68473",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "35022",
          "webp": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "57",
          "width": "100",
          "size": "105017",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "45734",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "66632",
          "webp": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "57",
          "width": "100",
          "size": "3947",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "113",
          "width": "200",
          "size": "12722",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "3863367",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "270",
          "width": "480",
          "size": "58648",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "270",
          "width": "480",
          "mp4_size": "630050",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "114",
          "width": "202",
          "mp4_size": "46875",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "56",
          "width": "100",
          "size": "47437",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "96",
          "width": "170",
          "size": "41368",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "hd": {
          "height": "1080",
          "width": "1920",
          "mp4_size": "4617751",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy-hd.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-hd.mp4&ct=g"
        },
        "480w_still": {
          "height": "270",
          "width": "480",
          "size": "1820786",
          "url": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        },
        "4k": {
          "height": "2160",
          "width": "3840",
          "mp4_size": "11971282",
          "mp4": "https://media4.giphy.com/media/vBUz3Aoss4NzaUbO7S/giphy-4k.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-4k.mp4&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media0.giphy.com/avatars/Vitaliy_Voland/dO1aOYyPbo7B.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/channel/Vit_Voland/",
        "username": "Vit_Voland",
        "display_name": "Vit_Voland",
        "description": "Motion designer and Retrowave average enjoyer",
        "instagram_url": "https://instagram.com/vitaliy.voland",
        "website_url": "http://www.pond5.com/artist/vitaliyvoland",
        "is_verified": false
      },
      "analytics_response_payload": "e=Z2lmX2lkPXZCVXozQW9zczROemFVYk83UyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXZCVXozQW9zczROemFVYk83UyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXZCVXozQW9zczROemFVYk83UyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXZCVXozQW9zczROemFVYk83UyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "fecwzuDXfWZiM",
      "url": "https://giphy.com/gifs/vaporwave-cyberpunk-webpunk-fecwzuDXfWZiM",
      "slug": "vaporwave-cyberpunk-webpunk-fecwzuDXfWZiM",
      "bitly_gif_url": "http://gph.is/1Zd9lA9",
      "bitly_url": "http://gph.is/1Zd9lA9",
      "embed_url": "https://giphy.com/embed/fecwzuDXfWZiM",
      "username": "",
      "source": "http://pixel8or.tumblr.com/post/120435170158",
      "title": "daft punk loop GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "pixel8or.tumblr.com",
      "source_post_url": "http://pixel8or.tumblr.com/post/120435170158",
      "is_sticker": 0,
      "import_datetime": "2016-01-09 21:29:14",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "588019",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "284731",
          "mp4": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "268100",
          "webp": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "8",
          "hash": "eeaa7ea633056a69a58cdfaaa3e8f590"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "588019",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "588019",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "588019",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "402",
          "width": "402",
          "mp4_size": "71526",
          "mp4": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "588019",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "121562",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "39164",
          "mp4": "https://media1.giphy.com/media/fecwzuDXfWZiM/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "45460",
          "webp": "https://media1.giphy.com/media/fecwzuDXfWZiM/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "103605",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "71906",
          "webp": "https://media1.giphy.com/media/fecwzuDXfWZiM/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "42171",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "14153",
          "mp4": "https://media1.giphy.com/media/fecwzuDXfWZiM/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "16292",
          "webp": "https://media1.giphy.com/media/fecwzuDXfWZiM/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "6362",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "17522",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "121562",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "39164",
          "mp4": "https://media1.giphy.com/media/fecwzuDXfWZiM/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "45460",
          "webp": "https://media1.giphy.com/media/fecwzuDXfWZiM/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "103605",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "71906",
          "webp": "https://media1.giphy.com/media/fecwzuDXfWZiM/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "42171",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "14153",
          "mp4": "https://media1.giphy.com/media/fecwzuDXfWZiM/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "16292",
          "webp": "https://media1.giphy.com/media/fecwzuDXfWZiM/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "6362",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "17522",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "12998905",
          "mp4": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "88130",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "284731",
          "mp4": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "200",
          "width": "200",
          "mp4_size": "20077",
          "mp4": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "101",
          "width": "101",
          "size": "49861",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "170",
          "width": "170",
          "size": "28382",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "588019",
          "url": "https://media1.giphy.com/media/fecwzuDXfWZiM/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "analytics_response_payload": "e=Z2lmX2lkPWZlY3d6dURYZldaaU0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWZlY3d6dURYZldaaU0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWZlY3d6dURYZldaaU0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWZlY3d6dURYZldaaU0mZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "KbBvcnjlbHsT8yswz8",
      "url": "https://giphy.com/gifs/run-vaporwave-nightmare-KbBvcnjlbHsT8yswz8",
      "slug": "run-vaporwave-nightmare-KbBvcnjlbHsT8yswz8",
      "bitly_gif_url": "https://gph.is/g/aQO5r05",
      "bitly_url": "https://gph.is/g/aQO5r05",
      "embed_url": "https://giphy.com/embed/KbBvcnjlbHsT8yswz8",
      "username": "dualvoidanima",
      "source": "https://www.patreon.com/dualvoidanima",
      "title": "Glitch Run GIF by dualvoidanima",
      "rating": "g",
      "content_url": "",
      "source_tld": "www.patreon.com",
      "source_post_url": "https://www.patreon.com/dualvoidanima",
      "is_sticker": 0,
      "import_datetime": "2020-04-02 21:02:04",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "530",
          "width": "530",
          "size": "2882219",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "618057",
          "mp4": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "763006",
          "webp": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "24",
          "hash": "9dd1833574b4cc2f7f877d48d7c129f3"
        },
        "downsized": {
          "height": "530",
          "width": "530",
          "size": "1475154",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "530",
          "width": "530",
          "size": "2882219",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "530",
          "width": "530",
          "size": "2882219",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "220",
          "width": "220",
          "mp4_size": "53725",
          "mp4": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "530",
          "width": "530",
          "size": "60485",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "297776",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "86217",
          "mp4": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "73948",
          "webp": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "86218",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "47400",
          "webp": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "96156",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "27950",
          "mp4": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "26306",
          "webp": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "5085",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "17788",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "297776",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "86217",
          "mp4": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "73948",
          "webp": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "86218",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "47400",
          "webp": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "96156",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "27950",
          "mp4": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "26306",
          "webp": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "5085",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "17788",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "8647050",
          "mp4": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "530",
          "width": "530",
          "size": "119142",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "618057",
          "mp4": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "212",
          "width": "212",
          "mp4_size": "40319",
          "mp4": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "82",
          "width": "82",
          "size": "49429",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "102",
          "width": "102",
          "size": "19812",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "2882219",
          "url": "https://media0.giphy.com/media/KbBvcnjlbHsT8yswz8/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media1.giphy.com/avatars/dualvoidanima/cdTCKmcCw2iG.gif",
        "banner_image": "https://media1.giphy.com/headers/dualvoidanima/cFKoZxPvxmbm.gif",
        "banner_url": "https://media1.giphy.com/headers/dualvoidanima/cFKoZxPvxmbm.gif",
        "profile_url": "https://giphy.com/dualvoidanima/",
        "username": "dualvoidanima",
        "display_name": "dualvoidanima",
        "description": "dualvoidanima@gmail.com",
        "instagram_url": "https://instagram.com/dualvoidanima1",
        "website_url": "https://linktr.ee/dualvoidanima",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPUtiQnZjbmpsYkhzVDh5c3d6OCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPUtiQnZjbmpsYkhzVDh5c3d6OCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPUtiQnZjbmpsYkhzVDh5c3d6OCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPUtiQnZjbmpsYkhzVDh5c3d6OCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "rgzOwma0qMbM3x7Fqi",
      "url": "https://giphy.com/gifs/visuals-network-connectivity-rgzOwma0qMbM3x7Fqi",
      "slug": "visuals-network-connectivity-rgzOwma0qMbM3x7Fqi",
      "bitly_gif_url": "https://gph.is/g/ajM2Xnp",
      "bitly_url": "https://gph.is/g/ajM2Xnp",
      "embed_url": "https://giphy.com/embed/rgzOwma0qMbM3x7Fqi",
      "username": "xponentialdesign",
      "source": "https://bit.ly/3cQPlUg",
      "title": "Artificial Intelligence Technology GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "bit.ly",
      "source_post_url": "https://bit.ly/3cQPlUg",
      "is_sticker": 0,
      "import_datetime": "2021-04-12 05:56:32",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "540",
          "width": "540",
          "size": "41744581",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "6849476",
          "mp4": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "15086540",
          "webp": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "360",
          "hash": "2d88027fcd30e90b47ca690424671594"
        },
        "downsized": {
          "height": "331",
          "width": "331",
          "size": "1584697",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "540",
          "width": "540",
          "size": "5599018",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy-downsized-large.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-large.gif&ct=g"
        },
        "downsized_medium": {
          "height": "540",
          "width": "540",
          "size": "4480261",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "150",
          "width": "150",
          "mp4_size": "165152",
          "mp4": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "331",
          "width": "331",
          "size": "27900",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "5005228",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "1829174",
          "mp4": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "3295138",
          "webp": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "133215",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "71774",
          "webp": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "1742723",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "701075",
          "mp4": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "1299372",
          "webp": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "5781",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "14951",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "5005228",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "1829174",
          "mp4": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "3295138",
          "webp": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "133215",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "71774",
          "webp": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "1742723",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "34586",
          "mp4": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "1299372",
          "webp": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "5781",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "14951",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "3514403",
          "mp4": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "540",
          "width": "540",
          "size": "153593",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "6849476",
          "mp4": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "196",
          "width": "196",
          "mp4_size": "45010",
          "mp4": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "68",
          "width": "68",
          "size": "48689",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "124",
          "width": "124",
          "size": "49426",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "41744581",
          "url": "https://media1.giphy.com/media/rgzOwma0qMbM3x7Fqi/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media1.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "I make gifs, loops, tutorials stuff\r\n\r\nSubscribe to Xponentialdesign  Youtube Channel : \r\n\r\nhttps://bit.ly/3sud0j1\r\n\r\nSupport me on Patreon: \r\n\r\nhttp://bit.ly/2wkCVhU",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPXJnek93bWEwcU1iTTN4N0ZxaSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXJnek93bWEwcU1iTTN4N0ZxaSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXJnek93bWEwcU1iTTN4N0ZxaSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXJnek93bWEwcU1iTTN4N0ZxaSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "WUI8YI6hJs6V7qVZSF",
      "url": "https://giphy.com/gifs/WUI8YI6hJs6V7qVZSF",
      "slug": "WUI8YI6hJs6V7qVZSF",
      "bitly_gif_url": "https://gph.is/g/ZWJwbNL",
      "bitly_url": "https://gph.is/g/ZWJwbNL",
      "embed_url": "https://giphy.com/embed/WUI8YI6hJs6V7qVZSF",
      "username": "patricia_monteiro",
      "source": "https://www.behance.net/anjxx",
      "title": "Black And White Art GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "www.behance.net",
      "source_post_url": "https://www.behance.net/anjxx",
      "is_sticker": 0,
      "import_datetime": "2021-05-31 17:02:43",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "270",
          "size": "40352",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "17024",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "17430",
          "webp": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "6",
          "hash": "444a29b19d9b221656c571a10f1d6e8d"
        },
        "downsized": {
          "height": "480",
          "width": "270",
          "size": "40352",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "270",
          "size": "40352",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "270",
          "size": "40352",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "480",
          "width": "270",
          "mp4_size": "17024",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "270",
          "size": "40352",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "113",
          "size": "12365",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "8853",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "9754",
          "webp": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "113",
          "size": "12365",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "10628",
          "webp": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "57",
          "size": "6102",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "5853",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "6046",
          "webp": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "57",
          "size": "3319",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "113",
          "size": "7385",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "356",
          "width": "200",
          "size": "24653",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "14585",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "15098",
          "webp": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "356",
          "width": "200",
          "size": "24653",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "17976",
          "webp": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "178",
          "width": "100",
          "size": "11684",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "8775",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "9426",
          "webp": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "178",
          "width": "100",
          "size": "6129",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "356",
          "width": "200",
          "size": "15297",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "609677",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "270",
          "size": "24286",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "270",
          "mp4_size": "17024",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "480",
          "width": "270",
          "mp4_size": "17024",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "480",
          "width": "270",
          "size": "40352",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "480",
          "width": "270",
          "size": "18120",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "hd": {
          "height": "852",
          "width": "480",
          "mp4_size": "29306",
          "mp4": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/giphy-hd.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-hd.mp4&ct=g"
        },
        "480w_still": {
          "height": "853",
          "width": "480",
          "size": "40352",
          "url": "https://media4.giphy.com/media/WUI8YI6hJs6V7qVZSF/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media1.giphy.com/avatars/patricia_monteiro/Nb0fZhXP9gWt.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/channel/patricia_monteiro/",
        "username": "patricia_monteiro",
        "display_name": "Patrícia Monteiro",
        "description": "Hello!! \r\nI'm Patrícia Monteiro.  I am a  designer and graphic artist from portugal, currently still studyng at ESAD.CR, taking my bachelor's degree. Here is a little snipped of my what i enjoy doing, hope you like it!\r\nWork email : anjxx.graphic@gmail.com",
        "instagram_url": "https://instagram.com/_anjxx2.0",
        "website_url": "http://www.behance.net/anjxx",
        "is_verified": false
      },
      "analytics_response_payload": "e=Z2lmX2lkPVdVSThZSTZoSnM2VjdxVlpTRiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVdVSThZSTZoSnM2VjdxVlpTRiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVdVSThZSTZoSnM2VjdxVlpTRiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPVdVSThZSTZoSnM2VjdxVlpTRiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "xT9Igqq02d80wIqUpy",
      "url": "https://giphy.com/gifs/trippy-weird-psychedelic-xT9Igqq02d80wIqUpy",
      "slug": "trippy-weird-psychedelic-xT9Igqq02d80wIqUpy",
      "bitly_gif_url": "http://gph.is/2wWNedB",
      "bitly_url": "http://gph.is/2wWNedB",
      "embed_url": "https://giphy.com/embed/xT9Igqq02d80wIqUpy",
      "username": "ericaofanderson",
      "source": "https://ericaofanderson.tumblr.com/post/164715050242/digital-wasteland-you-can-get-this-gif-as-a",
      "title": "",
      "rating": "g",
      "content_url": "",
      "source_tld": "ericaofanderson.tumblr.com",
      "source_post_url": "https://ericaofanderson.tumblr.com/post/164715050242/digital-wasteland-you-can-get-this-gif-as-a",
      "is_sticker": 0,
      "import_datetime": "2017-08-28 16:25:23",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "500",
          "width": "500",
          "size": "2579488",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "653604",
          "mp4": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "778654",
          "webp": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "48",
          "hash": "5962fe6755bfc2a225008e76125183b6"
        },
        "downsized": {
          "height": "500",
          "width": "500",
          "size": "1746784",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "500",
          "width": "500",
          "size": "2579488",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "500",
          "width": "500",
          "size": "2579488",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "218",
          "width": "218",
          "mp4_size": "35293",
          "mp4": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "500",
          "width": "500",
          "size": "40041",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "603355",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "55071",
          "mp4": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "74246",
          "webp": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "90264",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "25934",
          "webp": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "144366",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "20060",
          "mp4": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "30296",
          "webp": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "3608",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "11229",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "603355",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "55071",
          "mp4": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "74246",
          "webp": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "90264",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "25934",
          "webp": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "144366",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "20060",
          "mp4": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "30296",
          "webp": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "3608",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "11229",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "2897386",
          "mp4": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "500",
          "width": "500",
          "size": "58396",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "653604",
          "mp4": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "200",
          "width": "200",
          "mp4_size": "27126",
          "mp4": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "160",
          "width": "160",
          "size": "49424",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "154",
          "width": "154",
          "size": "16708",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "2579488",
          "url": "https://media2.giphy.com/media/xT9Igqq02d80wIqUpy/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media0.giphy.com/avatars/ericaofanderson/o2iWBw9kz2m1.png",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/ericaofanderson/",
        "username": "ericaofanderson",
        "display_name": "Erica Anderson",
        "description": "I am on a quest to make fine art that moves.",
        "instagram_url": "https://instagram.com/ericaofanderson",
        "website_url": "http://ericaofanderson.com",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPXhUOUlncXEwMmQ4MHdJcVVweSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhUOUlncXEwMmQ4MHdJcVVweSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhUOUlncXEwMmQ4MHdJcVVweSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhUOUlncXEwMmQ4MHdJcVVweSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "q9AgIEA8kKWWI2paHT",
      "url": "https://giphy.com/gifs/q9AgIEA8kKWWI2paHT",
      "slug": "q9AgIEA8kKWWI2paHT",
      "bitly_gif_url": "https://gph.is/g/460mNlw",
      "bitly_url": "https://gph.is/g/460mNlw",
      "embed_url": "https://giphy.com/embed/q9AgIEA8kKWWI2paHT",
      "username": "dualvoidanima",
      "source": "https://www.patreon.com/dualvoidanima",
      "title": "Art Love GIF by dualvoidanima",
      "rating": "g",
      "content_url": "",
      "source_tld": "www.patreon.com",
      "source_post_url": "https://www.patreon.com/dualvoidanima",
      "is_sticker": 0,
      "import_datetime": "2021-03-31 15:46:50",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "485",
          "width": "485",
          "size": "5124251",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "1347911",
          "mp4": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "2027276",
          "webp": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "50",
          "hash": "072106c0be5ef85152a4571abf1d66c2"
        },
        "downsized": {
          "height": "242",
          "width": "242",
          "size": "1356242",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "485",
          "width": "485",
          "size": "5124251",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "485",
          "width": "485",
          "size": "4611794",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "192",
          "width": "192",
          "mp4_size": "97391",
          "mp4": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "242",
          "width": "242",
          "size": "27948",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "1064659",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "216631",
          "mp4": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "371172",
          "webp": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "151141",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "81372",
          "webp": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "292855",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "57019",
          "mp4": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "114084",
          "webp": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "7918",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "23845",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "1064659",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "216631",
          "mp4": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "371172",
          "webp": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "151141",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "81372",
          "webp": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "292855",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "49945",
          "mp4": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "114084",
          "webp": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "7918",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "23845",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "7251961",
          "mp4": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "485",
          "width": "485",
          "size": "153247",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "1347911",
          "mp4": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "150",
          "width": "150",
          "mp4_size": "39415",
          "mp4": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "77",
          "width": "77",
          "size": "49544",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "82",
          "width": "82",
          "size": "27414",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "5124251",
          "url": "https://media1.giphy.com/media/q9AgIEA8kKWWI2paHT/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media4.giphy.com/avatars/dualvoidanima/cdTCKmcCw2iG.gif",
        "banner_image": "https://media4.giphy.com/headers/dualvoidanima/cFKoZxPvxmbm.gif",
        "banner_url": "https://media4.giphy.com/headers/dualvoidanima/cFKoZxPvxmbm.gif",
        "profile_url": "https://giphy.com/dualvoidanima/",
        "username": "dualvoidanima",
        "display_name": "dualvoidanima",
        "description": "dualvoidanima@gmail.com",
        "instagram_url": "https://instagram.com/dualvoidanima1",
        "website_url": "https://linktr.ee/dualvoidanima",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPXE5QWdJRUE4a0tXV0kycGFIVCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXE5QWdJRUE4a0tXV0kycGFIVCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXE5QWdJRUE4a0tXV0kycGFIVCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXE5QWdJRUE4a0tXV0kycGFIVCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "xT9IgN8YKRhByRBzMI",
      "url": "https://giphy.com/gifs/loop-motion-graphics-techno-xT9IgN8YKRhByRBzMI",
      "slug": "loop-motion-graphics-techno-xT9IgN8YKRhByRBzMI",
      "bitly_gif_url": "http://gph.is/2ftCKJg",
      "bitly_url": "http://gph.is/2ftCKJg",
      "embed_url": "https://giphy.com/embed/xT9IgN8YKRhByRBzMI",
      "username": "xponentialdesign",
      "source": "https://bit.ly/321YxQi",
      "title": "Loop Techno GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "bit.ly",
      "source_post_url": "https://bit.ly/321YxQi",
      "is_sticker": 0,
      "import_datetime": "2017-09-18 06:55:06",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "540",
          "width": "540",
          "size": "10976589",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "2275117",
          "mp4": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "4397358",
          "webp": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "90",
          "hash": "7dbd276d17ae4258382d77500bba4b2e"
        },
        "downsized": {
          "height": "420",
          "width": "420",
          "size": "1956256",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "540",
          "width": "540",
          "size": "5940822",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy-downsized-large.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-large.gif&ct=g"
        },
        "downsized_medium": {
          "height": "432",
          "width": "432",
          "size": "4147847",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "154",
          "width": "154",
          "mp4_size": "188060",
          "mp4": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "420",
          "width": "420",
          "size": "44197",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "1363139",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "589003",
          "mp4": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "1076782",
          "webp": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "115207",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "76162",
          "webp": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "476493",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "216371",
          "mp4": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "366328",
          "webp": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "5979",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "15601",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "1363139",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "589003",
          "mp4": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "1076782",
          "webp": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "115207",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "76162",
          "webp": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "476493",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "47283",
          "mp4": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "366328",
          "webp": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "5979",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "15601",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "4627045",
          "mp4": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "540",
          "width": "540",
          "size": "139978",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "2275117",
          "mp4": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "170",
          "width": "170",
          "mp4_size": "47520",
          "mp4": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "81",
          "width": "81",
          "size": "33522",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "116",
          "width": "116",
          "size": "46818",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "10976589",
          "url": "https://media0.giphy.com/media/xT9IgN8YKRhByRBzMI/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media0.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "I make gifs, loops, tutorials stuff\r\n\r\nSubscribe to Xponentialdesign  Youtube Channel : \r\n\r\nhttps://bit.ly/3sud0j1\r\n\r\nSupport me on Patreon: \r\n\r\nhttp://bit.ly/2wkCVhU",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPXhUOUlnTjhZS1JoQnlSQnpNSSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhUOUlnTjhZS1JoQnlSQnpNSSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhUOUlnTjhZS1JoQnlSQnpNSSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhUOUlnTjhZS1JoQnlSQnpNSSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "xUOwGdcOfbq12yVhTi",
      "url": "https://giphy.com/gifs/glitch-run-cycle-xUOwGdcOfbq12yVhTi",
      "slug": "glitch-run-cycle-xUOwGdcOfbq12yVhTi",
      "bitly_gif_url": "http://gph.is/2EhmSs1",
      "bitly_url": "http://gph.is/2EhmSs1",
      "embed_url": "https://giphy.com/embed/xUOwGdcOfbq12yVhTi",
      "username": "thepatco",
      "source": "",
      "title": "3D Running GIF by thepatco",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2018-02-09 20:47:36",
      "trending_datetime": "2018-05-09 07:45:01",
      "images": {
        "original": {
          "height": "480",
          "width": "384",
          "size": "1457613",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "723846",
          "mp4": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "344638",
          "webp": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "15",
          "hash": "f55493178321760f43bd6d396f2a0553"
        },
        "downsized": {
          "height": "480",
          "width": "384",
          "size": "1457613",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "384",
          "size": "1457613",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "384",
          "size": "1457613",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "318",
          "width": "254",
          "mp4_size": "84774",
          "mp4": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "384",
          "size": "1457613",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "160",
          "size": "225733",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "76520",
          "mp4": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "84194",
          "webp": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "160",
          "size": "96540",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "66194",
          "webp": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "80",
          "size": "62864",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "26519",
          "mp4": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "26066",
          "webp": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "80",
          "size": "4736",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "160",
          "size": "17686",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "250",
          "width": "200",
          "size": "299023",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "114325",
          "mp4": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "121626",
          "webp": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "250",
          "width": "200",
          "size": "122590",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "94868",
          "webp": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "125",
          "width": "100",
          "size": "89577",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "36788",
          "mp4": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "38136",
          "webp": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "125",
          "width": "100",
          "size": "6661",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "250",
          "width": "200",
          "size": "21011",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "12915385",
          "mp4": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "384",
          "size": "107028",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "600",
          "width": "480",
          "mp4_size": "723846",
          "mp4": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "192",
          "width": "153",
          "mp4_size": "27085",
          "mp4": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "159",
          "width": "127",
          "size": "46299",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "150",
          "width": "120",
          "size": "36210",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "600",
          "width": "480",
          "size": "1457613",
          "url": "https://media2.giphy.com/media/xUOwGdcOfbq12yVhTi/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media1.giphy.com/avatars/thepatco/r4dgl51YN3ej.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/thepatco/",
        "username": "thepatco",
        "display_name": "thepatco",
        "description": "( づ◔◡◔)づ",
        "instagram_url": "https://instagram.com/thepatco",
        "website_url": "https://linktr.ee/thepatco",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPXhVT3dHZGNPZmJxMTJ5VmhUaSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhVT3dHZGNPZmJxMTJ5VmhUaSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhVT3dHZGNPZmJxMTJ5VmhUaSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhVT3dHZGNPZmJxMTJ5VmhUaSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "xT9IgBTguwyFn8XiMg",
      "url": "https://giphy.com/gifs/xT9IgBTguwyFn8XiMg",
      "slug": "xT9IgBTguwyFn8XiMg",
      "bitly_gif_url": "http://gph.is/2gaP3L4",
      "bitly_url": "http://gph.is/2gaP3L4",
      "embed_url": "https://giphy.com/embed/xT9IgBTguwyFn8XiMg",
      "username": "thepatco",
      "source": "",
      "title": "Pink 3D GIF by thepatco",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2017-10-04 14:11:46",
      "trending_datetime": "2017-10-05 03:15:01",
      "images": {
        "original": {
          "height": "500",
          "width": "500",
          "size": "3680071",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "1049644",
          "mp4": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1304522",
          "webp": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "30",
          "hash": "27fd8e098220e7a2da0857c47b9c6a01"
        },
        "downsized": {
          "height": "361",
          "width": "361",
          "size": "1436176",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "500",
          "width": "500",
          "size": "3680071",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "500",
          "width": "500",
          "size": "3680071",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "200",
          "width": "200",
          "mp4_size": "75772",
          "mp4": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "361",
          "width": "361",
          "size": "56573",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "533676",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "138619",
          "mp4": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "235820",
          "webp": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "129095",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "108640",
          "webp": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "162537",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "42091",
          "mp4": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "71924",
          "webp": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "7146",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "20572",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "533676",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "138619",
          "mp4": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "235820",
          "webp": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "129095",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "108640",
          "webp": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "162537",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "42091",
          "mp4": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "71924",
          "webp": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "7146",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "20572",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "12333575",
          "mp4": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "500",
          "width": "500",
          "size": "122990",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "1049644",
          "mp4": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "150",
          "width": "150",
          "mp4_size": "49513",
          "mp4": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "98",
          "width": "98",
          "size": "46886",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "76",
          "width": "76",
          "size": "27752",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "3680071",
          "url": "https://media3.giphy.com/media/xT9IgBTguwyFn8XiMg/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media0.giphy.com/avatars/thepatco/r4dgl51YN3ej.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/thepatco/",
        "username": "thepatco",
        "display_name": "thepatco",
        "description": "( づ◔◡◔)づ",
        "instagram_url": "https://instagram.com/thepatco",
        "website_url": "https://linktr.ee/thepatco",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPXhUOUlnQlRndXd5Rm44WGlNZyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhUOUlnQlRndXd5Rm44WGlNZyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhUOUlnQlRndXd5Rm44WGlNZyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXhUOUlnQlRndXd5Rm44WGlNZyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "ehssta24116nk9VWyN",
      "url": "https://giphy.com/gifs/black-and-white-pattern-hexagon-ehssta24116nk9VWyN",
      "slug": "black-and-white-pattern-hexagon-ehssta24116nk9VWyN",
      "bitly_gif_url": "https://gph.is/g/E3mdKdN",
      "bitly_url": "https://gph.is/g/E3mdKdN",
      "embed_url": "https://giphy.com/embed/ehssta24116nk9VWyN",
      "username": "xponentialdesign",
      "source": "https://bit.ly/3sud0j1",
      "title": "Black And White Design GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "bit.ly",
      "source_post_url": "https://bit.ly/3sud0j1",
      "is_sticker": 0,
      "import_datetime": "2020-03-13 15:52:33",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "640",
          "width": "640",
          "size": "13088349",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "5376200",
          "mp4": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "7391932",
          "webp": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "336",
          "hash": "ca7cd82c34372ddaa5499fe11cd0a7dc"
        },
        "downsized": {
          "height": "640",
          "width": "640",
          "size": "1862069",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "640",
          "width": "640",
          "size": "2929229",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy-downsized-large.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-large.gif&ct=g"
        },
        "downsized_medium": {
          "height": "640",
          "width": "640",
          "size": "2376548",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "150",
          "width": "150",
          "mp4_size": "182935",
          "mp4": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "640",
          "width": "640",
          "size": "77144",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "2605717",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "1616582",
          "mp4": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "1375890",
          "webp": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "53860",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "55434",
          "webp": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "833192",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "440572",
          "mp4": "https://media4.giphy.com/media/ehssta24116nk9VWyN/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "403536",
          "webp": "https://media4.giphy.com/media/ehssta24116nk9VWyN/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "6318",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "23901",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "2605717",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "1616582",
          "mp4": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "1375890",
          "webp": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "53860",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "55434",
          "webp": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "833192",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "45931",
          "mp4": "https://media4.giphy.com/media/ehssta24116nk9VWyN/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "403536",
          "webp": "https://media4.giphy.com/media/ehssta24116nk9VWyN/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "6318",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "23901",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "6585464",
          "mp4": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "640",
          "width": "640",
          "size": "99484",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "5376200",
          "mp4": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "150",
          "width": "150",
          "mp4_size": "47186",
          "mp4": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "114",
          "width": "114",
          "size": "47932",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "128",
          "width": "128",
          "size": "23628",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "13088349",
          "url": "https://media4.giphy.com/media/ehssta24116nk9VWyN/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media0.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "I make gifs, loops, tutorials stuff\r\n\r\nSubscribe to Xponentialdesign  Youtube Channel : \r\n\r\nhttps://bit.ly/3sud0j1\r\n\r\nSupport me on Patreon: \r\n\r\nhttp://bit.ly/2wkCVhU",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPWVoc3N0YTI0MTE2bms5Vld5TiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWVoc3N0YTI0MTE2bms5Vld5TiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWVoc3N0YTI0MTE2bms5Vld5TiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWVoc3N0YTI0MTE2bms5Vld5TiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "tVM0hQmU52iKcLI1Kk",
      "url": "https://giphy.com/gifs/loop-retro-vhs-tVM0hQmU52iKcLI1Kk",
      "slug": "loop-retro-vhs-tVM0hQmU52iKcLI1Kk",
      "bitly_gif_url": "https://gph.is/g/ZrxMvKx",
      "bitly_url": "https://gph.is/g/ZrxMvKx",
      "embed_url": "https://giphy.com/embed/tVM0hQmU52iKcLI1Kk",
      "username": "xponentialdesign",
      "source": "https://bit.ly/30yKTGB",
      "title": "Loop Vintage GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "bit.ly",
      "source_post_url": "https://bit.ly/30yKTGB",
      "is_sticker": 0,
      "import_datetime": "2021-10-01 10:24:27",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "359698",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "48144",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "70798",
          "webp": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "9",
          "hash": "11da17f139514aa738fea26d9265c4b4"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "359698",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "359698",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "359698",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "480",
          "width": "480",
          "mp4_size": "47567",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "359698",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "150035",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "15840",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "18802",
          "webp": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "90659",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "36946",
          "webp": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "29331",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "7244",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "8036",
          "webp": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "3926",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "11429",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "150035",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "15840",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "18802",
          "webp": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "90659",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "36946",
          "webp": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "29331",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "7244",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "8036",
          "webp": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "3926",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "11429",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "2155942",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "77266",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "48144",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "480",
          "width": "480",
          "mp4_size": "47567",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "90",
          "width": "90",
          "size": "49984",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "364",
          "width": "364",
          "size": "44208",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "hd": {
          "height": "1080",
          "width": "1080",
          "mp4_size": "150636",
          "mp4": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/giphy-hd.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-hd.mp4&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "359698",
          "url": "https://media4.giphy.com/media/tVM0hQmU52iKcLI1Kk/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media2.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "I make gifs, loops, tutorials stuff\r\n\r\nSubscribe to Xponentialdesign  Youtube Channel : \r\n\r\nhttps://bit.ly/3sud0j1\r\n\r\nSupport me on Patreon: \r\n\r\nhttp://bit.ly/2wkCVhU",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPXRWTTBoUW1VNTJpS2NMSTFLayZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXRWTTBoUW1VNTJpS2NMSTFLayZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXRWTTBoUW1VNTJpS2NMSTFLayZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXRWTTBoUW1VNTJpS2NMSTFLayZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "3o7WTxWHqKTg7BaInu",
      "url": "https://giphy.com/gifs/simpsons-tron-homersimpson-3o7WTxWHqKTg7BaInu",
      "slug": "simpsons-tron-homersimpson-3o7WTxWHqKTg7BaInu",
      "bitly_gif_url": "http://gph.is/1XJDPdx",
      "bitly_url": "http://gph.is/1XJDPdx",
      "embed_url": "https://giphy.com/embed/3o7WTxWHqKTg7BaInu",
      "username": "miri-ganser",
      "source": "http://miriamganser.de/",
      "title": "homer simpson 3d GIF by Miriam Ganser",
      "rating": "g",
      "content_url": "",
      "source_tld": "miriamganser.de",
      "source_post_url": "http://miriamganser.de/",
      "is_sticker": 0,
      "import_datetime": "2016-03-22 12:11:03",
      "trending_datetime": "1970-01-01 00:00:00",
      "images": {
        "original": {
          "height": "288",
          "width": "369",
          "size": "544551",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "399008",
          "mp4": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "328274",
          "webp": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "37",
          "hash": "7915ae01c2cce9b8438d282215e813f7"
        },
        "downsized": {
          "height": "288",
          "width": "369",
          "size": "544551",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "288",
          "width": "369",
          "size": "544551",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "288",
          "width": "369",
          "size": "544551",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "258",
          "width": "329",
          "mp4_size": "69918",
          "mp4": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "288",
          "width": "369",
          "size": "544551",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "256",
          "size": "308762",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "82143",
          "mp4": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "164950",
          "webp": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "256",
          "size": "106431",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "66370",
          "webp": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "128",
          "size": "111090",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "22672",
          "mp4": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "72860",
          "webp": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "128",
          "size": "5933",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "256",
          "size": "17035",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "156",
          "width": "200",
          "size": "213906",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "50923",
          "mp4": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "128552",
          "webp": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "156",
          "width": "200",
          "size": "80420",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "46150",
          "webp": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "78",
          "width": "100",
          "size": "74718",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "15011",
          "mp4": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "54252",
          "webp": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "78",
          "width": "100",
          "size": "4221",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "156",
          "width": "200",
          "size": "14546",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1210502",
          "mp4": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "288",
          "width": "369",
          "size": "60137",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "374",
          "width": "480",
          "mp4_size": "399008",
          "mp4": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "230",
          "width": "293",
          "mp4_size": "26161",
          "mp4": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "95",
          "width": "122",
          "size": "49557",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "166",
          "width": "212",
          "size": "43282",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "375",
          "width": "480",
          "size": "544551",
          "url": "https://media2.giphy.com/media/3o7WTxWHqKTg7BaInu/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media1.giphy.com/avatars/miri-ganser/56ymWc4rB531.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/miri-ganser/",
        "username": "miri-ganser",
        "display_name": "Miriam Ganser",
        "description": "I'm a communication designer and artist in love with post-internet art",
        "instagram_url": "https://instagram.com/moire_gradient",
        "website_url": "https://miriamganser.de",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTNvN1dUeFdIcUtUZzdCYUludSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvN1dUeFdIcUtUZzdCYUludSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvN1dUeFdIcUtUZzdCYUludSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvN1dUeFdIcUtUZzdCYUludSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "vJfWmEboAQS1YXQe6a",
      "url": "https://giphy.com/gifs/game-jogo-paper-vJfWmEboAQS1YXQe6a",
      "slug": "game-jogo-paper-vJfWmEboAQS1YXQe6a",
      "bitly_gif_url": "https://gph.is/g/EG8kXdd",
      "bitly_url": "https://gph.is/g/EG8kXdd",
      "embed_url": "https://giphy.com/embed/vJfWmEboAQS1YXQe6a",
      "username": "patricia_monteiro",
      "source": "https://www.behance.net/anjxx",
      "title": "Tic Tac Toe Game GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "www.behance.net",
      "source_post_url": "https://www.behance.net/anjxx",
      "is_sticker": 0,
      "import_datetime": "2021-04-17 20:56:24",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "270",
          "size": "8364",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "8634",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "6306",
          "webp": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "21",
          "hash": "290fc3787b15e90e4840cbb51cf0baec"
        },
        "downsized": {
          "height": "480",
          "width": "270",
          "size": "8364",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "270",
          "size": "8364",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "270",
          "size": "8364",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "480",
          "width": "270",
          "mp4_size": "8634",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "270",
          "size": "8364",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "113",
          "size": "4077",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "5411",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "2664",
          "webp": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "113",
          "size": "3422",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "2668",
          "webp": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "57",
          "size": "2605",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "4516",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "1658",
          "webp": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "57",
          "size": "453",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "113",
          "size": "865",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "356",
          "width": "200",
          "size": "7491",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "7291",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "4918",
          "webp": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "356",
          "width": "200",
          "size": "5908",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "3628",
          "webp": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "178",
          "width": "100",
          "size": "4474",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "5110",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "2580",
          "webp": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "178",
          "width": "100",
          "size": "1299",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "356",
          "width": "200",
          "size": "2126",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "15834",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "270",
          "size": "1864",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "270",
          "mp4_size": "8634",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "480",
          "width": "270",
          "mp4_size": "8634",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "480",
          "width": "270",
          "size": "8364",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "480",
          "width": "270",
          "size": "6516",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "hd": {
          "height": "852",
          "width": "480",
          "mp4_size": "12343",
          "mp4": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/giphy-hd.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-hd.mp4&ct=g"
        },
        "480w_still": {
          "height": "853",
          "width": "480",
          "size": "8364",
          "url": "https://media1.giphy.com/media/vJfWmEboAQS1YXQe6a/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media0.giphy.com/avatars/patricia_monteiro/Nb0fZhXP9gWt.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/channel/patricia_monteiro/",
        "username": "patricia_monteiro",
        "display_name": "Patrícia Monteiro",
        "description": "Hello!! \r\nI'm Patrícia Monteiro.  I am a  designer and graphic artist from portugal, currently still studyng at ESAD.CR, taking my bachelor's degree. Here is a little snipped of my what i enjoy doing, hope you like it!\r\nWork email : anjxx.graphic@gmail.com",
        "instagram_url": "https://instagram.com/_anjxx2.0",
        "website_url": "http://www.behance.net/anjxx",
        "is_verified": false
      },
      "analytics_response_payload": "e=Z2lmX2lkPXZKZldtRWJvQVFTMVlYUWU2YSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXZKZldtRWJvQVFTMVlYUWU2YSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXZKZldtRWJvQVFTMVlYUWU2YSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXZKZldtRWJvQVFTMVlYUWU2YSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "3ov9jKQbfWvDNu2Z0s",
      "url": "https://giphy.com/gifs/animation-loop-3d-3ov9jKQbfWvDNu2Z0s",
      "slug": "animation-loop-3d-3ov9jKQbfWvDNu2Z0s",
      "bitly_gif_url": "http://gph.is/2fVannu",
      "bitly_url": "http://gph.is/2fVannu",
      "embed_url": "https://giphy.com/embed/3ov9jKQbfWvDNu2Z0s",
      "username": "lefler",
      "source": "",
      "title": " ",
      "rating": "g",
      "content_url": "",
      "source_tld": "",
      "source_post_url": "",
      "is_sticker": 0,
      "import_datetime": "2017-09-28 19:46:32",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "1552383",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "650487",
          "mp4": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "487348",
          "webp": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "91",
          "hash": "e3d09f6f88efa8a8159cd8e819bebfda"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "1552383",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "1552383",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "1552383",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "266",
          "width": "266",
          "mp4_size": "130099",
          "mp4": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "1552383",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "391922",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "194956",
          "mp4": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "188126",
          "webp": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "25966",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "13316",
          "webp": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "147421",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "77874",
          "mp4": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "95532",
          "webp": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "2377",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "4787",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "391922",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "194956",
          "mp4": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "188126",
          "webp": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "25966",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "13316",
          "webp": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "147421",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "48804",
          "mp4": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "95532",
          "webp": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "2377",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "4787",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1624788",
          "mp4": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "17508",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "650487",
          "mp4": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "348",
          "width": "348",
          "mp4_size": "35321",
          "mp4": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "81",
          "width": "81",
          "size": "36554",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "452",
          "width": "452",
          "size": "49304",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "1552383",
          "url": "https://media0.giphy.com/media/3ov9jKQbfWvDNu2Z0s/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/lefler/634ANe4BmPdx.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/lefler/",
        "username": "lefler",
        "display_name": "lefler",
        "description": "chicken stylish!",
        "instagram_url": "https://instagram.com/ed.lefler",
        "website_url": "",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTNvdjlqS1FiZld2RE51MlowcyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvdjlqS1FiZld2RE51MlowcyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvdjlqS1FiZld2RE51MlowcyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTNvdjlqS1FiZld2RE51MlowcyZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "1qi7QrI1edaOFNB4wF",
      "url": "https://giphy.com/gifs/black-and-white-loop-trippy-1qi7QrI1edaOFNB4wF",
      "slug": "black-and-white-loop-trippy-1qi7QrI1edaOFNB4wF",
      "bitly_gif_url": "https://gph.is/2K2N78j",
      "bitly_url": "https://gph.is/2K2N78j",
      "embed_url": "https://giphy.com/embed/1qi7QrI1edaOFNB4wF",
      "username": "pislices",
      "source": "http://pislices.ca",
      "title": "black and white loop GIF by Pi-Slices",
      "rating": "g",
      "content_url": "",
      "source_tld": "pislices.ca",
      "source_post_url": "http://pislices.ca",
      "is_sticker": 0,
      "import_datetime": "2018-06-22 17:58:33",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "500",
          "width": "500",
          "size": "1703160",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "531273",
          "mp4": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "532298",
          "webp": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "60",
          "hash": "ed8309bc6e5c4cb42e5072e0251e307b"
        },
        "downsized": {
          "height": "500",
          "width": "500",
          "size": "1703160",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "500",
          "width": "500",
          "size": "1703160",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "500",
          "width": "500",
          "size": "1703160",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "290",
          "width": "290",
          "mp4_size": "114959",
          "mp4": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "500",
          "width": "500",
          "size": "1703160",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "448017",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "109756",
          "mp4": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "81424",
          "webp": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "59097",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "56424",
          "webp": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "145760",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "22700",
          "mp4": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "15780",
          "webp": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "3420",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "10530",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "448017",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "109756",
          "mp4": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "102630",
          "webp": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "59097",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "56424",
          "webp": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "145760",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "22700",
          "mp4": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "18610",
          "webp": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "3420",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "10530",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "3742959",
          "mp4": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "500",
          "width": "500",
          "size": "69827",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "531273",
          "mp4": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "200",
          "width": "200",
          "mp4_size": "43862",
          "mp4": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "81",
          "width": "81",
          "size": "48235",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "188",
          "width": "188",
          "size": "30968",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "1703160",
          "url": "https://media3.giphy.com/media/1qi7QrI1edaOFNB4wF/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media0.giphy.com/avatars/pislices/Shmn6hpof8QT.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/pislices/",
        "username": "pislices",
        "display_name": "Pi-Slices",
        "description": "GIF Artist. For commission inquiries or to license use of my GIFs, email pi-slices@hotmail.com. NFT links: pislices.art/NFT",
        "instagram_url": "https://instagram.com/pislices",
        "website_url": "http://pislices.art/",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTFxaTdRckkxZWRhT0ZOQjR3RiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTFxaTdRckkxZWRhT0ZOQjR3RiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTFxaTdRckkxZWRhT0ZOQjR3RiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTFxaTdRckkxZWRhT0ZOQjR3RiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "Mc1yxvp8fIGuYXHJI0",
      "url": "https://giphy.com/gifs/stock-wall-street-stockmarket-Mc1yxvp8fIGuYXHJI0",
      "slug": "stock-wall-street-stockmarket-Mc1yxvp8fIGuYXHJI0",
      "bitly_gif_url": "https://gph.is/g/Zd10n0P",
      "bitly_url": "https://gph.is/g/Zd10n0P",
      "embed_url": "https://giphy.com/embed/Mc1yxvp8fIGuYXHJI0",
      "username": "xponentialdesign",
      "source": "https://bit.ly/2YSw1zf",
      "title": "Wall Street Loop GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "bit.ly",
      "source_post_url": "https://bit.ly/2YSw1zf",
      "is_sticker": 0,
      "import_datetime": "2020-08-12 05:07:31",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "9282339",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "2321400",
          "mp4": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "3281774",
          "webp": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "300",
          "hash": "bb0e02494efecde603be2b3ba82c196f"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "1447418",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "7217296",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy-downsized-large.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-large.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "1948142",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "152",
          "width": "152",
          "mp4_size": "168723",
          "mp4": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "35158",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "1617079",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "414050",
          "mp4": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "795854",
          "webp": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "39347",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "25844",
          "webp": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "572873",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "150240",
          "mp4": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "302884",
          "webp": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "3310",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "10157",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "1617079",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "414050",
          "mp4": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "795854",
          "webp": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "39347",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "25844",
          "webp": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "572873",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "39454",
          "mp4": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "302884",
          "webp": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "3310",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "10157",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1575031",
          "mp4": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "44125",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "2321400",
          "mp4": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "300",
          "width": "300",
          "mp4_size": "34052",
          "mp4": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "118",
          "width": "118",
          "size": "48801",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "262",
          "width": "262",
          "size": "40620",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "9282339",
          "url": "https://media4.giphy.com/media/Mc1yxvp8fIGuYXHJI0/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "I make gifs, loops, tutorials stuff\r\n\r\nSubscribe to Xponentialdesign  Youtube Channel : \r\n\r\nhttps://bit.ly/3sud0j1\r\n\r\nSupport me on Patreon: \r\n\r\nhttp://bit.ly/2wkCVhU",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPU1jMXl4dnA4ZklHdVlYSEpJMCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU1jMXl4dnA4ZklHdVlYSEpJMCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU1jMXl4dnA4ZklHdVlYSEpJMCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU1jMXl4dnA4ZklHdVlYSEpJMCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "M8b747E4YlcuXSh71N",
      "url": "https://giphy.com/gifs/M8b747E4YlcuXSh71N",
      "slug": "M8b747E4YlcuXSh71N",
      "bitly_gif_url": "https://gph.is/g/4wY68zD",
      "bitly_url": "https://gph.is/g/4wY68zD",
      "embed_url": "https://giphy.com/embed/M8b747E4YlcuXSh71N",
      "username": "patricia_monteiro",
      "source": "https://www.behance.net/anjxx",
      "title": "Tic Tac Toe Design GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "www.behance.net",
      "source_post_url": "https://www.behance.net/anjxx",
      "is_sticker": 0,
      "import_datetime": "2021-04-13 21:10:04",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "15615",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "15229",
          "mp4": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "10086",
          "webp": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "4",
          "hash": "5b3cfc79ac2f1522d69c06d8c5f39679"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "15615",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "15615",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "15615",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "480",
          "width": "480",
          "mp4_size": "15229",
          "mp4": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "15615",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "5820",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "6864",
          "mp4": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "5076",
          "webp": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "5820",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "5200",
          "webp": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "3310",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "3998",
          "mp4": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "2728",
          "webp": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "1207",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "2410",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "5820",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "6864",
          "mp4": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "5076",
          "webp": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "5820",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "5200",
          "webp": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "3310",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "3998",
          "mp4": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "2728",
          "webp": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "1207",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "2410",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "109117",
          "mp4": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "4627",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "15229",
          "mp4": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "480",
          "width": "480",
          "mp4_size": "15229",
          "mp4": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "480",
          "width": "480",
          "size": "15615",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "480",
          "width": "480",
          "size": "11154",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "15615",
          "url": "https://media3.giphy.com/media/M8b747E4YlcuXSh71N/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/patricia_monteiro/Nb0fZhXP9gWt.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/channel/patricia_monteiro/",
        "username": "patricia_monteiro",
        "display_name": "Patrícia Monteiro",
        "description": "Hello!! \r\nI'm Patrícia Monteiro.  I am a  designer and graphic artist from portugal, currently still studyng at ESAD.CR, taking my bachelor's degree. Here is a little snipped of my what i enjoy doing, hope you like it!\r\nWork email : anjxx.graphic@gmail.com",
        "instagram_url": "https://instagram.com/_anjxx2.0",
        "website_url": "http://www.behance.net/anjxx",
        "is_verified": false
      },
      "analytics_response_payload": "e=Z2lmX2lkPU04Yjc0N0U0WWxjdVhTaDcxTiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU04Yjc0N0U0WWxjdVhTaDcxTiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU04Yjc0N0U0WWxjdVhTaDcxTiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU04Yjc0N0U0WWxjdVhTaDcxTiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "5dYqPVcoq9mKuxleyR",
      "url": "https://giphy.com/gifs/mograph-stardust-stardustae-5dYqPVcoq9mKuxleyR",
      "slug": "mograph-stardust-stardustae-5dYqPVcoq9mKuxleyR",
      "bitly_gif_url": "https://gph.is/2C0zDUW",
      "bitly_url": "https://gph.is/2C0zDUW",
      "embed_url": "https://giphy.com/embed/5dYqPVcoq9mKuxleyR",
      "username": "xponentialdesign",
      "source": "https://videohive.net/item/stardust-upwards-square-grid/22982290?ref=xponentialdesign",
      "title": "loop shoot up GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "videohive.net",
      "source_post_url": "https://videohive.net/item/stardust-upwards-square-grid/22982290?ref=xponentialdesign",
      "is_sticker": 0,
      "import_datetime": "2018-12-10 16:40:52",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "540",
          "width": "540",
          "size": "3906780",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "980597",
          "mp4": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1970506",
          "webp": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "45",
          "hash": "170df3ce635d8e441c1d342f0edcb10f"
        },
        "downsized": {
          "height": "342",
          "width": "342",
          "size": "1483910",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "540",
          "width": "540",
          "size": "3906780",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "540",
          "width": "540",
          "size": "3906780",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "216",
          "width": "216",
          "mp4_size": "97581",
          "mp4": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "342",
          "width": "342",
          "size": "35486",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "692493",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "153804",
          "mp4": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "310186",
          "webp": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "140853",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "56358",
          "webp": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "230435",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "50356",
          "mp4": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "111242",
          "webp": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "5940",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "16748",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "692493",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "153804",
          "mp4": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "310186",
          "webp": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "140853",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "56358",
          "webp": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "230435",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "49007",
          "mp4": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "111242",
          "webp": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "5940",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "16748",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "2980733",
          "mp4": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "540",
          "width": "540",
          "size": "93203",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "980597",
          "mp4": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "220",
          "width": "220",
          "mp4_size": "40123",
          "mp4": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "100",
          "width": "100",
          "size": "44982",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "122",
          "width": "122",
          "size": "35240",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "3906780",
          "url": "https://media3.giphy.com/media/5dYqPVcoq9mKuxleyR/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media4.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "I make gifs, loops, tutorials stuff\r\n\r\nSubscribe to Xponentialdesign  Youtube Channel : \r\n\r\nhttps://bit.ly/3sud0j1\r\n\r\nSupport me on Patreon: \r\n\r\nhttp://bit.ly/2wkCVhU",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTVkWXFQVmNvcTltS3V4bGV5UiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTVkWXFQVmNvcTltS3V4bGV5UiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTVkWXFQVmNvcTltS3V4bGV5UiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTVkWXFQVmNvcTltS3V4bGV5UiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "NXEuPHCOiJujANVznL",
      "url": "https://giphy.com/gifs/visuals-network-connectivity-NXEuPHCOiJujANVznL",
      "slug": "visuals-network-connectivity-NXEuPHCOiJujANVznL",
      "bitly_gif_url": "https://gph.is/g/apK2rev",
      "bitly_url": "https://gph.is/g/apK2rev",
      "embed_url": "https://giphy.com/embed/NXEuPHCOiJujANVznL",
      "username": "xponentialdesign",
      "source": "https://bit.ly/3D61EqB",
      "title": "Artificial Intelligence Orange GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "bit.ly",
      "source_post_url": "https://bit.ly/3D61EqB",
      "is_sticker": 0,
      "import_datetime": "2021-04-11 22:00:07",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "36488855",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "4561788",
          "mp4": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "7600426",
          "webp": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "360",
          "hash": "0c9d165dbdb7c5cb67f452ad72975bb4"
        },
        "downsized": {
          "height": "305",
          "width": "305",
          "size": "1497951",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "5331391",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy-downsized-large.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-large.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "4267283",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "150",
          "width": "150",
          "mp4_size": "177424",
          "mp4": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "305",
          "width": "305",
          "size": "25679",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "5346070",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "1257088",
          "mp4": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "2095216",
          "webp": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "124553",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "73572",
          "webp": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "1860546",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "482162",
          "mp4": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "827588",
          "webp": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "5904",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "15562",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "5346070",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "1257088",
          "mp4": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "2095216",
          "webp": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "124553",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "73572",
          "webp": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "1860546",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "42546",
          "mp4": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "827588",
          "webp": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "5904",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "15562",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "5948856",
          "mp4": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "154940",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "4561788",
          "mp4": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "192",
          "width": "192",
          "mp4_size": "43038",
          "mp4": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "69",
          "width": "69",
          "size": "47587",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "108",
          "width": "108",
          "size": "40808",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "36488855",
          "url": "https://media2.giphy.com/media/NXEuPHCOiJujANVznL/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media4.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "I make gifs, loops, tutorials stuff\r\n\r\nSubscribe to Xponentialdesign  Youtube Channel : \r\n\r\nhttps://bit.ly/3sud0j1\r\n\r\nSupport me on Patreon: \r\n\r\nhttp://bit.ly/2wkCVhU",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPU5YRXVQSENPaUp1akFOVnpuTCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU5YRXVQSENPaUp1akFOVnpuTCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU5YRXVQSENPaUp1akFOVnpuTCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU5YRXVQSENPaUp1akFOVnpuTCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "qAWWpdxRzQCFEVGbiJ",
      "url": "https://giphy.com/gifs/qAWWpdxRzQCFEVGbiJ",
      "slug": "qAWWpdxRzQCFEVGbiJ",
      "bitly_gif_url": "https://gph.is/g/4gMXAAq",
      "bitly_url": "https://gph.is/g/4gMXAAq",
      "embed_url": "https://giphy.com/embed/qAWWpdxRzQCFEVGbiJ",
      "username": "patricia_monteiro",
      "source": "https://www.behance.net/anjxx",
      "title": "Tic Tac Toe Game GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "www.behance.net",
      "source_post_url": "https://www.behance.net/anjxx",
      "is_sticker": 0,
      "import_datetime": "2021-04-13 21:08:43",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "480",
          "width": "480",
          "size": "17270",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "15927",
          "mp4": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "12684",
          "webp": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "6",
          "hash": "86dd65418ca52e016a5bd755031b20c8"
        },
        "downsized": {
          "height": "480",
          "width": "480",
          "size": "17270",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "480",
          "width": "480",
          "size": "17270",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "480",
          "width": "480",
          "size": "17270",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "480",
          "width": "480",
          "mp4_size": "15927",
          "mp4": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "480",
          "width": "480",
          "size": "17270",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "6416",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "6517",
          "mp4": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "5620",
          "webp": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "6416",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "6226",
          "webp": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "3586",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "3959",
          "mp4": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "2860",
          "webp": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "1781",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "2822",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "6416",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "6517",
          "mp4": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "5620",
          "webp": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "6416",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "6226",
          "webp": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "3586",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "3959",
          "mp4": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "2860",
          "webp": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "1781",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "2822",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "116417",
          "mp4": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "480",
          "width": "480",
          "size": "6160",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "15927",
          "mp4": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "480",
          "width": "480",
          "mp4_size": "15927",
          "mp4": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "480",
          "width": "480",
          "size": "17270",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "480",
          "width": "480",
          "size": "12958",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "17270",
          "url": "https://media2.giphy.com/media/qAWWpdxRzQCFEVGbiJ/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/patricia_monteiro/Nb0fZhXP9gWt.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/channel/patricia_monteiro/",
        "username": "patricia_monteiro",
        "display_name": "Patrícia Monteiro",
        "description": "Hello!! \r\nI'm Patrícia Monteiro.  I am a  designer and graphic artist from portugal, currently still studyng at ESAD.CR, taking my bachelor's degree. Here is a little snipped of my what i enjoy doing, hope you like it!\r\nWork email : anjxx.graphic@gmail.com",
        "instagram_url": "https://instagram.com/_anjxx2.0",
        "website_url": "http://www.behance.net/anjxx",
        "is_verified": false
      },
      "analytics_response_payload": "e=Z2lmX2lkPXFBV1dwZHhSelFDRkVWR2JpSiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXFBV1dwZHhSelFDRkVWR2JpSiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXFBV1dwZHhSelFDRkVWR2JpSiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXFBV1dwZHhSelFDRkVWR2JpSiZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "12LZQ9YA84nLYQ",
      "url": "https://giphy.com/gifs/animation-sci-fi-animated-gif-12LZQ9YA84nLYQ",
      "slug": "animation-sci-fi-animated-gif-12LZQ9YA84nLYQ",
      "bitly_gif_url": "http://gph.is/1hDmcc3",
      "bitly_url": "http://gph.is/1hDmcc3",
      "embed_url": "https://giphy.com/embed/12LZQ9YA84nLYQ",
      "username": "scottgelber",
      "source": "http://time-cop.tumblr.com/post/55819395428/bladeroller-2013-commission",
      "title": "Rollerblading Alien Sci-Fi GIF by Scott Gelber",
      "rating": "g",
      "content_url": "",
      "source_tld": "time-cop.tumblr.com",
      "source_post_url": "http://time-cop.tumblr.com/post/55819395428/bladeroller-2013-commission",
      "is_sticker": 0,
      "import_datetime": "2013-11-02 23:52:06",
      "trending_datetime": "2014-10-09 18:06:17",
      "images": {
        "original": {
          "height": "281",
          "width": "500",
          "size": "369834",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "89959",
          "mp4": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "140538",
          "webp": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "18",
          "hash": "0f01d04da810fe972a328f8592100bc6"
        },
        "downsized": {
          "height": "281",
          "width": "500",
          "size": "369834",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "281",
          "width": "500",
          "size": "369834",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "281",
          "width": "500",
          "size": "369834",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "280",
          "width": "500",
          "mp4_size": "99199",
          "mp4": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "281",
          "width": "500",
          "size": "369834",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "356",
          "size": "195917",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "52620",
          "mp4": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "84388",
          "webp": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "356",
          "size": "74260",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "56388",
          "webp": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "178",
          "size": "67182",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "19695",
          "mp4": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "31426",
          "webp": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "178",
          "size": "5721",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "356",
          "size": "15841",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "112",
          "width": "200",
          "size": "75086",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "23038",
          "mp4": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "38874",
          "webp": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "112",
          "width": "200",
          "size": "28535",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "24262",
          "webp": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "56",
          "width": "100",
          "size": "26833",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "9510",
          "mp4": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "13632",
          "webp": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "56",
          "width": "100",
          "size": "2800",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "112",
          "width": "200",
          "size": "7077",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "1608067",
          "mp4": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "281",
          "width": "500",
          "size": "45032",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "268",
          "width": "480",
          "mp4_size": "89959",
          "mp4": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "198",
          "width": "353",
          "mp4_size": "27464",
          "mp4": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "96",
          "width": "171",
          "size": "48962",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "166",
          "width": "296",
          "size": "46188",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "270",
          "width": "480",
          "size": "369834",
          "url": "https://media1.giphy.com/media/12LZQ9YA84nLYQ/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media2.giphy.com/avatars/scottgelber/3opUDVNqoB0y.gif",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/scottgelber/",
        "username": "scottgelber",
        "display_name": "Scott Gelber",
        "description": "",
        "instagram_url": "https://instagram.com/scott_gelber",
        "website_url": "http://scottgelber.com",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPTEyTFpROVlBODRuTFlRJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTEyTFpROVlBODRuTFlRJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTEyTFpROVlBODRuTFlRJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPTEyTFpROVlBODRuTFlRJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "BHv2DEk0iDiKhOJOUL",
      "url": "https://giphy.com/gifs/abstract-daily-render-BHv2DEk0iDiKhOJOUL",
      "slug": "abstract-daily-render-BHv2DEk0iDiKhOJOUL",
      "bitly_gif_url": "https://gph.is/2qshPvR",
      "bitly_url": "https://gph.is/2qshPvR",
      "embed_url": "https://giphy.com/embed/BHv2DEk0iDiKhOJOUL",
      "username": "xponentialdesign",
      "source": "http://bit.ly/2w0hEL3",
      "title": "Render Black And White GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "bit.ly",
      "source_post_url": "http://bit.ly/2w0hEL3",
      "is_sticker": 0,
      "import_datetime": "2018-04-13 00:16:05",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "540",
          "width": "540",
          "size": "6244996",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "679382",
          "mp4": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1081636",
          "webp": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "60",
          "hash": "a39f40e47a4c9a439f9eedddd3555631"
        },
        "downsized": {
          "height": "270",
          "width": "270",
          "size": "1439200",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "540",
          "width": "540",
          "size": "6244996",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "540",
          "width": "540",
          "size": "4831213",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "260",
          "width": "260",
          "mp4_size": "180657",
          "mp4": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "270",
          "width": "270",
          "size": "31886",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "972123",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "213222",
          "mp4": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "276502",
          "webp": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "100730",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "66438",
          "webp": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "315312",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "78884",
          "mp4": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "113460",
          "webp": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "6214",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "18563",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "972123",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "213222",
          "mp4": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "276502",
          "webp": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "100730",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "66438",
          "webp": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "315312",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "48076",
          "mp4": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "113460",
          "webp": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "6214",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "18563",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "3639631",
          "mp4": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "540",
          "width": "540",
          "size": "110373",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "679382",
          "mp4": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "216",
          "width": "216",
          "mp4_size": "42458",
          "mp4": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "66",
          "width": "66",
          "size": "49982",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "140",
          "width": "140",
          "size": "49724",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "6244996",
          "url": "https://media0.giphy.com/media/BHv2DEk0iDiKhOJOUL/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "I make gifs, loops, tutorials stuff\r\n\r\nSubscribe to Xponentialdesign  Youtube Channel : \r\n\r\nhttps://bit.ly/3sud0j1\r\n\r\nSupport me on Patreon: \r\n\r\nhttp://bit.ly/2wkCVhU",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPUJIdjJERWswaURpS2hPSk9VTCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPUJIdjJERWswaURpS2hPSk9VTCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPUJIdjJERWswaURpS2hPSk9VTCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPUJIdjJERWswaURpS2hPSk9VTCZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "l0HlGdXFWYbKv5rby",
      "url": "https://giphy.com/gifs/love-animation-design-l0HlGdXFWYbKv5rby",
      "slug": "love-animation-design-l0HlGdXFWYbKv5rby",
      "bitly_gif_url": "http://gph.is/2fVERF2",
      "bitly_url": "http://gph.is/2fVERF2",
      "embed_url": "https://giphy.com/embed/l0HlGdXFWYbKv5rby",
      "username": "Trippyogi",
      "source": "https://trippyogi.com/",
      "title": "I Love You Hearts GIF by Trippyogi",
      "rating": "g",
      "content_url": "https://trippyogi.com/",
      "source_tld": "trippyogi.com",
      "source_post_url": "https://trippyogi.com/",
      "is_sticker": 0,
      "import_datetime": "2016-11-15 15:44:21",
      "trending_datetime": "2016-11-15 17:30:01",
      "images": {
        "original": {
          "height": "500",
          "width": "500",
          "size": "1985721",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "857911",
          "mp4": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1153042",
          "webp": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "36",
          "hash": "a66e77020a4f7be66f532f09d50dbe71"
        },
        "downsized": {
          "height": "500",
          "width": "500",
          "size": "1985721",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "500",
          "width": "500",
          "size": "1985721",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "500",
          "width": "500",
          "size": "1985721",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "214",
          "width": "214",
          "mp4_size": "124565",
          "mp4": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "500",
          "width": "500",
          "size": "1985721",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "476342",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "193248",
          "mp4": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "167466",
          "webp": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "83068",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "48098",
          "webp": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "165621",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "80081",
          "mp4": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "73584",
          "webp": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "5287",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "16356",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "476342",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "193248",
          "mp4": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "167466",
          "webp": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "83068",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "48098",
          "webp": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "165621",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "48942",
          "mp4": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "73584",
          "webp": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "5287",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "16356",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "6872868",
          "mp4": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "500",
          "width": "500",
          "size": "55445",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "857911",
          "mp4": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "150",
          "width": "150",
          "mp4_size": "43474",
          "mp4": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "112",
          "width": "112",
          "size": "49286",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "100",
          "width": "100",
          "size": "32584",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "1985721",
          "url": "https://media2.giphy.com/media/l0HlGdXFWYbKv5rby/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media2.giphy.com/avatars/jmckeehen/RkN6QlwOK3M5.jpg",
        "banner_image": "https://media2.giphy.com/headers/jmckeehen/s2wy7iphPP98.gif",
        "banner_url": "https://media2.giphy.com/headers/jmckeehen/s2wy7iphPP98.gif",
        "profile_url": "https://giphy.com/Trippyogi/",
        "username": "Trippyogi",
        "display_name": "Trippyogi",
        "description": "With a cornucopia of colors, Trippyogi's rainbow assault on the retina aims to expand the human consciousness and provoke the primal.",
        "instagram_url": "https://instagram.com/trippyogi",
        "website_url": "https://trippyogi.com/",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPWwwSGxHZFhGV1liS3Y1cmJ5JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwwSGxHZFhGV1liS3Y1cmJ5JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwwSGxHZFhGV1liS3Y1cmJ5JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwwSGxHZFhGV1liS3Y1cmJ5JmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "l3mZnuz4coJp8EBBm",
      "url": "https://giphy.com/gifs/animation-animated-tech-l3mZnuz4coJp8EBBm",
      "slug": "animation-animated-tech-l3mZnuz4coJp8EBBm",
      "bitly_gif_url": "http://gph.is/2CWmpa2",
      "bitly_url": "http://gph.is/2CWmpa2",
      "embed_url": "https://giphy.com/embed/l3mZnuz4coJp8EBBm",
      "username": "butler",
      "source": "https://mograph.video/2KMHWIj",
      "title": "animation tech GIF by Matthew Butler",
      "rating": "g",
      "content_url": "",
      "source_tld": "mograph.video",
      "source_post_url": "https://mograph.video/2KMHWIj",
      "is_sticker": 0,
      "import_datetime": "2017-12-18 19:14:33",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "281",
          "width": "500",
          "size": "3007826",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "739528",
          "mp4": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "2211034",
          "webp": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "90",
          "hash": "cb02db472a2ce5256af724fb906dde9c"
        },
        "downsized": {
          "height": "281",
          "width": "500",
          "size": "1379476",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "281",
          "width": "500",
          "size": "3007826",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "281",
          "width": "500",
          "size": "3007826",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "132",
          "width": "235",
          "mp4_size": "102263",
          "mp4": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "281",
          "width": "500",
          "size": "40078",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "356",
          "size": "2750732",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "393829",
          "mp4": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "1246874",
          "webp": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "356",
          "size": "224910",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "142474",
          "webp": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "178",
          "size": "805247",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "120525",
          "mp4": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "388016",
          "webp": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "178",
          "size": "14628",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "356",
          "size": "41900",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "112",
          "width": "200",
          "size": "863812",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "135715",
          "mp4": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "476118",
          "webp": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "112",
          "width": "200",
          "size": "72944",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "53874",
          "webp": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "56",
          "width": "100",
          "size": "291610",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "41913",
          "mp4": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "126770",
          "webp": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "56",
          "width": "100",
          "size": "4474",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "112",
          "width": "200",
          "size": "18821",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "2451985",
          "mp4": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "281",
          "width": "500",
          "size": "76360",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "268",
          "width": "480",
          "mp4_size": "739528",
          "mp4": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "134",
          "width": "239",
          "mp4_size": "35945",
          "mp4": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "76",
          "width": "135",
          "size": "49869",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "64",
          "width": "114",
          "size": "30872",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "270",
          "width": "480",
          "size": "3007826",
          "url": "https://media4.giphy.com/media/l3mZnuz4coJp8EBBm/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media1.giphy.com/avatars/butler/OFHBHjjAjrAY.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/butler/",
        "username": "butler",
        "display_name": "Matthew Butler",
        "description": "Hi there, Matthew Butler is a freelance motion graphics designer specializing in After Effects & Cinema 4D since 2007.  He is currently located in Chicago and usually available to take on any freelance work you have.  Matthew considers himself to be one of the fastest & most efficient After Effects users in the Midwest.",
        "instagram_url": "https://instagram.com/butlerm",
        "website_url": "http://butlerm.com/",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPWwzbVpudXo0Y29KcDhFQkJtJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwzbVpudXo0Y29KcDhFQkJtJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwzbVpudXo0Y29KcDhFQkJtJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPWwzbVpudXo0Y29KcDhFQkJtJmV2ZW50X3R5cGU9R0lGX1NFQVJDSCZjaWQ9NWNlODhkMzZ6eXN1OHZzdXZ3azRzZmFmdDhnZTVlbXgzZDdwMWcxc3JuajlpaHYxJmN0PWc&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "vxdDyZL7iL7aGa9Z0u",
      "url": "https://giphy.com/gifs/form-aftereffects-trapcode-vxdDyZL7iL7aGa9Z0u",
      "slug": "form-aftereffects-trapcode-vxdDyZL7iL7aGa9Z0u",
      "bitly_gif_url": "https://gph.is/2WRKaKk",
      "bitly_url": "https://gph.is/2WRKaKk",
      "embed_url": "https://giphy.com/embed/vxdDyZL7iL7aGa9Z0u",
      "username": "xponentialdesign",
      "source": "http://bit.ly/2DjdY9V",
      "title": "geometry render GIF by xponentialdesign",
      "rating": "g",
      "content_url": "",
      "source_tld": "bit.ly",
      "source_post_url": "http://bit.ly/2DjdY9V",
      "is_sticker": 0,
      "import_datetime": "2019-02-08 13:17:51",
      "trending_datetime": "0000-00-00 00:00:00",
      "images": {
        "original": {
          "height": "540",
          "width": "540",
          "size": "9697261",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "3860456",
          "mp4": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "10275246",
          "webp": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "90",
          "hash": "3d8c1d052feaced46e0b4ace38aa090a"
        },
        "downsized": {
          "height": "216",
          "width": "216",
          "size": "1284616",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy-downsized.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized.gif&ct=g"
        },
        "downsized_large": {
          "height": "345",
          "width": "345",
          "size": "6785528",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy-downsized-large.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-large.gif&ct=g"
        },
        "downsized_medium": {
          "height": "267",
          "width": "267",
          "size": "3826527",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy-downsized-medium.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-medium.gif&ct=g"
        },
        "downsized_small": {
          "height": "150",
          "width": "150",
          "mp4_size": "173590",
          "mp4": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "216",
          "width": "216",
          "size": "32938",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy-downsized_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "200",
          "size": "2337734",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "830736",
          "mp4": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "1688418",
          "webp": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "200",
          "size": "168523",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "114366",
          "webp": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "100",
          "size": "499098",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "85966",
          "mp4": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "374688",
          "webp": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "100",
          "size": "6708",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "200",
          "size": "30163",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "200",
          "width": "200",
          "size": "2337734",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "830736",
          "mp4": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "1688418",
          "webp": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "200",
          "width": "200",
          "size": "168523",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "114366",
          "webp": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "100",
          "width": "100",
          "size": "499098",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "47880",
          "mp4": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "374688",
          "webp": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "100",
          "width": "100",
          "size": "6708",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "200",
          "width": "200",
          "size": "30163",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "7052590",
          "mp4": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "540",
          "width": "540",
          "size": "108106",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "480",
          "width": "480",
          "mp4_size": "3860456",
          "mp4": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "150",
          "width": "150",
          "mp4_size": "37110",
          "mp4": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "73",
          "width": "73",
          "size": "48464",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "68",
          "width": "68",
          "size": "24546",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "480",
          "width": "480",
          "size": "9697261",
          "url": "https://media0.giphy.com/media/vxdDyZL7iL7aGa9Z0u/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "user": {
        "avatar_url": "https://media3.giphy.com/avatars/xponentialdesign/vZNZ5Pjho6XN.jpg",
        "banner_image": "",
        "banner_url": "",
        "profile_url": "https://giphy.com/xponentialdesign/",
        "username": "xponentialdesign",
        "display_name": "xponentialdesign",
        "description": "I make gifs, loops, tutorials stuff\r\n\r\nSubscribe to Xponentialdesign  Youtube Channel : \r\n\r\nhttps://bit.ly/3sud0j1\r\n\r\nSupport me on Patreon: \r\n\r\nhttp://bit.ly/2wkCVhU",
        "instagram_url": "https://instagram.com/xponentialdesign",
        "website_url": "https://www.hicetnunc.art/Xponentialdesign",
        "is_verified": true
      },
      "analytics_response_payload": "e=Z2lmX2lkPXZ4ZER5Wkw3aUw3YUdhOVowdSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXZ4ZER5Wkw3aUw3YUdhOVowdSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXZ4ZER5Wkw3aUw3YUdhOVowdSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPXZ4ZER5Wkw3aUw3YUdhOVowdSZldmVudF90eXBlPUdJRl9TRUFSQ0gmY2lkPTVjZTg4ZDM2enlzdTh2c3V2d2s0c2ZhZnQ4Z2U1ZW14M2Q3cDFnMXNybmo5aWh2MSZjdD1n&action_type=SENT"
        }
      }
    },
    {
      "type": "gif",
      "id": "Oy4nobvUxIonu",
      "url": "https://giphy.com/gifs/80s-vhs-vaporwave-Oy4nobvUxIonu",
      "slug": "80s-vhs-vaporwave-Oy4nobvUxIonu",
      "bitly_gif_url": "http://gph.is/1J1ihUB",
      "bitly_url": "http://gph.is/1J1ihUB",
      "embed_url": "https://giphy.com/embed/Oy4nobvUxIonu",
      "username": "",
      "source": "http://sidechains.tumblr.com/post/118586781382",
      "title": "sad 80s GIF",
      "rating": "g",
      "content_url": "",
      "source_tld": "sidechains.tumblr.com",
      "source_post_url": "http://sidechains.tumblr.com/post/118586781382",
      "is_sticker": 0,
      "import_datetime": "2015-05-10 06:01:21",
      "trending_datetime": "1970-01-01 00:00:00",
      "images": {
        "original": {
          "height": "281",
          "width": "500",
          "size": "1985513",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g",
          "mp4_size": "1437069",
          "mp4": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g",
          "webp_size": "1212370",
          "webp": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.webp&ct=g",
          "frames": "69",
          "hash": "bd10235d77914c85984df6ff1f0d2183"
        },
        "downsized": {
          "height": "281",
          "width": "500",
          "size": "1985513",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_large": {
          "height": "281",
          "width": "500",
          "size": "1985513",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_medium": {
          "height": "281",
          "width": "500",
          "size": "1985513",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.gif&ct=g"
        },
        "downsized_small": {
          "height": "112",
          "width": "200",
          "mp4_size": "135117",
          "mp4": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy-downsized-small.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-downsized-small.mp4&ct=g"
        },
        "downsized_still": {
          "height": "281",
          "width": "500",
          "size": "1985513",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "fixed_height": {
          "height": "200",
          "width": "356",
          "size": "1956098",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/200.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.gif&ct=g",
          "mp4_size": "599006",
          "mp4": "https://media0.giphy.com/media/Oy4nobvUxIonu/200.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.mp4&ct=g",
          "webp_size": "534370",
          "webp": "https://media0.giphy.com/media/Oy4nobvUxIonu/200.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200.webp&ct=g"
        },
        "fixed_height_downsampled": {
          "height": "200",
          "width": "356",
          "size": "184633",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/200_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.gif&ct=g",
          "webp_size": "104022",
          "webp": "https://media0.giphy.com/media/Oy4nobvUxIonu/200_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_d.webp&ct=g"
        },
        "fixed_height_small": {
          "height": "100",
          "width": "178",
          "size": "600167",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/100.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.gif&ct=g",
          "mp4_size": "191415",
          "mp4": "https://media0.giphy.com/media/Oy4nobvUxIonu/100.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.mp4&ct=g",
          "webp_size": "173024",
          "webp": "https://media0.giphy.com/media/Oy4nobvUxIonu/100.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100.webp&ct=g"
        },
        "fixed_height_small_still": {
          "height": "100",
          "width": "178",
          "size": "6598",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/100_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100_s.gif&ct=g"
        },
        "fixed_height_still": {
          "height": "200",
          "width": "356",
          "size": "24125",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/200_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200_s.gif&ct=g"
        },
        "fixed_width": {
          "height": "112",
          "width": "200",
          "size": "769188",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/200w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.gif&ct=g",
          "mp4_size": "219532",
          "mp4": "https://media0.giphy.com/media/Oy4nobvUxIonu/200w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.mp4&ct=g",
          "webp_size": "198380",
          "webp": "https://media0.giphy.com/media/Oy4nobvUxIonu/200w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w.webp&ct=g"
        },
        "fixed_width_downsampled": {
          "height": "112",
          "width": "200",
          "size": "71016",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/200w_d.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.gif&ct=g",
          "webp_size": "38618",
          "webp": "https://media0.giphy.com/media/Oy4nobvUxIonu/200w_d.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_d.webp&ct=g"
        },
        "fixed_width_small": {
          "height": "56",
          "width": "100",
          "size": "206655",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/100w.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.gif&ct=g",
          "mp4_size": "49129",
          "mp4": "https://media0.giphy.com/media/Oy4nobvUxIonu/100w.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.mp4&ct=g",
          "webp_size": "79108",
          "webp": "https://media0.giphy.com/media/Oy4nobvUxIonu/100w.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w.webp&ct=g"
        },
        "fixed_width_small_still": {
          "height": "56",
          "width": "100",
          "size": "2634",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/100w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=100w_s.gif&ct=g"
        },
        "fixed_width_still": {
          "height": "112",
          "width": "200",
          "size": "9098",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/200w_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=200w_s.gif&ct=g"
        },
        "looping": {
          "mp4_size": "5733147",
          "mp4": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy-loop.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-loop.mp4&ct=g"
        },
        "original_still": {
          "height": "281",
          "width": "500",
          "size": "21032",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy_s.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy_s.gif&ct=g"
        },
        "original_mp4": {
          "height": "268",
          "width": "480",
          "mp4_size": "1437069",
          "mp4": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy.mp4&ct=g"
        },
        "preview": {
          "height": "94",
          "width": "167",
          "mp4_size": "49672",
          "mp4": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy-preview.mp4?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.mp4&ct=g"
        },
        "preview_gif": {
          "height": "63",
          "width": "112",
          "size": "47560",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy-preview.gif?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.gif&ct=g"
        },
        "preview_webp": {
          "height": "86",
          "width": "154",
          "size": "33916",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/giphy-preview.webp?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=giphy-preview.webp&ct=g"
        },
        "480w_still": {
          "height": "270",
          "width": "480",
          "size": "1985513",
          "url": "https://media0.giphy.com/media/Oy4nobvUxIonu/480w_s.jpg?cid=5ce88d36zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1&rid=480w_s.jpg&ct=g"
        }
      },
      "analytics_response_payload": "e=Z2lmX2lkPU95NG5vYnZVeElvbnUmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw",
      "analytics": {
        "onload": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU95NG5vYnZVeElvbnUmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SEEN"
        },
        "onclick": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU95NG5vYnZVeElvbnUmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=CLICK"
        },
        "onsent": {
          "url": "https://giphy-analytics.giphy.com/v2/pingback_simple?analytics_response_payload=e%3DZ2lmX2lkPU95NG5vYnZVeElvbnUmZXZlbnRfdHlwZT1HSUZfU0VBUkNIJmNpZD01Y2U4OGQzNnp5c3U4dnN1dndrNHNmYWZ0OGdlNWVteDNkN3AxZzFzcm5qOWlodjEmY3Q9Zw&action_type=SENT"
        }
      }
    }
  ],
  "pagination": {
    "total_count": 1176,
    "count": 50,
    "offset": 0
  },
  "meta": {
    "status": 200,
    "msg": "OK",
    "response_id": "zysu8vsuvwk4sfaft8ge5emx3d7p1g1srnj9ihv1"
  }
}
"""
