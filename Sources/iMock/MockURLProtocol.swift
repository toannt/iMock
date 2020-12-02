import Foundation

public class MockURLProtocol: URLProtocol {
    public enum MockError: Error {
        case nilMockResult(request: URLRequest)
        case mockResponseGenerationFailed(error: Error, request: URLRequest)
    }
    
    public static var provider: MockProviderType = MockProvider.shared
    private var workItem: DispatchWorkItem?
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return provider.canHandleRequest(request)
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        guard let mock = MockURLProtocol.provider.getMockResult(for: request) else {
            self.client?.urlProtocol(self, didFailWithError: MockError.nilMockResult(request: request))
            return
        }
        
        workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            switch mock.result {
            case .success(let mock):
                do {
                    if let urlResponse = try mock.response?.asMockURLResponse() {
                        self.client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
                    }
                    
                    if let data = try mock.data?.asMockData() {
                        self.client?.urlProtocol(self, didLoad: data)
                    }
                    
                    self.client?.urlProtocolDidFinishLoading(self)
                } catch {
                    self.client?.urlProtocol(self, didFailWithError: MockError.mockResponseGenerationFailed(error: error, request: self.request))
                }
            case .failure(let error):
                self.client?.urlProtocol(self, didFailWithError: error)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + mock.delay, execute: workItem!)
    }
    
    public override func stopLoading() {
        workItem?.cancel()
    }
    
    deinit {
        workItem?.cancel()
    }
}
