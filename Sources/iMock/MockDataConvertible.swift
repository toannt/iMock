import Foundation

public protocol MockDataConvertible {
    func asMockData() throws -> Data?
}

public extension MockDataConvertible where Self: Encodable {
    func asMockData() throws -> Data? {
        return try JSONEncoder().encode(self)
    }
}

public extension MockDataConvertible where Self: NSCoding {
    func asMockData() throws -> Data? {
        if #available(iOS 11, *) {
            return try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        }
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}

extension Data: MockDataConvertible {
    public func asMockData() throws -> Data? {
        return self
    }
}
