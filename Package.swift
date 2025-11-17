// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "URIType",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(
            name: "URIType",
            targets: ["URIType"]
        ),
    ],
    dependencies: [
        .package(path: "../swift-rfc-3986"),
        .package(path: "../swift-rfc-4648"),
    ],
    targets: [
        .target(
            name: "URIType",
            dependencies: [
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC_4648", package: "swift-rfc-4648")
            ]
        ),
        .testTarget(
            name: "URITypeTests",
            dependencies: ["URIType"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
