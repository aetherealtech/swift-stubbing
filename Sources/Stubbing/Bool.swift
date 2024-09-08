extension Bool: Stubbable {
    public static var stub: Bool {
        Bool.random()
    }
}
