![Trevi](./imgs/trevi_logo.png)

[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Mac OS X](https://img.shields.io/badge/platform-osx-lightgrey.svg?style=flat)](https://developer.apple.com/swift/)
[![Ubuntu](https://img.shields.io/badge/platform-linux-lightgrey.svg?style=flat)](http://www.ubuntu.com/)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)

## Overview
Fast, light web application server framework for Swift. Trevi uses an event-driven, non-blocking I/O model based on libuv (https://github.com/libuv/libuv).  
Trevi refers to node.js core modules and makes Trevi core modules similar to support node.js features. Trevi also hopes that node.js developers easily use and develop Trevi.  

## Notice
If you want to build or test all projects at Xcode, please check out [Trevi-Dev](https://github.com/Trevi-Swift/Trevi-Dev). 
Otherwise, you can build Trevi, lime and other packages by using Swift Package manager.  
[Here](https://github.com/Trevi-Swift/example-trevi-lime) are an example and it now runs on Linux.  

## Features
- Handles persistent streams
- No dependencies
- Effective data transfer
- Parsing HTTP message

## Swift version
Trevi works with the latest version of Swift 3.0 or latest Snapshot. You can download Swift binaries on [here](https://swift.org/download/#latest-development-snapshots).

## Installation (Ubuntu; APT-based linux)
1. Update your local package index first.
    ```bash
    $ sudo apt-get update && sudo apt-get upgrade
    ```
    
2. Install Swift dependencies on linux:
    ```bash
    $ sudo apt-get install clang libicu-dev
    ```
    
3. Install Swift depending on your platform on the follow [link](https://swift.org/download) (The latest version are recommended).

4. After installation of Swift, check your PATH environment variable whether Swift binary path is set or not. If it is not set execute below.:
    ```bash
    $ export PATH=/path/to/swift/installed/usr/bin:"${PATH}"
    ```
    
    More details : 'Linux' on [here](https://swift.org/download)
    
5. Install git to clone libuv:
    ```bash
    $ sudo apt-get install git
    ```
    
6. Install libuv dependencies on linux:
    ```bash
    $ sudo apt-get install autoconf automake make build-essential libtool gcc g++
    ```
    
7. Clone libuv:
    ```bash
    $ git clone https://github.com/libuv/libuv.git
    ```
    
6. Install libuv:
    ```bash
    $ cd libuv
    $ sh autogen.sh
    $ ./configure
    $ make
    $ make check
    $ sudo make install
    ```
    
    More details : Build Instructions on [libuv](https://github.com/libuv/libuv)
    
5. Set LD_LIBRARY_PATH environment variable to run executable.
    ```bash
    $ export LD_LIBRARY_PATH=/usr/local/lib/:/usr/lib:$LD_LIBRARY_PATH
    ```

## Installation (OS X)
1. Install Swift depending on your platform on the follow [link](https://swift.org/download) (The latest version are recommended).

2. After installation of Swift, check your PATH environment variable whether Swift binary path is set or not. If it is not set execute below.:
    ```bash
    $ export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:"${PATH}"
    ```
    
    More details : 'Apple Platforms' on [here](https://swift.org/download)
    
3. Clone libuv:
    ```bash
    $ git clone https://github.com/libuv/libuv.git
    ```
    
4. Install libuv:
    ```bash
    $ cd libuv
    $ sh autogen.sh
    $ ./configure
    $ make
    $ make check
    $ sudo make install
    ```
    
    or using Homebrew:
    
    ```bash
    $ brew install --HEAD libuv
    ```
    
    More details : Build Instructions on [libuv](https://github.com/libuv/libuv)
    
5. Set LD_LIBRARY_PATH environment variable to run executable.
    ```bash
    $ export LD_LIBRARY_PATH=/usr/local/lib/:/usr/lib:$LD_LIBRARY_PATH
    ```

## Usage
1. Create a new project directory
    ```bash
    mkdir HelloTrevi
    ```
    
2. Initialize this project as a new Swift package project
    ```bash
    $ cd HelloTrevi
    $ swift build --init
    ```
    
    Now your directory structure under HelloTrevi should look like this :
    <pre>
    HelloTrevi
    ├── Package.swift
    ├── Sources
    │   └── main.swift
    └── Tests
      └── <i>empty</i>
    </pre>
    **Note**: For more information on the Swift Package Manager, go [here](https://swift.org/package-manager)

3. Add a dependency of Trevi for your project (Package.swift) :
    ```swift
    import PackageDescription
    
    let package = Package(
        name: "HelloTrevi",
        dependencies: [
          .Package(url: "https://github.com/Trevi-Swift/Trevi.git", versions: Version(0,1,0)..<Version(0,2,0)),
        ]
    )
    ```

4. Import the modules, create and start a HTTPServer in your code (Sources/main.swift) :
    ```swift
    import Trevi

    let server = Http ()

    server.createServer({ (req, res, next) in
        res.statusCode = 200
        res.write("Hello Trevi")
        res.end()
    }).listen(8081)
    ```
5. Build your application :
    - Mac OS X:  
        ```bash
        $ swift build -Xcc -fblocks -Xswiftc -I/usr/local/include -Xlinker -L/usr/local/lib
        ```
        
    - Ubuntu:  
        ```bash
        $ swift build -Xcc -fblocks
        ```

6. Now run your application:
    ```bash
    $ .build/debug/HelloTrevi
    ```

    Note: May need to set LD_LIBRARY_PATH environment variable to run:
    ```bash
    $ export LD_LIBRARY_PATH=/usr/local/lib/:/usr/lib:$LD_LIBRARY_PATH
    ```

7. Open your browser at [http://localhost:8080](http://localhost:8080)

8. Enjoy Trevi!

## Versioning
Trevi follows the semantic versioning scheme. The API change and backwards compatibility rules are those indicated by [SemVer](http://semver.org/).

## License
This library is licensed under Apache 2.0. Full license text is available in [LICENSE](LICENSE.txt).

```
Copyright 2015 Trevi Community

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
