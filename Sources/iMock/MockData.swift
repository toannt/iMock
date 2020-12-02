import Foundation

public enum MockData: MockDataConvertible {
    case file(URL)
    case string(String)
    case convertible(MockDataConvertible)
    
    public func asMockData() throws -> Data? {
        switch self {
        case .file(let url):
            return try Data(contentsOf: url)
        case .string(let value):
            return value.data(using: .utf8)
        case .convertible(let value):
            return try value.asMockData()
        }
    }
}
