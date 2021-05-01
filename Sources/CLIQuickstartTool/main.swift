import Foundation
import CLIQuickstartLib

showEnvironment()
print(":MAIN: Bundle.moduleDir=\(Bundle.module)")
print(":MAIN: Bundle.moduleDir=\(Bundle.resourceModuleDir)")


let tool = CLIQuickstart()

do {
    try tool.run()
    exit(EXIT_SUCCESS)
} catch {
    print("CLIQuickstartLib tool.run() error: '\(error)'")
    exit(EXIT_FAILURE)
}

