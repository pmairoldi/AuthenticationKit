import XCTest
@testable import AuthenticationKit

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmailAccountsAreEqual() {
        
        let account1 = AccountType.Email(email: "email", password: "password")
        let account2 = AccountType.Email(email: "email", password: "password")
        
        XCTAssertEqual(account1, account2, "account1: \(account1), account2: \(account2)")
    }
    
    func testFacebookAccountsAreEqual() {
        
        let account1 = AccountType.Facebook(email: "email", accessToken: "accessToken")
        let account2 = AccountType.Facebook(email: "email", accessToken: "accessToken")

        XCTAssertEqual(account1, account2, "account1: \(account1), account2: \(account2)")
    }
    
    func testTwitterAccountsAreEqual() {
        
        let account1 = AccountType.Twitter(username: "username", accessToken: "accessToken")
        let account2 = AccountType.Twitter(username: "username", accessToken: "accessToken")
        
        XCTAssertEqual(account1, account2, "account1: \(account1), account2: \(account2)")
    }
    
    func testSinaWeiboAccountsAreEqual() {
        
        let account1 = AccountType.SinaWeibo(email: "email", accessToken: "accessToken")
        let account2 = AccountType.SinaWeibo(email: "email", accessToken: "accessToken")
        
        XCTAssertEqual(account1, account2, "account1: \(account1), account2: \(account2)")
    }
    
    func testTencentWeiboAccountsAreEqual() {
        
        let account1 = AccountType.TencentWeibo(email: "email", accessToken: "accessToken")
        let account2 = AccountType.TencentWeibo(email: "email", accessToken: "accessToken")
        
        XCTAssertEqual(account1, account2, "account1: \(account1), account2: \(account2)")
    }
    
    func testAccountsAreNotEqual() {
        
        let account1 = AccountType.Facebook(email: "email", accessToken: "accessToken")
        let account2 = AccountType.Facebook(email: "email", accessToken: "")
        
        XCTAssertNotEqual(account1, account2, "account1: \(account1), account2: \(account2)")
    }
}
