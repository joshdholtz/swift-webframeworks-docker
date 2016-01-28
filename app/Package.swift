import PackageDescription

let package = Package(
    dependencies: [
      .Package(url: "https://github.com/takebayashi/swiftra.git", Version(0, 0, 6)),
      //.Package(url: "https://github.com/Zewo/Epoch.git", majorVersion: 0, minor: 1),
			//.Package(url: "https://github.com/Zewo/Router.git", majorVersion: 0, minor: 1)
    ]
)
