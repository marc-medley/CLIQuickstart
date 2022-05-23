// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CLIQuickstartLib",
    defaultLocalization: "en",
    platforms: [
        // specify each minimum deployment requirement, 
        // otherwise the platform default minimum is used.
        // .v10_13 High Sierra .v10_14 Mojave, .v10_15 Catalina, .v11 Big Sur
        // can also be a string like .macOS("11.3") or .macOS("10.10.1")
        .macOS(.v10_15), 
    ],
    products: [
        // Products define the executables and libraries produced by a package, 
        // and make them visible to other packages.
        Product.executable(
            name: "CLIQuickstartTool",
            targets: ["CLIQuickstartTool"]),
        Product.library(
            name: "CLIQuickstartLib",
            type: Product.Library.LibraryType.static,
            targets: ["CLIQuickstartLib"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        // .package( url: " ", .branch("master") ),
        // .package(url: "git@gitlab.com:GROUP/SUBGROUP/REPO.git", .branch("master") ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. 
        // A target can define a module or a test suite.
        // Targets can depend on other targets in this package, 
        // and on products in packages which this package depends on.
        Target.target(
            name: "CLIQuickstartLib",
            dependencies: [],
            resources: [.copy("Resources"), .copy("Resources_A")]
        ),
        Target.executableTarget(
            name: "CLIQuickstartTool",
            dependencies: ["CLIQuickstartLib"],
            resources: [.copy("Resources"),]
        ),
        // Test CLIQuickstartLib directly instead of CLIQuickstartTool main.swift
        Target.testTarget(
            name: "CLIQuickstartLibTests",
            dependencies: ["CLIQuickstartLib"],
            resources: [.copy("Resources"),]
        ),
    ],
    swiftLanguageVersions: [.v5],
    cLanguageStandard: .c11, // gnu11, iso9899_2011
    cxxLanguageStandard: .cxx14 // cxx11, gnucxx11, cxx14, gnucxx14, cxx1z, gnucxx1z
)
