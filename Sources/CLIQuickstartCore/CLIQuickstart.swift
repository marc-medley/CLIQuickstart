//
//  StdioExtensions.swift
//  CLIQuickstart
//
//  Created by marc on 2019.06.29.
//

import Foundation

public final class CLIQuickstart {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) { 
        self.arguments = arguments
    }

    public func run() throws {
        guard arguments.count > 0 else {
            throw Error.missingArgument
        }
        
        print("Hello world")
        debugPrint(1...5)

        // Print Arguments
        print("\narguments = \(arguments)")
        
        // Write to stdio streams.
        print("\n**Print Functions**")
        print("print() to stdout")
        printError("printError() to stderr\n")
        
        // Write to expressly declared output streams
        print("\n**Print Streams**")
        print("print to &standardError stream", to:&standardError)
        print("print to &standardOutput stream", to:&standardOutput)
        
        // Write to expressly declared output streams
        print("\n**Print Objects**")
        let streamErr = StandardErrorStream()
        streamErr.write("write to StandardErrorStream()\n")
        let streamOut = StandardOutputStream()
        streamOut.write("write to StandardOutputStream()\n")
        
        print("\n**The End**\n")
    }
}

public extension CLIQuickstart {
    enum Error: Swift.Error {
        case missingArgument
        case failedToDoSomething
    }
}

