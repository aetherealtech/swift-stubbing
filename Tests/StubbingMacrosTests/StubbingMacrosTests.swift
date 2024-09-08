import XCTest

#if canImport(StubbingMacros)
    import StubbingMacros

    import SwiftSyntaxMacrosTestSupport

    final class StubbingMacrosTests: XCTestCase {
        func testMacro() {
            assertMacroExpansion(
                """
                @Stubbable
                struct TestStruct {
                    let intMember: Int
                    let stringMember: String
                    let arrayMember: [String]
                }
                """,
                expandedSource:
                """
                struct TestStruct {
                    let intMember: Int
                    let stringMember: String
                    let arrayMember: [String]

                    public static var stub: Self {
                        .stub()
                    }

                    public static func stub(
                        intMember: Int = .stub,
                        stringMember: String = .stub,
                        arrayMember: [String] = .stub
                    ) -> Self {
                        .init(
                            intMember: intMember,
                            stringMember: stringMember,
                            arrayMember: arrayMember
                        )
                    }
                }

                extension TestStruct: Stubbable {
                }
                """,
                macros: ["Stubbable": StubbableMacro.self]
            )
        }
    }
#endif
