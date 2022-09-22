import SnapshotTesting
import CustomDump

extension Snapshotting where Format == String {
  /// A snapshot strategy for comparing any structure based on a sanitized text dump.
  public static var customDump: Snapshotting {
    .customDump()
  }

  public static func customDump(name: String? = nil,
                                indent: Int = 0,
                                maxDepth: Int = .max) -> Snapshotting {
    SimplySnapshotting.lines.pullback {
      var output = ""
      CustomDump.customDump($0, to: &output, name: name, indent: indent, maxDepth: maxDepth)
      return output
    }
  }
}
