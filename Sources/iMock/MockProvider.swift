import Foundation

public class MockProvider: MockProviderType {
    public static let shared = MockProvider()
    
    private typealias Resolver = (URLRequest) -> MockResult?
    
    private let lock = NSRecursiveLock()
    
    private var resolvers = [Resolver]()
    
    public func getMockResult(for request: URLRequest) -> MockResult? {
        lock.lock(); defer { lock.unlock() }
        
        for resolver in resolvers {
            if let result = resolver(request) {
                return result
            }
        }
        return nil
    }

    public func setMockResult(_ result: MockResult, matching: @escaping (URLRequest) -> Bool) {
        lock.lock(); defer { lock.unlock() }
        resolvers.append { request in
            if matching(request) {
                return result
            }
            return nil
        }
    }

    public func setMockResult(_ result: MockResult,
                              for target: MockTargetType) {
        setMockResult(result, matching: target.matching(with:))
    }
    
    public func setMockResponse(_ response: MockResponse,
                                delay: TimeInterval = 0,
                                for target: MockTargetType) {
        setMockResult(MockResult(result: .success(response), delay: delay), for: target)
    }
    
    public func setMockData(_ data: MockDataConvertible,
                            delay: TimeInterval = 0,
                            responseURL: URL = MockResponse.mockURL,
                            statusCode: Int = 200,
                            httpVersion: MockResponse.HTTPVersion? = nil,
                            headerFields: [String: String]? = nil,
                            for target: MockTargetType) {
        setMockResponse(MockResponse(url: responseURL,
                                     statusCode: statusCode,
                                     httpVersion: httpVersion,
                                     headerFields: headerFields,
                                     data: data),
                        delay: delay,
                        for: target)
    }
    
    public func setMockError(_ error: Error,
                             delay: TimeInterval = 0,
                             for target: MockTargetType) {
        setMockResult(MockResult(result: .failure(error), delay: delay), for: target)
    }
}
