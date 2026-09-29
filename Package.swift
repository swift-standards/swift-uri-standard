// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-uri-standard",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
    ],
    products: [
        .library(
            name: "URI Standard",
            targets: ["URI Standard"]
        ),
        .library(
            name: "URI Standard Library Integration",
            targets: ["URI Standard Library Integration"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-byte.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986-coder.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3987.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "URI Standard",
            dependencies: [
                .product(name: "Byte", package: "swift-byte"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC 3986 Coder", package: "swift-rfc-3986-coder"),
                .product(name: "RFC 3987", package: "swift-rfc-3987"),
            ]
        ),
        .target(
            name: "URI Standard Library Integration",
            dependencies: [
                .target(name: "URI Standard"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
            ]
        ),
        .testTarget(
            name: "URI Standard Tests",
            dependencies: [
                .target(name: "URI Standard"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "RFC 3987", package: "swift-rfc-3987"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
