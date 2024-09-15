import XCTest
import SnapshotTesting
import CustomDump
@testable import SnapshotTestingDump

final class SnapshotTestingDumpTests: XCTestCase {
    func testStruct() throws {
        struct User {
            let name = "John"
            let email = "john@me.com"
            let age = 97
        }

        assertSnapshot(of: User(), as: .customDump)
    }

    func testClass() throws {
        class User {
            let name = "John"
            let email = "john@me.com"
            let age = 97
        }

        assertSnapshot(of: User(), as: .customDump)
    }

    func testClassWithSuperclass() throws {
        class User {
            let name = "John"
            let email = "john@me.com"
            let age = 97
        }

        class Doctor: User {
            let field = "Podiatry"
            let level = "Expert"
        }

        customDump(Doctor())
        assertSnapshot(of: Doctor(), as: .customDump)
    }

    func testNSObjectClass() throws {
        class User: NSObject {
            let name = "John"
            let email = "john@me.com"
            let age = 97
        }

        customDump(User())
        assertSnapshot(of: User(), as: .customDump)
    }

    func testComplexStructure() throws {
        struct User {
            let name = "John"
            let email = "john@me.com"
            let age = 97
            let friends = [
                "James",
                "Lilly",
                "Peter",
                "Remus",
            ]
        }

        assertSnapshot(of: User(), as: .customDump)
    }

    func testRecursion() throws {
        class Human {
            let name: String

            init(name: String) {
                self.name = name
            }
        }

        class Child: Human {
            weak var parent: Parent?
        }

        class Parent: Human {
            let children: [Human]

            init(name: String, children: [Child]) {
                self.children = children
                super.init(name: name)

                children.forEach {
                    $0.parent = self
                }
            }
        }

        let subject = Parent(name: "Arthur", children: [
            Child(name: "Virginia"),
            Child(name: "Ronald"),
            Child(name: "Fred"),
            Child(name: "George"),
            Child(name: "Percy"),
            Child(name: "Charles"),
        ])

        assertSnapshot(of: subject, as: .customDump)
    }

    func testLevelsOfInheritance() throws {
        class Human {
            let name: String

            init(name: String) {
                self.name = name
            }
        }

        class Driver: Human {
            let wheels: Int

            init(name: String, wheels: Int) {
                self.wheels = wheels
                super.init(name: name)
            }
        }

        class TruckDriver: Driver {
            let truckType: String

            init(name: String, wheels: Int, truckType: String) {
                self.truckType = truckType
                super.init(name: name, wheels: wheels)
            }
        }

        assertSnapshot(of: TruckDriver(name: "Jimmy", wheels: 6, truckType: "Loader"), as: .customDump)
    }
}
