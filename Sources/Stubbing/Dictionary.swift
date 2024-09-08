extension Dictionary: Stubbable where Key: Stubbable, Value: Stubbable {
    public static var stub: Self { .stub() }

    public static func stub(count: Int = .random(in: 4 ..< 16)) -> Self {
        .init(uniqueKeysWithValues: (0 ..< count).lazy.map { _ -> (Key, Value) in
            (.stub, .stub)
        })
    }
}
