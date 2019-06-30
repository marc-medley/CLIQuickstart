import Foundation
import XCTest

// testable attribute allows access to `internal` scope items for internal framework testing.
@testable 
import CLIQuickstartCore

final class CLIQuickstartTests: XCTestCase {
    func testExecutable() throws {
        print("\n######################")
        print("## testExecutable() ##")
        print("######################")

        // Some APIs used require macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        // build products directory
        let executableUrl = productsDirectory.appendingPathComponent("CLIQuickstart")

        // https://developer.apple.com/documentation/foundation/process
        let process = Process()
        process.executableURL = executableUrl
        process.launchPath = executableUrl.path

        let pipeOutput = Pipe()
        process.standardOutput = pipeOutput
        let pipeError = Pipe()
        process.standardError = pipeError
        
        try process.run()

        let dataOutput = pipeOutput.fileHandleForReading.readDataToEndOfFile()
        if let stdOutput = String(data: dataOutput, encoding: .utf8) {
            print("\n## stdOutput\n\(stdOutput)")
            XCTAssert(stdOutput.contains("Hello"))
        }
        else {
            throw CLIQuickstart.Error.failedToDoSomething
        }
        
        let dataError = pipeError.fileHandleForReading.readDataToEndOfFile()
        if let stdError = String(data: dataError, encoding: String.Encoding.utf8) {
            print("\n## stdError\n\(stdError)")
        }
        else {
            throw CLIQuickstart.Error.failedToDoSomething
        }

        process.waitUntilExit()
        let status = process.terminationStatus
        print("## TERMINATION STATUS: \(status)")
    }
    
    func testFramework() throws {
        print("\n#####################")
        print("## testFramework() ##")
        print("#####################")
        
        // Create an instance of the command line tool framework
        let arguments = ["--param=value", "Hello.swift"]
        let tool = CLIQuickstart(arguments: arguments)

        // Run the tool and assert that the file was created
        do {
            try tool.run()
            
            // Check some outcome
            //XCTAssertNotNil(try? testFolder.file(named: "Hello.swift"))
        } catch {
            throw CLIQuickstart.Error.failedToDoSomething
        }
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testExample", testExecutable),
        ("testExample", testFramework),
    ]
}
