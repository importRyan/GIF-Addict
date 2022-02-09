// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SharedUI",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [.library(name: "SharedUI", targets: ["SharedUI"]),],
    dependencies: [],
    targets: [
        .target(
            name: "SharedUI",
            resources: [.process("Resources", localization: nil)]
        ),
        .testTarget(name: "SharedUITests", dependencies: ["SharedUI"]),
    ]
)
