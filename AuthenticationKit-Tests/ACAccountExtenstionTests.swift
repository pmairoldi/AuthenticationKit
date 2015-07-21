import XCTest
import Accounts
import Social
@testable import AuthenticationKit

class ACAccountExtenstionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: serviceType tests
    func testFacebookServiceType() {
        
        class MockAccount: ACAccount {
            override init(accountType type: ACAccountType) {
                super.init(accountType: type)
            }
        }
        
        let indentifier = ACAccountTypeIdentifierFacebook
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(indentifier))
        
        let expected = SLServiceTypeFacebook
        
        do {
            let actual = try account.serviceType()
            XCTAssertEqualOptional(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }
    }
    
    func testTwitterServiceType() {
        
        class MockAccount: ACAccount {
            override init(accountType type: ACAccountType) {
                super.init(accountType: type)
            }
        }
        
        let indentifier = ACAccountTypeIdentifierTwitter
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(indentifier))
        
        let expected = SLServiceTypeTwitter
        
        do {
            let actual = try account.serviceType()
            XCTAssertEqualOptional(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }
    }
    
    func testSinaWeiboServiceType() {
        
        class MockAccount: ACAccount {
            override init(accountType type: ACAccountType) {
                super.init(accountType: type)
            }
        }
        
        let indentifier = ACAccountTypeIdentifierSinaWeibo
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(indentifier))
        
        let expected = SLServiceTypeSinaWeibo
        
        do {
            let actual = try account.serviceType()
            XCTAssertEqualOptional(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }
    }
    
    func testTencentWeiboServiceType() {
        
        class MockAccount: ACAccount {
            override init(accountType type: ACAccountType) {
                super.init(accountType: type)
            }
        }
        
        let indentifier = ACAccountTypeIdentifierTencentWeibo
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(indentifier))
        
        let expected = SLServiceTypeTencentWeibo
        
        do {
            let actual = try account.serviceType()
            XCTAssertEqualOptional(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }
    }
    
    func testServiceTypeUnknown() {
        
        class MockAccountType: ACAccountType {
            override var identifier: String! {
                return "unknown"
            }
        }
        
        class MockAccount: ACAccount {
            init() {
                super.init(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(""))
                self.accountType = MockAccountType()
            }
        }
        
        let account = MockAccount()
        
        do {
            try account.serviceType()
            XCTFail()
        } catch {
            XCTAssert(true)
        }
    }
    
    func testServiceTypeUnavailable() {
        
        class MockAccount: ACAccount {
            init() {
                super.init(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(""))
                self.accountType = ACAccountType()
            }
        }
        
        let account = MockAccount()
        
        do {
            try account.serviceType()
            XCTFail()
        } catch {
            XCTAssert(true)
        }
    }
    
    // MARK: fetchAccountDetails tests
    func testFetchTwitterDetails() {
        
        class MockRequest: NSURLRequest {
            override var allHTTPHeaderFields: [String : String]? {
                return ["Authorization" : "oauth_token=\"accessToken\""]
            }
        }
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
            override func preparedRequest(request: SLRequest) throws -> NSURLRequest {
                 return MockRequest()
            }
        }
        
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter), username: "username", accessToken: "accessToken")
        
        do {
            let expected = TokenAccount(username: "username", accessToken: "accessToken")
            let actual = try account.fetchAccountDetails()
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }
    }
    
    func testFetchSinaWeiboDetails() {
        
        class MockRequest: NSURLRequest {
            override var allHTTPHeaderFields: [String : String]? {
                return ["Authorization" : "oauth_token=\"accessToken\""]
            }
        }
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
            override func preparedRequest(request: SLRequest) throws -> NSURLRequest {
                return MockRequest()
            }
        }
        
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierSinaWeibo), username: "username", accessToken: "accessToken")
        
        do {
            let expected = TokenAccount(username: "username", accessToken: "accessToken")
            let actual = try account.fetchAccountDetails()
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }
    }

    func testFetchDefaultDetails() {
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
        }
        
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook), username: "username", accessToken: "accessToken")
        
        do {
            let expected = TokenAccount(username: "username", accessToken: "accessToken")
            let actual = try account.fetchAccountDetails()
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }
    }

    // MARK: preparedRequest tests
    // FIX: SLRequest can't be subclassed properly in swift might need to do objc runtime stuff to test
    func testInvalidRequest() {

//        class MockRequest: SLRequest {
//            override init() {
//                super.init()
//            }
//            override func preparedURLRequest() -> NSURLRequest! {
//                return nil
//            }
//        }
//        
//        class MockAccount: ACAccount {
//            override init(accountType type: ACAccountType) {
//                super.init(accountType: type)
//            }
//        }
//        
//        let account = ACAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook))
//        
//        do {
//            try account.preparedRequest(MockRequest())
//            XCTFail()
//        } catch {
//            XCTAssert(true)
//        }
    }

    // FIX: SLRequest can't be subclassed properly in swift might need to do objc runtime stuff to test
    func testValidRequest() {
        
//        class MockRequest: SLRequest {
//            override init() {
//                super.init()
//            }
//            override func preparedURLRequest() -> NSURLRequest! {
//                return NSURLRequest()
//            }
//        }
//        
//        class MockAccount: ACAccount {
//            override init(accountType type: ACAccountType) {
//                super.init(accountType: type)
//            }
//        }
//        
//        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook))
//        
//        do {
//            let expected = NSURLRequest()
//            let actual = try account.preparedRequest(MockRequest())
//            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
//        } catch {
//            XCTFail()
//        }
    }
    
    // MARK: fetchAdditionalDetails tests
    func testSuccessfulFetchAdditionalDetails() {
        
        class MockRequest: NSURLRequest {
            override var allHTTPHeaderFields: [String : String]? {
                return ["Authorization" : "oauth_token=\"accessToken\""]
            }
        }
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String) {
                super.init(accountType: type)
                username = name
            }
            override func preparedRequest(request: SLRequest) throws -> NSURLRequest {
                return MockRequest()
            }
        }
        
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierSinaWeibo), username: "username")
        
        do {
            let expected = TokenAccount(username: "username", accessToken: "accessToken")
            let actual = try account.fetchAdditionalDetails("")
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }
    }

    func testFailedOAuthFetchAdditionalDetails() {
        
        class MockRequest: NSURLRequest {
            override var allHTTPHeaderFields: [String : String]? {
                return nil
            }
        }
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String) {
                super.init(accountType: type)
                username = name
            }
            override func preparedRequest(request: SLRequest) throws -> NSURLRequest {
                return MockRequest()
            }
        }
        
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierSinaWeibo), username: "username")
        
        do {
            try account.fetchAdditionalDetails("")
            XCTFail()
        } catch {
            XCTAssert(true)
        }
    }
    
    // MARK: fetchDefaultDetails tests
    func testSuccessfulFetchDefaultDetails() {
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
        }
        
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook), username: "username", accessToken: "accessToken")
        
        do {
            let expected = TokenAccount(username: "username", accessToken: "accessToken")
            let actual = try account.fetchDefaultDetails()
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }

    }
 
    func testFailedFetchDefaultDetails() {
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String, accessToken token: String?) {
                super.init(accountType: type)
                username = name
            }
        }
        
        let account = MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook), username: "username", accessToken: "accessToken")
        
        do {
            try account.fetchDefaultDetails()
            XCTFail()
        } catch {
            XCTAssert(true)
        }
        
    }
}
