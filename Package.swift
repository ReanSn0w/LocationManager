// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocationManager",
	platforms: [.iOS(.v13)],
    products: [
        .library(name: "LocationManager",targets: ["LocationManager"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "LocationManager",dependencies: []),
    ]
)
