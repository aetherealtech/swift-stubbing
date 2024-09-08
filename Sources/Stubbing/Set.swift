extension Set: Stubbable where Element: Stubbable {
    public static var stub: Self { .stub() }

    public static func stub(count: Int = .random(in: 4 ..< 16)) -> Self {
        .init((0 ..< count).lazy.map { _ in .stub })
    }
}
