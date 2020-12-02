import Foundation

public struct MockResult {
    public let result: Result<MockResponse, Error>
    public let delay: TimeInterval

    public init(result: Result<MockResponse, Error>, delay: TimeInterval = 0) {
        self.result = result
        self.delay = delay
    }
}
