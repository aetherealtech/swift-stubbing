import Foundation

extension URL: Stubbable {
    public static var stub: URL {
        .init(string: "https:\(String.stub)")!
    }
}
