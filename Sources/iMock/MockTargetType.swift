import Foundation

public protocol MockTargetType {
    func matching(with request: URLRequest) -> Bool
}

extension URL: MockTargetType {
    public func matching(with request: URLRequest) -> Bool {
        return request.url == self
    }
}

extension URLRequest: MockTargetType {
    public func matching(with request: URLRequest) -> Bool {
        return request == self
    }
}

extension String: MockTargetType {
    public func matching(with request: URLRequest) -> Bool {
        return request.url?.absoluteString == self
    }
}
