// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ScrollViewController",
    platforms: [
        .iOS("10.0")
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
            path: "Sources",
            exclude: ["Info.plist"]
        ),
    ]
)
