# CLIQuickstart

<a id="toc"></a>
[Original Steps](#linkOriginalSteps) • 
[Resources](#linkResources) 

_`CLIQuickstart` is a quickstart template for a command line interface tool based on the Swift Package Manager.  The package provides both an executable module and a core framework module.  The executable plus core approach allows the `CLIQuickstart` framework to also be used as dependency in other Swift Packages._

**Options:**

```sh
CLIQuickstart --param=value

```

## Original Steps <a id="linkOriginalSteps"></a>[▴](#toc)

Summary of original steps used to create the CLIQuickstart example template.

``` sh
mkdir CLIQuickstart
cd CLIQuickstart
swift package init --type executable

# review & update .gitignore, as needed
nano .gitignore
```

**Framework & Executable Modules**

Create two modules: one framework `CLIQuickstart` and one executable `CLIQuickstartCore`. Each top level folder under `Sources` defines a module.

The executable module only contains the `main.swift` file. The core framework contains all of the tool’s actual functionality.  The separation of the core framework provides for *easier testing*; and, the *core framework can be used as a dependency in other executables*.

``` sh
// create core framework module
mkdir Sources/CLIQuickstartCore
```

Update `Package.swift` to define two targets — one for the `CLIQuickstart` executable module and one for the `CLIQuickstartCore` framework.

``` sh
# edit Package.swift
nano Package.swift
```

_Package.swift_

``` swift
import PackageDescription

let package = Package(
    name: "CLIQuickstart",
    // ...
    targets: [
        .target(
            name: "CLIQuickstart",
            dependencies: ["CLIQuickstartCore"]),
        .target(
            name: "CLIQuickstartCore",
            dependencies: []),
        // Test CLIQuickstartCore directly instead of CLIQuickstart main.swift
        .testTarget(
            name: "CLIQuickstartTests",
            dependencies: ["CLIQuickstartCore"]),
        // ...
    ]
)
```

**Define Programmatic Entry Point**

Create a new CLIQuickstart.swift core framework class.

``` sh
# nano Sources/CLIQuickstartCore/CLIQuickstart.swift
touch Sources/CLIQuickstartCore/CLIQuickstart.swift
edit Sources/CLIQuickstartCore/CLIQuickstart.swift 
```

``` swift
import Foundation

public final class CLIQuickstart {
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
import CLIQuickstartCore

let tool = CLIQuickstart()

do {
    try tool.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}
```

**Xcode**

``` sh
# edit Package.xcconfig 
nano Package.xcconfig
```

``` ini
/// macOS Deployment Target
MACOSX_DEPLOYMENT_TARGET=10.13

// Swift Language Version
// 
SWIFT_VERSION = 4.2
```

Generate an Xcode project.

``` sh
swift package update
swift package generate-xcodeproj --xcconfig-overrides Package.xcconfig
```

**Run**

``` sh
swift build
.build/debug/CLIQuickstart
# Hello World
```

**Test**

The `CLIQuickstartCore` framework can be tested directly. Or, a `Process` can be run to test the `CLIQuickstart` executable.

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

## Resources <a id="linkResources"></a>[▴](#toc)

* [Github/swift-package-manager: PackageDescription API Version 4.2 ⇗](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescriptionV4_2.md)
* [Swift by Sundell: Building a command line tool using the Swift Package Manager ⇗](https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager)
* [Swift by Sundell: Providing a unified Swift error API ⇗](https://www.swiftbysundell.com/posts/providing-a-unified-swift-error-api)
