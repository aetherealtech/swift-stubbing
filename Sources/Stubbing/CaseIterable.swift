public extension CaseIterable {
    static var stub: Self {
        allCases.randomElement()!
    }
}
