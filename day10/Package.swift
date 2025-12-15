// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "day10",
    products: [
        .executable(name: "part1", targets: ["Part1"]),
        .executable(name: "part2", targets: ["Part2"]),
    ],
    targets: [
        .target(name: "Day10"),
        .executableTarget(name: "Part1", dependencies: ["Day10"], path: "Sources/Part1"),
        .executableTarget(name: "Part2", dependencies: ["Day10"], path: "Sources/Part2"),
        .executableTarget(name: "tests", dependencies: ["Day10"], path: "Sources/Tests"),
    ]
)
