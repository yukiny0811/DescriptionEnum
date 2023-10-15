import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

internal struct EnumData {
    var name: String
    var description: String
}

public struct DescriptionEnum: MemberMacro {
    
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        
        let cases: [EnumData] = declaration.memberBlock.members
            .compactMap { memberBlockItem in
                let name = memberBlockItem
                    .decl
                    .as(EnumCaseDeclSyntax.self)?
                    .elements
                    .first?
                    .name
                    .text
                let description = memberBlockItem
                    .decl
                    .as(EnumCaseDeclSyntax.self)?
                    .elements
                    .first?
                    .rawValue?
                    .value
                    .as(StringLiteralExprSyntax.self)!
                    .segments
                    .first?
                    .description
                guard let name, let description else { return nil }
                return EnumData(name: name, description: description)
            }
        
        var nameMethod = "" + "\n"
        nameMethod += "public var name: String {" + "\n"
        nameMethod += "    return self.rawValue" + "\n"
        nameMethod += "}" + "\n"
        
        var descriptionMethod = "" + "\n"
        descriptionMethod += "public var desc: String {" + "\n"
        descriptionMethod += "    switch self {" + "\n"
        for c in cases {
            descriptionMethod += "    case .\(c.name):" + "\n"
            descriptionMethod += "        return \"\(c.description)\"" + "\n"
        }
        descriptionMethod += "    }" + "\n"
        descriptionMethod += "}" + "\n"
        
        var rawMethod = "" + "\n"
        rawMethod += "public var rawValue: String {" + "\n"
        rawMethod += "    switch self {" + "\n"
        for c in cases {
            rawMethod += "    case .\(c.name):" + "\n"
            rawMethod += "        return \"\(c.name)\"" + "\n"
        }
        rawMethod += "    }" + "\n"
        rawMethod += "}" + "\n"
        
        var rawInit = "" + "\n"
        rawInit += "public init?(rawValue: String) {" + "\n"
        rawInit += "    switch rawValue {" + "\n"
        for c in cases {
            rawInit += "    case \"\(c.name)\":" + "\n"
            rawInit += "        self = .\(c.name)" + "\n"
        }
        rawInit += "    default:" + "\n"
        rawInit += "        return nil" + "\n"
        rawInit += "    }" + "\n"
        rawInit += "}" + "\n"
        
        return [DeclSyntax(stringLiteral: nameMethod + descriptionMethod + rawMethod + rawInit)]
    }
}

@main
struct DescriptionEnumPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DescriptionEnum.self,
    ]
}
