# CLIQuickstartLib

_**Title: url(forResource:withExtension:subdirectory:localization:) with SwiftPM is inconsistent (at best) and causes "core dump" (at worst)**_

The `url(forResource:withExtension:subdirectory:localization:)` resource location method is (at best) inconsistent across platforms and can (at worst) cause a "core dump" when used with a Swift Package which includes resources.



_`CLIQuickstartLib` is an "almost" minimal Swift Package Manager template with various package resources. The package provides both an executable module and a core framework library module. Resources are included for each the library, the executable and the tests._

The "not-quite" minimal part is the addition checks for various approaches to resource access.

Factors

* platform: Linux, macOS
* build chain execution: Linux command line interface (CLI), macOS command line interface (CLI), macOS Xcode IDE
* top level resources directory name: `Resources` or something else
* resource asset directory level: top level or some sub directory
* use of localization

Given a package with the code and resources structure show below:

```
```

The built product resource structure varies based on the platform and build chain used

```
```

In general, `url(forResource: …, withExtension: …, …)` is expected to reliably handle cross-platform differences in a reliably consistent and robust way.

However, here is the observed table of what access path names work:

|                  _(subdirectory)_ `forResource:` | Linux CLI   | macOS CLI   | macOS Xcode | 
|-------------------------------------------------:|:-----------:|:-----------:|:-----------:|
|           **`Resources/resource_file_tool.txt`** | 💥 | 👍 | 👍 |
|              `(Resources)resource_file_tool.txt` | 💥 | 👍 | 👍 |
|                         `resource_file_tool.txt` | 👍 | 👍 | 🚫 |
|            **`Resources/resource_file_lib.txt`** | 💥 | 👍 | 👍 |
|               `(Resources)resource_file_lib.txt` | 💥 | 👍 | 👍 |
|                          `resource_file_lib.txt` | 👍 | 👍 | 🚫 |
|                    **`Resources/img/watch.jpg`** | 👍 | 👍 | 👍 |
|                       `(Resources/img)watch.jpg` | 👍 | 👍 | 👍 |
|                                  `img/watch.jpg` | 👍 | 👍 | 🚫 |
|                                 `(img)watch.jpg` | 👍 | 👍 | 🚫 |
|                                      `watch.jpg` | 🚫 | 🚫 | 🚫 |
|        **`Resources_A/resource_file_lib_a.txt`** | 👍 | 👍 | 👍 |
|           `(Resources_A)resource_file_lib_a.txt` | 👍 | 👍 | 👍 |
|                        `resource_file_lib_a.txt` | 🚫 | 🚫 | 🚫 |
|            **`Resources_A/img/electricity.jpg`** | 👍 | 👍 | 👍 |
|               `(Resources_A/img)electricity.jpg` | 👍 | 👍 | 👍 |
|                            `img/electricity.jpg` | 🚫 | 🚫 | 🚫 |
|                           `(img)electricity.jpg` | 🚫 | 🚫 | 🚫 |
|                                `electricity.jpg` | 🚫 | 🚫 | 🚫 |
|                                                  | | | |
|            "en" **`Resources/LocalData00.json`** | 💥 | 👍 | 🚫 |
|               "en" `(Resources)LocalData00.json` | 💥 | 👍 | 🚫 |
|                          "en" `LocalData00.json` | 👍 | 👍 | 🚫 |
|                       "es-MX" `LocalData00.json` | 👍 | 👍 | 🚫 |
|    "en" `Resources/DataFiles/…/LocalData01.json` | 🚫 | 🚫 | 🚫 |
|            "en" `Resources_A/…/LocalData10.json` | 🚫 | 🚫 | 🚫 |
|  "en" `Resources_A/DataFiles/…/LocalData11.json` | 🚫 | 🚫 | 🚫 |

_💥 Fatal Runtime Error (Linux CLI)_

``` sh
# Foundation/NSCFString.swift:119: Fatal error: Constant strings cannot be deallocated
# Illegal instruction (core dumped)
```

**Issues**

* Top level resource assets can not accessed in a uniform way across platforms.
* Top level _resource directory name_ affects how assets can be successfully accessed.
* In some cases, Swift Foundation on Linux exhibits a _fatal runtime error_.

**Cross Platform Workaround**

A uniform approach which avoids cross platform `#if os(…)` compiler directives:

1. Put all assets in a resources subdirectory.
2. Provide the `forResource:` argument with the _full sub-path name_.


<a id="contents"></a>
[Original Project Setup](#original-project-setup-) • 
[Miscellaneous](#miscellaneous-) • 
[Resources](#resources-) 

**TODO**

* change `main.swift` file to `@main` attribute
* find where the resources are placed after build on various computer platforms. On macOS, include build types: command line, Xcode with Package.swift and a generated Xcode project.
    * 

_TODO: Linux Tests_

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

Right-click `Package.swift`. Select `Open With` > `Xcode.app`. 

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

_Windows_

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

* Apple Developer Documentation
    * [`CFBundleDevelopmentRegion`](https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundledevelopmentregion)
    * [Swift Packages](https://developer.apple.com/documentation/swift_packages)
        * [Bundling Resources with a Swift Package](https://developer.apple.com/documentation/swift_packages/bundling_resources_with_a_swift_package)
        * [Localizing Package Resources](https://developer.apple.com/documentation/swift_packages/localizing_package_resources)
* [Github/swift-package-manager: PackageDescription ⇗](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md)
* [Swift by Sundell: Building a command line tool using the Swift Package Manager ⇗](https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager)
* [Swift by Sundell: Providing a unified Swift error API ⇗](https://www.swiftbysundell.com/posts/providing-a-unified-swift-error-api)
