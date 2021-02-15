// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Beacon",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .executable(name: "beacon", targets: ["Beacon"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.1"),
    ],
    targets: [
        .target(name: "Beacon", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
        ]),
    ]
)
