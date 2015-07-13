//
//  ACAccountProviderMacTests.swift
//  AuthenticationKit
//
//  Created by Pierre-Marc Airoldi on 2015-07-13.
//  Copyright © 2015 Pierre-Marc Airoldi. All rights reserved.
//

import XCTest
import Accounts
@testable import AuthenticationKit

class ACAccountProviderTestsMac: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: accountIdentifier tests
    func testLinkedInIdentifier() {
        
        let provider = ACAccountProvider.LinkedIn(appId: "", permissions: [])
        let expected = ACAccountTypeIdentifierLinkedIn
        let actual = provider.accountIdentifier
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    // MARK: accountOptions tests
    func testLinkedInAccountOptions() {
        
        let provider = ACAccountProvider.LinkedIn(appId: "appID", permissions: ["r_basicprofile"])
        
        let expected: [String : NSObject]? = [ACLinkedInAppIdKey : "appID", ACLinkedInPermissionsKey : ["r_basicprofile"]]
        let actual = provider.accountOptions
        
        XCTAssertEqualOptionalAnyDictionary(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
}