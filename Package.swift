// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-study",
    products: [
        // .executable(name: "nio-file", targets: ["nio-file"]),        
        .executable(name: "pop", targets: ["pop"]),
        .executable(name: "pop1", targets: ["pop1"]),
        .executable(name: "pop2", targets: ["pop2"]),
        .executable(name: "pop3", targets: ["pop3"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "1.8.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        // .target(
        //     name: "nio-file",
        //     dependencies: ["NIO", "NIOHTTP1"]),
        .target(
            name: "pop",
            dependencies: []),
        .target(
            name: "pop1",
            dependencies: []),
        .target(
            name: "pop2",
            dependencies: []),
        .target(
            name: "pop3",
            dependencies: []),
    ]
)
