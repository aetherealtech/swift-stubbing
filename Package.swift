// swift-tools-version: 5.10

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
            ],
            swiftSettings: [.concurrencyChecking]
        ),
        .macro(
            name: "StubbingMacros",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ],
            swiftSettings: [.concurrencyChecking]
        ),
        .testTarget(
            name: "StubbingTests",
            dependencies: [
                "Stubbing",
                .product(name: "Assertions", package: "swift-assertions"),
            ],
            swiftSettings: [.concurrencyChecking]
        ),
        .testTarget(
            name: "StubbingMacrosTests",
            dependencies: [
                "StubbingMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ],
            swiftSettings: [.concurrencyChecking]
        ),
    ]
)

extension SwiftSetting {
    enum ConcurrencyChecking: String {
        case complete
        case minimal
        case targeted
    }

    static var concurrencyChecking: Self {
        .concurrencyChecking(.complete)
    }

    static func concurrencyChecking(_ setting: ConcurrencyChecking = .complete) -> Self {
        .unsafeFlags(
            ["-Xfrontend", "-strict-concurrency=\(setting)"]
        )
    }
}
