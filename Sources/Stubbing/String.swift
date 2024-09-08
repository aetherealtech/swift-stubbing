extension Character: Stubbable {
    public static var stub: Character {
        .init(Unicode.Scalar(.stub))
    }
}

extension String: Stubbable {
    static func stub(prefix: String) -> Self {
        "\(prefix): \(stub)"
    }
}
