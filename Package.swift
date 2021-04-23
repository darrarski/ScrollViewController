// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ScrollViewController",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ScrollViewController",
            targets: ["ScrollViewController"]
        )
    ],
    targets: [
        .target(
            name: "ScrollViewController",
            path: "Sources"
        )
    ]
)
