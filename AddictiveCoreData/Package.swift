// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "AddictiveCoreData",
    platforms: [.macOS(.v10_15), .iOS(.v13), .watchOS(.v6)],
    products: [.library(name: "AddictiveCoreData", targets: ["AddictiveCoreData"]),],
    dependencies: [],
    targets: [
        .target(name: "AddictiveCoreData", dependencies: []),
        .testTarget(name: "AddictiveCoreDataTests", dependencies: ["AddictiveCoreData"]),
    ]
)
