extension Optional: Stubbable where Wrapped: Stubbable {
    public static var stub: Self {
        Bool.stub ? Wrapped.stub : nil
    }

    public static var stubNonNil: Self {
        Wrapped.stub
    }
}
