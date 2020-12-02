import Foundation

public struct MockResponse {
    public static let mockURL = URL(string: "https://response.mock")!
    
    public enum HTTPVersion: String {
        case http1_0 = "HTTP/1.0"
        case http1_1 = "HTTP/1.1"
        case http2_0 = "HTTP/2.0"
    }
    
    public let response: MockURLResponseConvertible?
    public let data: MockDataConvertible?
    
    public init(response: MockURLResponseConvertible?,
                data: MockDataConvertible?) {
        self.response = response
        self.data = data
    }
    
    public init(url: URL = MockResponse.mockURL,
                statusCode: Int = 200,
                httpVersion: HTTPVersion? = nil,
                headerFields: [String: String]? = nil,
                data: MockDataConvertible?) {
        self.init(response: HTTPURLResponse(url: url,
                                            statusCode: statusCode,
                                            httpVersion: httpVersion?.rawValue,
                                            headerFields: headerFields),
                  data: data)
    }
}
