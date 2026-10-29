// swift-tools-version: 6.1
import PackageDescription

// Rendered by the mvsdk-ios release pipeline (fastlane publish_spm) into the
// MediavineSDK-SPM repository. Do not edit Package.swift there — change THIS
// template (and the dependency lists below) in mvsdk-ios, and the next tagged
// release deploys it. 2.1.0 and aca90d85d51e4533ffa20305b7af77f266afd594a6430296198acff8c45290e5 are stamped at publish time.

fileprivate let VERSION = "2.1.0"
fileprivate let CHECKSUM = "aca90d85d51e4533ffa20305b7af77f266afd594a6430296198acff8c45290e5"

let package = Package(
    name: "Mediavine",
    platforms: [
        // Must track `spec.platform` in Mediavine.podspec and the framework's
        // IPHONEOS_DEPLOYMENT_TARGET. SPM validates a consumer's deployment target
        // against THIS value, not against the binary inside, so a stale floor here
        // lets an app below the real minimum resolve the package cleanly and then
        // fail at build/link time with an unrelated-looking error.
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Mediavine",
            targets: ["MediavineWrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/iubenda/cm-sdk-xcframework-v3.git", .upToNextMajor(from: "3.8.0")),
        // Google Mobile Ads (with UMP), OptableSDK and the UID2 stack ship INSIDE the
        // Mediavine binary (statically absorbed: GoogleMobileAds imported internal,
        // OptableSDK and UID2 imported @_implementationOnly, UMP and UID2GMAPlugin
        // linked only; none of them in the public interface). GMA's and UMP's privacy
        // manifests ship inside Mediavine.framework.
        // Do NOT add their packages here. A second copy links into the app executable
        // alongside Mediavine's: the runtime warns "Class … is implemented in both" on
        // every launch, two versions of the same classes coexist, and for UID2 the
        // seeded UID2Manager singleton splits from GMA's collector.
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
                .product(name: "cm-sdk-ios-v3", package: "cm-sdk-xcframework-v3")
            ],
            path: "Sources/Mediavine"
        )
    ]
)
