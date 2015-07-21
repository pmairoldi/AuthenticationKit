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
    
    func testEqualAccountsFunction() {
        
        let account1 = TokenAccount(username: "username", accessToken: "accessToken")
        let account2 = TokenAccount(username: "username", accessToken: "accessToken")
        
        let result = account1 == account2
        
        XCTAssert(result, "account1: \(account1), account2: \(account2)")
    }
    
    func testAccountsAreEqual() {
        
        let account1 = TokenAccount(username: "username", accessToken: "accessToken")
        let account2 = TokenAccount(username: "username", accessToken: "accessToken")

        XCTAssertEqual(account1, account2, "account1: \(account1), account2: \(account2)")
    }
    
    func testAccountsAreNotEqual() {
        
        let account1 = TokenAccount(username: "username", accessToken: "accessToken")
        let account2 = TokenAccount(username: "username", accessToken: "")
        
        XCTAssertNotEqual(account1, account2, "account1: \(account1), account2: \(account2)")
    }
}
