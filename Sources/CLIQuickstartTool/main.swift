import CLIQuickstartLib

let tool = CLIQuickstart()

do {
    try tool.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}

