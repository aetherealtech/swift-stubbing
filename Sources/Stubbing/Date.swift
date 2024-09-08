import Foundation

extension Date: Stubbable {
    public static var stub: Date {
        .init(timeIntervalSince1970: .random(in: -1e12 ..< 1e12))
    }
}
