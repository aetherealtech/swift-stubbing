import Foundation

extension UUID: Stubbable {
    public static var stub: Self {
        .init()
    }
}
