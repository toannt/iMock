import Foundation

public protocol MockProviderType {
    func canHandleRequest(_ request: URLRequest) -> Bool
    func getMockResult(for request: URLRequest) -> MockResult?
}

public extension MockProviderType {
    func canHandleRequest(_ request: URLRequest) -> Bool {
        return getMockResult(for: request) != nil
    }
}
