public extension RangeReplaceableCollection where Element: Stubbable {
    static var stub: Self { .stub() }

    static func stub(count: Int = .random(in: 4 ..< 16)) -> Self {
        .init((0 ..< count).lazy.map { _ in .stub })
    }
}

extension Array: Stubbable where Element: Stubbable {}
