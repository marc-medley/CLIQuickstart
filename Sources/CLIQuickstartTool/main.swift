//
//  main.swift
//  CLIQuickstartLib::CLIQuickstartTool
//

import Foundation
import CLIQuickstartLib

ResourceHelper.checkResourceAccessApproaches()
//ResourceHelper.showEnvironment()

// Minimal Executable

let tool = CLIQuickstart()

do {
    try tool.run()
    exit(EXIT_SUCCESS)
} catch {
    print("CLIQuickstartLib tool.run() error: '\(error)'")
    exit(EXIT_FAILURE)
}
