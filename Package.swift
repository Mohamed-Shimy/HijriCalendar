// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HijriCalendar",
    platforms: [.iOS(.v26), .macOS(.v26)],
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
