// swift-tools-version: 6.1
import PackageDescription

fileprivate let VERSION = "1.4.0"
fileprivate let CHECKSUM = "27c14eb2edc0fdb65b8f39c1ab75f62cc658ae0d858c663f72616727bc25c26c"

let package = Package(
    name: "Mediavine",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Mediavine",
            targets: ["MediavineWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Optable/optable-ios-sdk.git", .upToNextMajor(from: "1.0.1")),
        .package(url: "https://github.com/iubenda/cm-sdk-xcframework-v3.git", .upToNextMajor(from: "3.8.0")),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", .upToNextMajor(from: "13.0.0")),
    ],
    targets: [
        .binaryTarget(
            name: "Mediavine_Binary",
            url: "https://mv-mobile-sdk-config-production.s3.amazonaws.com/ios/sdk/\(VERSION)/Mediavine.xcframework.zip",
            checksum: "\(CHECKSUM)"
        ),
        .target(
            name: "MediavineWrapper",
            dependencies: [
                .byName(name: "Mediavine_Binary"),
                .product(name: "OptableSDK", package: "optable-ios-sdk"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
                .product(name: "cm-sdk-ios-v3", package: "cm-sdk-xcframework-v3")
            ],
            path: "Sources/Mediavine"
        )
    ]
)
