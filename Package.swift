// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xliff2strings",
//    platforms: [.macOS(.v10_11)],
    products: [
//        .library(name: "xliff2strings", targets: ["xliff2strings"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/MaxDesiatov/XMLCoder.git", from: "0.5.1"),
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", from: "5.3.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "xliff2strings",
            dependencies: ["XMLCoder", "SwiftCLI"]),
    ],
    swiftLanguageVersions: [.v4_2]
)
