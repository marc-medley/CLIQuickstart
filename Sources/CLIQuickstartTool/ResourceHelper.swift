//
//  ResourceHelper.swift
//  CLIQuickstartLib::CLIQuickstartTool
//

import Foundation
import CLIQuickstartLib

struct ResourceHelper {
    enum Selector {
        case library
        case tool
    }
    
    // Foundation/NSCFString.swift:119: Fatal error: Constant strings cannot be deallocated
    // Illegal instruction (core dumped)
    static func checkResourceAccessApproaches() {
        print("\n••• :BEGIN: ResourceHelper.checkResourceAccessApproaches() •••")
        // macOS, iOS, watchOS, tvOS, Linux, Windows
#if os(macOS)
        print("Built for macOS")
        let version = ProcessInfo.processInfo.operatingSystemVersion
        print("Operating System Version: \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)")
        print("Operating System Version String: \(ProcessInfo().operatingSystemVersionString)")
#elseif os(Linux)
        print("Built for Linux")
#elseif os(Windows)
        print("Built for Windows")
#endif
        
        print("\n------- TOOL MODULE -------")
        let toolModule: Bundle = Bundle.module
        print("toolModule.bundleIdentifier: \(toolModule.bundleIdentifier ?? "NIL")")
        print("toolModule.bundlePath: \(toolModule.bundlePath)")
        print("toolModule.resourcePath: \(toolModule.resourcePath ?? "NIL")")
        
        print("\n------- LIBRARY MODULE -------")
        let libraryModule: Bundle = CLIQuickstart.resourceModule
        print("libraryModule.bundleIdentifier: \(libraryModule.bundleIdentifier ?? "NIL")")
        print("libraryModule.bundlePath: \(libraryModule.bundlePath)")        
        print("libraryModule.resourcePath: \(libraryModule.resourcePath ?? "NIL")")
        
        print("\n------- TOOL MODULE RESOURCES -------")
        print("--- Resources/resource_file_tool")
#if os(Linux)
        print("NOT_CHECKED: Resources/resource_file_tool (Reason: avoids Linux 'Constant strings cannot be deallocated' fatal runtime error)")
        print("NOT_CHECKED: (Resources)resource_file_tool (Reason: avoids Linux 'Constant strings cannot be deallocated' fatal runtime error)")
#else
        print(checkResource(selector: .tool, name: "Resources/resource_file_tool", withExtension: "txt"))
        print(checkResource(selector: .tool, name: "resource_file_tool", withExtension: "txt", subdirectory: "Resources"))
#endif
        print(checkResource(selector: .tool, name: "resource_file_tool", withExtension: "txt"))
        
        print("\n------- LIBRARY MODULE RESOURCES -------")        
        print("--- Resources/resource_file_lib")
#if os(Linux)
        print("NOT_CHECKED: Resources/resource_file_lib (Reason: avoids Linux 'Constant strings cannot be deallocated' fatal runtime error)")
        print("NOT_CHECKED: (Resources)resource_file_lib (Reason: avoids Linux 'Constant strings cannot be deallocated' fatal runtime error)")
#else
        print(checkResource(selector: .library, name: "Resources/resource_file_lib", withExtension: "txt"))
        print(checkResource(selector: .library, name: "resource_file_lib", withExtension: "txt", subdirectory: "Resources"))        
#endif
        print(checkResource(selector: .library, name: "resource_file_lib", withExtension: "txt"))        
        
        print("\n--- Resources/img/watch.jpg")
        print(checkResource(selector: .library, name: "Resources/img/watch", withExtension: "jpg"))
        print(checkResource(selector: .library, name: "img/watch", withExtension: "jpg"))
        print(checkResource(selector: .library, name: "watch", withExtension: "jpg"))
        print(checkResource(selector: .library, name: "watch", withExtension: "jpg", subdirectory: "Resources/img"))
        print(checkResource(selector: .library, name: "watch", withExtension: "jpg", subdirectory: "img"))
        
        print("\n--- Resources_A/resource_file_lib_a.text")
        print(checkResource(selector: .library, name: "Resources_A/resource_file_lib_a", withExtension: "txt"))
        print(checkResource(selector: .library, name: "resource_file_lib_a", withExtension: "txt"))
        print(checkResource(selector: .library, name: "resource_file_lib_a", withExtension: "txt", subdirectory: "Resources_A"))
        
        print("\n--- Resources_A/img/electricity.jpg")        
        print(checkResource(selector: .library, name: "Resources_A/img/electricity", withExtension: "jpg"))
        print(checkResource(selector: .library, name: "img/electricity", withExtension: "jpg"))
        print(checkResource(selector: .library, name: "electricity", withExtension: "jpg"))
        print(checkResource(selector: .library, name: "electricity", withExtension: "jpg", subdirectory: "Resources_A/img"))
        print(checkResource(selector: .library, name: "electricity", withExtension: "jpg", subdirectory: "img"))
        
        print("\n------- LIBRARY MODULE LOCALIZED RESOURCES -------")
#if os(Linux)
        print("NOT_CHECKED: Resources/LocalData_00 (Reason: avoids Linux 'Constant strings cannot be deallocated' fatal runtime error)")
        print("NOT_CHECKED: (Resources)LocalData_00 (Reason: avoids Linux 'Constant strings cannot be deallocated' fatal runtime error)")
#else
        print(checkResource(selector: .library, name: "Resources/LocalData_00", withExtension: "json", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_00", withExtension: "json", subdirectory: "Resources", localization: "en"))
#endif
        print(checkResource(selector: .library, name: "LocalData_00", withExtension: "json", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_00", withExtension: "json", localization: "es"))
        print(checkResource(selector: .library, name: "LocalData_00", withExtension: "json", localization: "es-MX"))
        
        print(checkResource(selector: .library, name: "Resources/DataFiles/LocalData_01", withExtension: "json", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_01", withExtension: "json", subdirectory: "Resources/DataFiles", localization: "en"))
        print(checkResource(selector: .library, name: "DataFiles/LocalData_01", withExtension: "json", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_01", withExtension: "json", subdirectory: "DataFiles", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_01", withExtension: "json", localization: "en"))
        
        print(checkResource(selector: .library, name: "Resources_A/LocalData_10", withExtension: "json", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_10", withExtension: "json", subdirectory: "Resources_A", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_10", withExtension: "json", localization: "en"))
        
        print(checkResource(selector: .library, name: "Resources_A/DataFiles/LocalData_11", withExtension: "json", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_11", withExtension: "json", subdirectory: "Resources_A/DataFiles", localization: "en"))
        print(checkResource(selector: .library, name: "DataFiles/LocalData_11", withExtension: "json", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_11", withExtension: "json", subdirectory: "DataFiles", localization: "en"))
        print(checkResource(selector: .library, name: "LocalData_11", withExtension: "json", localization: "en"))
        
        print("\n••• :END: ResourceHelper.checkResourceAccessApproaches() •••\n")
    }
    
    static func checkResource(selector: Selector, name: String, withExtension: String, subdirectory: String? = nil, localization: String? = nil) -> String {
        let subdir = (subdirectory != nil) ? "(\(subdirectory!))" : ""
        let locale = (localization != nil) ? "(locale: \(localization!))" : ""
        if let url = getResource(selector: selector, name: name, withExtension: withExtension, subdirectory: subdirectory, localization: localization) {            
            return "YES_FOUND: \(subdir)\(name) \(locale) url==\(url.path)"
        } else {
            return "NOT_FOUND: \(subdir)\(name) \(locale)"
        }
    }
    
    static func getResource(selector: Selector, name: String, withExtension: String, subdirectory: String? = nil, localization: String? = nil) -> URL? {
        var module: Bundle!
        switch selector {
        case .library:
            module = CLIQuickstart.resourceModule
        case .tool:
            module = Bundle.module        
        } 
        return module.url(forResource: name, withExtension: withExtension, subdirectory: subdirectory, localization: localization)
    }
    
    public static func showEnvironment() {
        print("""
        
        #######################
        ## showEnvironment() ##
        #######################
        
        ###########################
        ## ProcessInfo ARGUMENTS ##
        """)
        for a in ProcessInfo.processInfo.arguments { // CommandLine.arguments
            print(a)
        }
        
        print("""
        
        #############################
        ## ProcessInfo ENVIRONMENT ##
        """)
        for e in ProcessInfo.processInfo.environment {
            print(e)
        }
        
        // Note: does not evaluate `$HOME`
        //print("""
        //    ###############
        //    ## /bin/echo ##
        //""")
        //let echo = Process()
        //let echoOut = Pipe()
        //echo.arguments = ["$HOME"]
        //echo.executableURL = URL(fileURLWithPath: "/bin/echo")
        //echo.standardOutput = echoOut
        //echo.run()
        //echo.waitUntilExit()
        //print (String(data: echoOut.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8) ?? "")
        
        
        print("""
        
        ##################
        ## /usr/bin/env ##
        """)
        let env = Process()
        let envOut = Pipe()
        env.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        env.standardOutput = envOut
        do {
            try env.run()
            env.waitUntilExit()
            print (String(data: envOut.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8) ?? "")    
        } catch {
            print("FAILED: env.run()\n\(error)")
        }
        
        print("""
        
        ############################
        ## END: showEnvironment() ##
        ############################
        """)
    }
    
    func printProcessInfo() {
        
    }
    
}
