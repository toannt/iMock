// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iMock",
    products: [
        .library(
            name: "iMock",
            targets: ["iMock"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "iMock",
            dependencies: []),
        .testTarget(
            name: "iMockTests",
            dependencies: ["iMock"]),
    ]
)
