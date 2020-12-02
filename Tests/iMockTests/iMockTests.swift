import XCTest
@testable import iMock

final class iMockTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(iMock().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
