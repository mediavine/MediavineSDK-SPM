// swift-tools-version: 6.1
import PackageDescription

// Rendered by the mvsdk-ios release pipeline (fastlane publish_spm) into the
// MediavineSDK-SPM repository. Do not edit Package.swift there — change THIS
// template (and the dependency lists below) in mvsdk-ios, and the next tagged
// release deploys it. 1.4.2 and c06075ddcf0962403133feaf3f912abc08a931cc5dcd9d7cac0b3bd54a532ad6 are stamped at publish time.

fileprivate let VERSION = "1.4.2"
fileprivate let CHECKSUM = "c06075ddcf0962403133feaf3f912abc08a931cc5dcd9d7cac0b3bd54a532ad6"

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
        // The UID2 stack ships INSIDE the Mediavine binary (statically absorbed, like
        // OptableSDK). Do NOT add the uid2 packages here — a second copy duplicates
        // UID2Manager and splits the seeded singleton from GMA's collector.
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
