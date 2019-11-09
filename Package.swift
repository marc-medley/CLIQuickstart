// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CLIQuickstart",
    platforms: [
        // specify each minimum deployment requirement, 
        // otherwise the platform default minimum is used.
        .macOS(.v10_13), // .v10_13 High Sierra .v10_14 Mojave, .v10_15 Catalina 
    ],
    // products: [
    //     // Products define the executables and libraries produced by a package, 
    //     // and make them visible to other packages.
    //     .library(
    //         name: "CLIQuickstartCore",
    //         type: .static,
    //         targets: ["CLIQuickstartCore"]),
    // ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        // .package( url: " ", .branch("master") )
    ],
    targets: [
        // Targets are the basic building blocks of a package. 
        // A target can define a module or a test suite.
        // Targets can depend on other targets in this package, 
        // and on products in packages which this package depends on.
        .target(
            name: "CLIQuickstart",
            dependencies: ["CLIQuickstartCore"]),
        .target(
            name: "CLIQuickstartCore",
            dependencies: []),
        // Test CLIQuickstartCore directly instead of CLIQuickstart main.swift
        .testTarget(
            name: "CLIQuickstartTests",
            dependencies: ["CLIQuickstartCore"]),
    ],
    swiftLanguageVersions: [.v5]
)
