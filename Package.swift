// swift-tools-version: 6.1
import PackageDescription

fileprivate let VERSION = "0.1.0"
fileprivate let CHECKSUM = "0cf9bb1bdace51f1dbca4736997b5dbe6b01bb96bfb44009fb68b0c147b68631"

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
