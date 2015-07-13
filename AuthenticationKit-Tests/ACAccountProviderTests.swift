import XCTest
import Accounts
import Social
@testable import AuthenticationKit

class ACAccountProviderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Audience facebook extension tests
    func testFacebookEveryoneAudience() {
        
        let expected = ACFacebookAudienceEveryone
        let actual = Audience.Everyone.facebook
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testFacebookFriendsAudience() {
        
        let expected = ACFacebookAudienceFriends
        let actual = Audience.Friends.facebook
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testFacebookOnlyMeAudience() {
        
        let expected = ACFacebookAudienceOnlyMe
        let actual = Audience.OnlyMe.facebook
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    // MARK: accountIdentifier tests
    func testFacebookAccountIdentifier() {
        
        let provider = ACAccountProvider.Facebook(appId: "appID", permissions: ["email"], audience: Audience.Everyone)
        
        let expected = ACAccountTypeIdentifierFacebook
        let actual = provider.accountIdentifier
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testTwitterAccountIdentifier() {
        
        let provider = ACAccountProvider.Twitter
        
        let expected = ACAccountTypeIdentifierTwitter
        let actual = provider.accountIdentifier
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testSinaWeiboAccountIdentifier() {
        
        let provider = ACAccountProvider.SinaWeibo
        
        let expected = ACAccountTypeIdentifierSinaWeibo
        let actual = provider.accountIdentifier
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testTencentWeibooAccountIdentifier() {
        
        let provider = ACAccountProvider.TencentWeibo(appId: "")
        
        let expected = ACAccountTypeIdentifierTencentWeibo
        let actual = provider.accountIdentifier
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    // MARK: accountType tests
    func testFacebookAccountType() {
        
        let provider = ACAccountProvider.Facebook(appId: "", permissions: [], audience: Audience.Everyone)
        
        let expected: ACAccountType = ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
        let actual: ACAccountType = provider.accountType
        
        XCTAssertEqual(expected.identifier, actual.identifier, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testTwitterAccountType() {
        
        let provider = ACAccountProvider.Twitter
        
        let expected: ACAccountType = ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        let actual: ACAccountType = provider.accountType
        
        XCTAssertEqual(expected.identifier, actual.identifier, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testSinaWeiboAccountType() {
        
        let provider = ACAccountProvider.SinaWeibo
        
        let expected: ACAccountType = ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierSinaWeibo)
        let actual: ACAccountType = provider.accountType
        
        XCTAssertEqual(expected.identifier, actual.identifier, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testTencentWeibooAccountType() {
        
        let provider = ACAccountProvider.TencentWeibo(appId: "")
        
        let expected: ACAccountType = ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTencentWeibo)
        let actual: ACAccountType = provider.accountType
        
        XCTAssertEqual(expected.identifier, actual.identifier, "expected result: \(expected), actual result: \(actual)")
    }
    
    // MARK: accountOptions tests
    func testFacebookAccountOptions() {
        
        let provider = ACAccountProvider.Facebook(appId: "appID", permissions: ["email"], audience: Audience.Everyone)
        
        let expected: [NSObject : AnyObject]? = [ACFacebookAppIdKey : "appID", ACFacebookPermissionsKey : ["email"], ACFacebookAudienceKey : ACFacebookAudienceEveryone]
        let actual = provider.accountOptions
        
        XCTAssertEqualOptionalAnyDictionary(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testTwitterAccountOptions() {
        
        let provider = ACAccountProvider.Twitter
        
        let actual = provider.accountOptions
        
        XCTAssertNil(actual, "expected result: nil, actual result: \(actual)")
    }
    
    func testSinaWeiboAccountOptions() {
        
        let provider = ACAccountProvider.SinaWeibo
        
        let actual = provider.accountOptions
        
        XCTAssertNil(actual, "expected result: nil, actual result: \(actual)")
    }
    
    func testTencentWeibooAccountOptions() {
        
        let provider = ACAccountProvider.TencentWeibo(appId: "appID")
        
        let expected: [NSObject : AnyObject]? = [ACTencentWeiboAppIdKey : "appID"]
        let actual = provider.accountOptions
        
        XCTAssertEqualOptionalAnyDictionary(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    // MARK: requestAccess tests
    func testRequestAccessSuccess() {
        
        class MockAccountStore: ACAccountStore {
            override func requestAccessToAccountsWithType(accountType: ACAccountType!, options: [NSObject : AnyObject]!, completion: ACAccountStoreRequestAccessCompletionHandler!) {
                completion(true, nil)
            }
        }
        
        let ex = expectationWithDescription("ACAccountProvider Tests")
        
        let provider = ACAccountProvider.Twitter
        
        let success: () -> Void = { () -> Void in
            
            XCTAssert(true)
            ex.fulfill()
        }
        
        let failure: (error: AccountError) -> Void = { (error) -> Void in
            
            XCTFail()
            ex.fulfill()
        }
        
        provider.requestAccess(MockAccountStore(), failure: failure, success: success)
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    func testRequestAccessFailedWithoutError() {
        
        class MockAccountStore: ACAccountStore {
            override func requestAccessToAccountsWithType(accountType: ACAccountType!, options: [NSObject : AnyObject]!, completion: ACAccountStoreRequestAccessCompletionHandler!) {
                completion(false, nil)
            }
        }
        
        let ex = expectationWithDescription("ACAccountProvider Tests")
        
        let provider = ACAccountProvider.Twitter
        
        let success: () -> Void = { () -> Void in
            
            XCTFail()
            ex.fulfill()
        }
        
        let failure: (error: AccountError) -> Void = { (error) -> Void in
            
            XCTAssert(true)
            ex.fulfill()
        }
        
        provider.requestAccess(MockAccountStore(), failure: failure, success: success)
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    func testRequestAccessFailedWithError() {
        
        class MockAccountStore: ACAccountStore {
            override func requestAccessToAccountsWithType(accountType: ACAccountType!, options: [NSObject : AnyObject]!, completion: ACAccountStoreRequestAccessCompletionHandler!) {
                completion(false, NSError(domain: "test.error", code: 0, userInfo: nil))
            }
        }
        
        let ex = expectationWithDescription("ACAccountProvider Tests")
        
        let provider = ACAccountProvider.Twitter
        
        let success: () -> Void = { () -> Void in
            
            XCTFail()
            ex.fulfill()
        }
        
        let failure: (error: AccountError) -> Void = { (error) -> Void in
            
            XCTAssert(true)
            ex.fulfill()
        }
        
        provider.requestAccess(MockAccountStore(), failure: failure, success: success)
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    // MARK: map tests
    func testValidAccountConversion() {
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String?, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
        }
        
        let accounts = [MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook), username: "username", accessToken: "accessToken")]
        
        let provider = ACAccountProvider.Facebook(appId: "appID", permissions: ["email"], audience: Audience.Everyone)
        
        let expected = [Account(username: "username", accessToken: "accessToken")]
        let actual = provider.map(accounts)
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testInvalidAccountConversion() {
        
        class MockAccount: ACAccount {
            override init(accountType type: ACAccountType) {
                super.init(accountType: type)
            }
        }
        
        let accounts = [MockAccount(accountType: ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook))]
        
        let provider = ACAccountProvider.Facebook(appId: "appID", permissions: ["email"], audience: Audience.Everyone)
        
        let expected = [Account]()
        let actual = provider.map(accounts)
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    // MARK: accounts tests
    func testNoAccounts() {
        
        class MockAccountStore: ACAccountStore {
            override func accountsWithAccountType(accountType: ACAccountType!) -> [AnyObject]! {
                return nil
            }
        }
        
        let provider = ACAccountProvider.Facebook(appId: "appID", permissions: ["email"], audience: Audience.Everyone)
        
        do {
            try provider.accounts(MockAccountStore())
            
            XCTFail("should not have recieved any accounts and thrown error")
        } catch let error as AccountError {
            
            let expected = AccountError.NoAccountsFound
            let actual = error
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail("error was not of correct type")
        }
    }
    
    func testAccounts() {
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String?, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
        }
        
        class MockAccountStore: ACAccountStore {
            
            override func accountsWithAccountType(accountType: ACAccountType!) -> [AnyObject]! {
                return [MockAccount(accountType: accountType, username: "username", accessToken: "accessToken")]
            }
        }
        
        let provider = ACAccountProvider.Facebook(appId: "appID", permissions: ["email"], audience: Audience.Everyone)
        
        do {
            let expected = [Account(username: "username", accessToken: "accessToken")]
            let actual = try provider.accounts(MockAccountStore())
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail()
        }
    }
    
    // MARK: fetchAccountsClosure tests
    func testAccessGrantedAccountError() {
        
        class MockAccountStore: ACAccountStore {
            override func accountsWithAccountType(accountType: ACAccountType!) -> [AnyObject]! {
                return nil
            }
        }
        
        let provider = ACAccountProvider.Facebook(appId: "appID", permissions: ["email"], audience: Audience.Everyone)
        
        do {
            let accounts = try provider.fetchAccountsClosure(MockAccountStore())
            XCTFail("expected result: error, actual result: \(accounts)")
        } catch AccountError.NoAccountsFound {
            XCTAssert(true)
        } catch let error {
            XCTFail("expected result: AccountError.NoAccountsFound, actual result: \(error)")
        }
    }
    
    func testAccessGrantedAccountSuccess() {
        
        class MockAccount: ACAccount {
            init(accountType type: ACAccountType, username name: String?, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
        }
        
        class MockAccountStore: ACAccountStore {
            override func accountsWithAccountType(accountType: ACAccountType!) -> [AnyObject]! {
                return [MockAccount(accountType: accountType, username: "username", accessToken: "accessToken")]
            }
        }
        
        let provider = ACAccountProvider.Facebook(appId: "appID", permissions: ["email"], audience: Audience.Everyone)
        
        let expected = [Account(username: "username", accessToken: "accessToken")]
        
        do {
            let actual = try provider.fetchAccountsClosure(MockAccountStore())
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch let error {
            XCTFail("expected result: \(expected), actual result: \(error)")
        }
    }
    
    // MARK: fetchAccounts tests
    // FIX: needs to accecpt alert to succeed. Move to UI Tests
    func testFetchAccounts() {
        
//        let ex = expectationWithDescription("ACAccountProvider Tests")
//        
//        let provider = ACAccountProvider.Twitter
//        
//        let success: (accounts: [Account]) -> Void = { (accounts) -> Void in
//            XCTFail("expected result: nil, actual result: \(accounts)")
//            ex.fulfill()
//        }
//        
//        let failure: (error: AccountError) -> Void = { (error) -> Void in
//            XCTAssert(true)
//            ex.fulfill()
//        }
//        
//        provider.fetchAccounts(failure, success: success)
//        
//        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
