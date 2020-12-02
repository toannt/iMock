import Foundation

public protocol MockURLResponseConvertible {
    func asMockURLResponse() throws -> URLResponse?
}

extension URLResponse: MockURLResponseConvertible {
    public func asMockURLResponse() throws -> URLResponse? {
        return self
    }
}
