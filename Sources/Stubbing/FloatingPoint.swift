public extension BinaryFloatingPoint where RawSignificand: FixedWidthInteger {
    static var stub: Self { .random(in: -1e10 ..< 1e10) }
}

extension Float: Stubbable {}
extension Double: Stubbable {}

#if arch(arm64)
@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
extension Float16: Stubbable {}
#endif

#if !arch(arm64)
extension Float80: Stubbable {}
#endif
