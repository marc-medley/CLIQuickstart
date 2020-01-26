//
//  ShowEnvironment.swift
//  CLIQuickstartLib
//
//

import Foundation

public func showEnvironment() {
    print("\n###########################")
    print(  "## ProcessInfo ARGUMENTS ##")
    for a in ProcessInfo.processInfo.arguments {
        print(a)
    }
    
    print("\n#############################")
    print(  "## ProcessInfo ENVIRONMENT ##")
    for e in ProcessInfo.processInfo.environment {
        print(e)
    }
        
    // Note: does not evaluate `$HOME`
    //print("\n###############")
    //print(  "## /bin/echo ##")
    //let echo = Process()
    //let echoOut = Pipe()
    //echo.arguments = ["$HOME"]
    //echo.launchPath = "/bin/echo"
    //echo.standardOutput = echoOut
    //echo.launch()
    //echo.waitUntilExit()
    //print (String(data: echoOut.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8) ?? "")
    
    
    print("\n##################")
    print(  "## /usr/bin/env ##")
    let env = Process()
    let envOut = Pipe()
    env.launchPath = "/usr/bin/env"
    env.standardOutput = envOut
    env.launch()
    env.waitUntilExit()
    print (String(data: envOut.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8) ?? "")    

    print("##################\n")

}
