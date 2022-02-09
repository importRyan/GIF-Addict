// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Addiction",
    platforms: [.macOS(.v10_15), .iOS(.v13), .watchOS(.v6)],
    products: [.library(name: "Addiction", targets: ["Addiction"]),],
    dependencies: [],
    targets: [
        .target(name: "Addiction", dependencies: []),
        .testTarget(name: "AddictionTests", dependencies: ["Addiction"]),
    ]
)
