// swift-tools-version: 5.9

import PackageDescription

let version = "9.0.0"
let releaseURL = "https://github.com/HapticTide/MLKitEntityExtraction-spm/releases/download/\(version)"

// Shared xcframeworks from d-date/google-mlkit-swiftpm (same MLKit 9.0.0 release)
let ddateURL = "https://github.com/d-date/google-mlkit-swiftpm/releases/download/\(version)"

let package = Package(
    name: "MLKitEntityExtraction",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "MLKitEntityExtraction", targets: ["MLKitEntityExtractionWrapper"]),
    ],
    dependencies: [
        // Source dependencies (same as d-date/google-mlkit-swiftpm)
        .package(url: "https://github.com/google/promises.git", exact: "2.4.0"),
        .package(url: "https://github.com/google/GoogleDataTransport.git", exact: "10.1.0"),
        .package(url: "https://github.com/google/GoogleUtilities.git", exact: "8.1.0"),
        .package(url: "https://github.com/google/gtm-session-fetcher.git", exact: "3.5.0"),
        .package(url: "https://github.com/nicklockwood/nanopb.git", exact: "2.30910.0"),
    ],
    targets: [
        // Umbrella target
        .target(
            name: "MLKitEntityExtractionWrapper",
            dependencies: [
                "MLKitEntityExtraction_Binary",
                "MLKitNaturalLanguage_Binary",
                "MLKitCommon_Binary",
                "GoogleToolboxForMac_Binary",
                .product(name: "FBLPromises", package: "promises"),
                .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
                .product(name: "GULLogger", package: "GoogleUtilities"),
                .product(name: "GULUserDefaults", package: "GoogleUtilities"),
                .product(name: "GULNSData", package: "GoogleUtilities"),
                .product(name: "GULEnvironment", package: "GoogleUtilities"),
                .product(name: "GULNetwork", package: "GoogleUtilities"),
                .product(name: "GULReachability", package: "GoogleUtilities"),
                .product(name: "GTMSessionFetcher", package: "gtm-session-fetcher"),
                .product(name: "nanopb", package: "nanopb"),
            ],
            path: "Sources"
        ),

        // Entity Extraction (our build from CocoaPods 1.0.0-beta15)
        .binaryTarget(
            name: "MLKitEntityExtraction_Binary",
            url: "\(releaseURL)/MLKitEntityExtraction.xcframework.zip",
            checksum: "d33f8b4a20bedd2c33f0b4f4220c1cf44b4d30b0a114583501ee2225378d0062"
        ),

        // Shared xcframeworks (from d-date release 9.0.0)
        .binaryTarget(
            name: "MLKitNaturalLanguage_Binary",
            url: "\(ddateURL)/MLKitNaturalLanguage.xcframework.zip",
            checksum: "6249e465b239a991865aab785510e3683fb0b65954a432c7733149b03e03ba84"
        ),
        .binaryTarget(
            name: "MLKitCommon_Binary",
            url: "\(ddateURL)/MLKitCommon.xcframework.zip",
            checksum: "180770a261c534043de3b9d81ff2b3ff0b867fedb4e06587b2715deda1b0bd7c"
        ),
        .binaryTarget(
            name: "GoogleToolboxForMac_Binary",
            url: "\(ddateURL)/GoogleToolboxForMac.xcframework.zip",
            checksum: "e73f79a048c95236ebc04829cc3b4fb0b0e1902d65650fc3cb187c233dbff5a1"
        ),
    ]
)
