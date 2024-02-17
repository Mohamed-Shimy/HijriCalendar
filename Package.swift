// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HijriCalendar",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        .library(
            name: "HijriCalendar",
            targets: ["HijriCalendar"]
        ),
    ],
    targets: [
        .target(
            name: "HijriCalendar"),
        .testTarget(
            name: "HijriCalendarTests",
            dependencies: ["HijriCalendar"]
        ),
    ]
)
