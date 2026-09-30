// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-sockets-ip-address",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Sockets IP Address", targets: ["Sockets IP Address"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-compositions/swift-sockets.git", branch: "main"),
        .package(url: "https://github.com/swift-compositions/swift-ip-address.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-ascii.git", branch: "main", traits: ["Coder", "Parser", "Serializer"]),
        .package(url: "https://github.com/swift-atoms/swift-coder.git", branch: "main", traits: ["Carrier", "Map"]),
        .package(url: "https://github.com/swift-atoms/swift-ratio.git", branch: "main", traits: ["Bit", "Ordinal", "Difference"]),
        .package(url: "https://github.com/swift-atoms/swift-span.git", branch: "main", traits: ["Iterator"]),
        .package(url: "https://github.com/swift-atoms/swift-finite.git", branch: "main", traits: ["Tagged"]),
        .package(url: "https://github.com/swift-atoms/swift-memory.git", branch: "main", traits: ["Lock", "Map", "Shared", "Cursor"]),
    ],
    targets: [
        .target(
            name: "Sockets IP Address",
            dependencies: [
                .product(name: "Sockets", package: "swift-sockets"),
                .product(name: "IP Address", package: "swift-ip-address"),
            ]
        ),
        .testTarget(
            name: "Sockets IP Address Tests",
            dependencies: ["Sockets IP Address"]
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
    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem
}
