public protocol Stubbable {
    static var stub: Self { get }
}

@attached(member, names: named(stub), named(stub))
@attached(extension, conformances: Stubbable)
public macro Stubbable() = #externalMacro(module: "StubbingMacros", type: "StubbableMacro")
