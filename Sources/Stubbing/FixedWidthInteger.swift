public extension FixedWidthInteger {
    static var stub: Self { .random(in: Self.min ..< Self.max) }
}

extension Int: Stubbable {}
extension UInt: Stubbable {}

extension Int8: Stubbable {}
extension UInt8: Stubbable {}

extension Int16: Stubbable {}
extension UInt16: Stubbable {}

extension Int32: Stubbable {}
extension UInt32: Stubbable {}

extension Int64: Stubbable {}
extension UInt64: Stubbable {}
