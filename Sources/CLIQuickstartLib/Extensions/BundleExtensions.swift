//
//  BundleExtensions.swift
//  CLIQuickstartLib
//
//  Created by marc on 2020.07.29.
//

import Foundation

extension Foundation.Bundle {

    /// Directory containing resource bundle
    static var resourceModuleDir: URL = {
        print(":DEBUG: CliQuickstartLib resourceModuleDir ")
        var url = Bundle.main.bundleURL
        // :!!!: verify resourceModuleDir logic
        for bundle in Bundle.allBundles {
            print("   … found \(bundle)")
            if bundle.bundlePath.hasSuffix(".xctest") {
                // remove 'ExecutableNameTests.xctest' path component
                url = bundle.bundleURL.deletingLastPathComponent()
            }
        }
        return url
    }()
    
}
