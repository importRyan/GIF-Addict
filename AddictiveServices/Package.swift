// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "AddictiveServices",
    platforms: [.macOS(.v10_15), .iOS(.v13), .watchOS(.v6)],
    products: [.library(name: "AddictiveServices", targets: ["AddictiveServices"]),],
    dependencies: [
        .package(name: "Giphy", path: "../Giphy"),
        .package(name: "Addiction", path: "../Addiction"),
        .package(name: "AddictiveCoreData", path: "../AddictiveCoreData"),
    ],
    targets: [
        .target(
            name: "AddictiveServices",
            dependencies: [
                .product(name: "Giphy", package: "Giphy", condition: .none),
                .product(name: "Addiction", package: "Addiction", condition: .none),
                .product(name: "AddictiveCoreData", package: "AddictiveCoreData", condition: .none)
            ]),
        .testTarget(name: "AddictiveServicesTests", dependencies: ["AddictiveServices"]),
    ]
)
