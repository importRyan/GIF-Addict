// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Giphy",
    platforms: [.macOS(.v10_15), .iOS(.v13), .watchOS(.v6)],
    products: [.library(name: "Giphy", targets: ["Giphy"]),],
    dependencies: [],
    targets: [
        .target(name: "Giphy", dependencies: []),
        .testTarget(name: "GiphyTests", dependencies: ["Giphy"]),
    ]
)
