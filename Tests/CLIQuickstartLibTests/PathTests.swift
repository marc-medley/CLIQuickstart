//
//  PathTests.swift
//  

import XCTest

class PathTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testXCTestCasePaths() throws {
        print("""
        
        ###########################
        ## testXCTestCasePaths() ##
        ###########################
        """)
#if os(macOS)
        print("Built for macOS")
        let version = ProcessInfo.processInfo.operatingSystemVersion
        print("Operating System Version: \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)")
        print("Operating System Version String: \(ProcessInfo().operatingSystemVersionString)")
#elseif os(Linux)
        print("Built for Linux")
        let version = ProcessInfo.processInfo.operatingSystemVersion
        print("Operating System Version: \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)")
        print("Operating System Version String: \(ProcessInfo().operatingSystemVersionString)")
#elseif os(Windows)
        print("Built for Windows")
        let version = ProcessInfo.processInfo.operatingSystemVersion
        print("Operating System Version: \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)")
        print("Operating System Version String: \(ProcessInfo().operatingSystemVersionString)")
#endif

        // --- FileManager Path ---
        let fm = FileManager.default
        print("FileManager.default.CurrentDirectoryPath = \(fm.currentDirectoryPath)")
        
        // --- Bundle Module Paths ---        
        let testBundleModule = Bundle.module
        print("  testBundleModule.bundlePath = \(testBundleModule.bundlePath)")
        print("testBundleModule.resourcePath = \(testBundleModule.resourcePath ?? "NIL")")
        
    }

}
