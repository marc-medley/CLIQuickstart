# CLIQuickstartTool

<a id="contents"></a>
[Original Project Setup](#original-project-setup-) • 
[Miscellaneous](#miscellaneous-) • 
[Resources](#resources-) 

_`CLIQuickstartTool` is a quickstart template for a library with a command line interface tool based on the Swift Package Manager.  The package provides both an executable module and a core framework module.  The executable plus core approach allows the `CLIQuickstartLib` framework to also be used as dependency in other Swift Packages._

**Options:**

```sh
CLIQuickstartTool --param=value
```

## Original Project Setup <a id="original-project-setup-"></a>[▴](#contents)

Summary of original steps used to create the CLIQuickstart example template.

``` sh
mkdir CLIQuickstartLib
cd CLIQuickstartLib
swift package init --type library

# review & update .gitignore, as needed
nano .gitignore
```

**Framework & Executable Modules**

Create two modules: one framework `CLIQuickstartLib` and one executable `CLIQuickstartTool`. Each top level folder under `Sources` defines a module.

The executable module only contains the `main.swift` file. The core framework contains all of the tool’s actual functionality.  The separation of the core framework provides for *easier testing*; and, the *core framework can be used as a dependency in other executables*.

``` sh
// create core framework module
mkdir Sources/CLIQuickstartTool
```

Update `Package.swift` to define two targets — one for the `CLIQuickstartTool` executable module and one for the `CLIQuickstartLib` framework.

``` sh
# edit Package.swift
nano Package.swift
```

_Package.swift_

``` swift
import PackageDescription

let package = Package(
    name: "CLIQuickstartLib",
    // ...
    targets: [
        .target(
            name: "CLIQuickstartLib",
            dependencies: []),
        .target(
            name: "CLIQuickstartTool",
            dependencies: ["CLIQuickstartLib"]),
        // Test CLIQuickstartLib directly instead of CLIQuickstartTool main.swift
        .testTarget(
            name: "CLIQuickstartTests",
            dependencies: ["CLIQuickstartLib"]),
        // ...
    ]
)
```

**Define Programmatic Entry Point**

Create a new CLIQuickstartLib.swift core framework class.

``` sh
# nano Sources/CLIQuickstartLib/CLIQuickstart.swift
touch Sources/CLIQuickstartLib/CLIQuickstartLib.swift
edit Sources/CLIQuickstartLib/CLIQuickstartLib.swift 
```

``` swift
import Foundation

public final class CLIQuickstartRuntime {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) { 
        self.arguments = arguments
    }

    public func run() throws {
        print("Hello world")
    }
}
```

Update Sources/CLIQuickstart/main.swift to call the `run()` method which is in the core framework CLIQuickstart class.

``` sh
# nano Sources/CLIQuickstart/main.swift
edit Sources/CLIQuickstart/main.swift
```


``` swift
import CLIQuickstartLib

let tool = CLIQuickstart()

do {
    try tool.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}
```

**Xcode**

Generate an Xcode project.

``` sh
swift package update
swift package generate-xcodeproj --xcconfig-overrides
```

**Run**

``` sh
swift build
.build/debug/CLIQuickstart
# Hello World
```

**Test**

The `CLIQuickstartLib` framework can be tested directly. Or, a `Process` can be run to test the `CLIQuickstart` executable.

_Command Line Tests_


``` sh
## runs 'All tests'
## path .build/architecture/debug/CLIQuickstart
swift test
```

_Xcode Testing_

Runs 'Selected Tests'. Execution path: .../DerivedData/CLIQuickstart-id/Build/Products/Debug/CLIQuickstart

**Installation**

To run the CLI tool from anywhere, move the executable command to some path which is present on the `$PATH` environment variable. For example, move the the compiled binary to `/usr/local/bin` or `/opt/local/bin`.

> Note: On macOS, `brew doctor` may complain about file in `/usr/local/bin` which are not managed by Homebrew. 

``` sh
swift build --configuration release
```

_macOS_

``` sh
# Linking ./.build/x86_64-apple-macosx10.10/release/CLIQuickstart
cd .build/x86_64-apple-macosx10.10/release

sudo mkdir -p /opt/local/bin
// -f force overwrite of existing file
cp -f CLIQuickstart /opt/local/bin/CLIQuickstart
```

_Ubuntu_

``` sh
# Linking ./.build/x86_64-apple-macosx10.10/release/CLIQuickstart

cd .build/release
#cp -f CLIQuickstart /usr/local/bin/CLIQuickstart
cp -f CLIQuickstart /opt/local/bin/CLIQuickstart
```

## Miscellaneous <a id="miscellaneous-"></a>[▴](#contents)

* The archive action does not code sign command-line executable products from Swift packages. (48717735) [Xcode 11 release notes.](https://developer.apple.com/documentation/xcode_release_notes/xcode_11_release_notes)
    * Workaround: Manually sign archived executables using the `codesign` tool before distributing them.

## Resources <a id="resources-"></a>[▴](#contents)

* [Github/swift-package-manager: PackageDescription ⇗](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md)
* [Swift by Sundell: Building a command line tool using the Swift Package Manager ⇗](https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager)
* [Swift by Sundell: Providing a unified Swift error API ⇗](https://www.swiftbysundell.com/posts/providing-a-unified-swift-error-api)
