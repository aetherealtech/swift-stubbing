// swift-tools-version: 6.0

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "Stubbing",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "Stubbing",
            targets: ["Stubbing"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", from: .init(510, 0, 3)),
        .package(url: "https://github.com/aetherealtech/swift-assertions", branch: "master"),
    ],
    targets: [
        .target(
            name: "Stubbing",
            dependencies: [
                "StubbingMacros",
            ]
        ),
        .macro(
            name: "StubbingMacros",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .testTarget(
            name: "StubbingTests",
            dependencies: [
                "Stubbing",
                .product(name: "Assertions", package: "swift-assertions"),
            ]
        ),
        .testTarget(
            name: "StubbingMacrosTests",
            dependencies: [
                "StubbingMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
