import XCTest
@testable import AuthenticationKit

class OAuthTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: fetchToken tests
    func testNoHeaders() {
        
        class MockRequest: NSURLRequest {
            override var allHTTPHeaderFields: [String : String]? {
                return nil
            }
        }
        
        do {
            try OAuth.fetchToken(MockRequest())
            XCTFail()
        } catch {
            XCTAssert(true)
        }
    }
    
    func testNoAuthorizationHeader() {
        
        class MockRequest: NSURLRequest {
            override var allHTTPHeaderFields: [String : String]? {
                return ["NoAuthorization" : "sad_face"]
            }
        }
        
        do {
            try OAuth.fetchToken(MockRequest())
            XCTFail()
        } catch {
            XCTAssert(true)
        }
    }

    func testNoOAuthToken() {
        
        class MockRequest: NSURLRequest {
            override var allHTTPHeaderFields: [String : String]? {
                return ["Authorization" : "sad_face"]
            }
        }
        
        do {
            try OAuth.fetchToken(MockRequest())
            XCTFail()
        } catch {
            XCTAssert(true)
        }
    }
    
    func testOAuthToken() {
        
        class MockRequest: NSURLRequest {
            override var allHTTPHeaderFields: [String : String]? {
                return ["Authorization" : "oauth_token\"accessToken\""]
            }
        }
        
        do {
            let expected = "accessToken"
            let actual = try OAuth.fetchToken(MockRequest())
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTAssert(true)
        }
    }
}
