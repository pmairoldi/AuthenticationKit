import XCTest
@testable import AuthenticationKit

class AccountTestsMac: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLinkedInAccountsAreEqual() {
        
        let account1 = AccountType.LinkedIn(email: "username", accessToken: "accessToken")
        let account2 = AccountType.LinkedIn(email: "username", accessToken: "accessToken")
        
        XCTAssertEqual(account1, account2, "account1: \(account1), account2: \(account2)")
    }
}
