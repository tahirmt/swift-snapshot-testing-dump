# swift-snapshot-testing-dump

A plugin for [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) that combines it with [swift-custom-dump](https://github.com/pointfreeco/swift-custom-dump/) to be able to produce textual snapshots of model objects.

### Usage

Swift Package Manager

If you want to use SnapshotTesting in any other project that uses SwiftPM, add the package as a dependency in Package.swift:

```
dependencies: [
  .package(
    url: "https://github.com/tahirmt/swift-snapshot-testing-dump",
    from: "1.0.0"
  ),
]
```
Next, add `SnapshotTestingDump` as a dependency of your test target:

```
targets: [
  .target(name: "MyApp"),
  .testTarget(
    name: "MyAppTests",
    dependencies: [
      "MyApp",
      .product(name: "SnapshotTestingDump", package: "swift-snapshot-testing-dump"),
    ]
  )
]
```
