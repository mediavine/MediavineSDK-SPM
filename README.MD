# MediavineSDK-SPM

Swift Package Manager distribution manifest for the Mediavine iOS SDK.

This repository exists solely to satisfy SPM's requirement for a Git-backed package source. It contains a `Package.swift` manifest that references the SDK's compiled binary artifacts (XCFrameworks) hosted on S3 — no source code lives here.

## Usage

Add the package to your Xcode project or `Package.swift`:

```swift
.package(url: "https://github.com/mediavine/MediavineSDK-SPM.git", from: "1.0.0")
```

Resolve a specific version by tag.

## Maintenance

`Package.swift` and version tags in this repository are managed automatically by the Mediavine iOS SDK build pipeline. Do not push to `main` directly.
