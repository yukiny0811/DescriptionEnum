// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(member, names: arbitrary)
public macro DescriptionEnum() = #externalMacro(module: "DescriptionEnumMacros", type: "DescriptionEnum")

public protocol EnumDescription {
    static var name: String { get }
    static var description: String { get }
}
