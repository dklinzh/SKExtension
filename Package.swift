// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "SpriteSwift",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "SpriteSwift",
            targets: ["SpriteSwift"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SpriteSwift",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "SpriteSwiftTests",
            dependencies: ["SpriteSwift"],
            path: "Tests"
        ),
    ]
)
