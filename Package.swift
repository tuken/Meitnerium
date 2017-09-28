import PackageDescription

let package = Package(
    name: "Meitnerium",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
        .Package(url: "https://github.com/noppoMan/SwiftKnex.git", majorVersion: 0),
        .Package(url: "https://github.com/vapor/validation.git", majorVersion: 1),
    ]
)
