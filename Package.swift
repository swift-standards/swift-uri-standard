// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-uri-standard",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11)
    ],
    products: [
        .library(
            name: "URI Standard",
            targets: ["URI Standard"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-rfc-3986", from: "0.1.0"),
        .package(url: "https://github.com/swift-standards/swift-rfc-4648", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "URI Standard",
            dependencies: [
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC 4648", package: "swift-rfc-4648")
            ]
        ),
        .testTarget(
            name: "URI Standard Tests",
            dependencies: ["URI Standard"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
