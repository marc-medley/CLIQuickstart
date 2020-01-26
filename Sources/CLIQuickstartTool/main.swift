import Foundation
import CLIQuickstartLib

showEnvironment()
let tool = CLIQuickstart()

do {
    try tool.run()
    exit(EXIT_SUCCESS)
} catch {
    print("CLIQuickstartLib tool.run() error: '\(error)'")
    exit(EXIT_FAILURE)
}

