import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum StubbableMacroError: CustomStringConvertible, Error {
    case onlyApplicableToStruct

    var description: String {
        switch self {
            case .onlyApplicableToStruct: "@Stubbable can only be applied to a structure"
        }
    }
}

public struct StubbableMacro: MemberMacro, ExtensionMacro {
    public static func expansion(
        of _: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in _: some MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw StubbableMacroError.onlyApplicableToStruct
        }

        let members = structDecl.memberBlock
            .members
            .compactMap { member in member.decl.as(VariableDeclSyntax.self) }

        // If the struct has no members, then the stub function synthesized below would have no parameters.  A type cannot have a member and a function with no parameters with the same name.  Plus the function would be pointless because it's just equivalent to the member.  So in that case we only synthesize the member and have it call `init` directly.
        guard !members.isEmpty else {
            let memberInits = members
                .map { member in
                    let name = member.bindings.first!.pattern

                    return "\(name): .stub"
                }
                .joined(separator: ",\n")

            let stubMember = try VariableDeclSyntax("public static var stub: Self") {
                ExprSyntax(".init(\n\(raw: memberInits)\n)")
            }

            return [DeclSyntax(stubMember)]
        }

        let stubMember = try VariableDeclSyntax("public static var stub: Self") {
            ExprSyntax(".stub()")
        }

        let memberParams = members
            .map { member in
                let name = member.bindings.first!.pattern
                let type = member.bindings.first!.typeAnnotation!.type

                return "\(name): \(type) = .stub"
            }
            .joined(separator: ",\n")

        let memberInits = members
            .map { member in
                let name = member.bindings.first!.pattern

                return "\(name): \(name)"
            }
            .joined(separator: ",\n")

        let stubMethod = try FunctionDeclSyntax("public static func stub(\n\(raw: memberParams)\n) -> Self") {
            ExprSyntax(".init(\n\(raw: memberInits)\n)")
        }

        return [DeclSyntax(stubMember), DeclSyntax(stubMethod)]
    }

    public static func expansion(
        of _: AttributeSyntax,
        attachedTo _: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo _: [TypeSyntax],
        in _: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        let sendableExtension: DeclSyntax =
            """
            extension \(type.trimmed): Stubbable {}
            """

        return [sendableExtension.as(ExtensionDeclSyntax.self)!]
    }
}

@main
struct StubbableMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StubbableMacro.self,
    ]
}
