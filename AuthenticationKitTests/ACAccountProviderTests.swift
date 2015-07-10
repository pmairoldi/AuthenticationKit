//
//  AuthenticationKitTests.swift
//  AuthenticationKitTests
//
//  Created by Pierre-Marc Airoldi on 2015-07-09.
//  Copyright © 2015 Pierre-Marc Airoldi. All rights reserved.
//

import XCTest
import Accounts
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
    
    // MARK: ACAccountProvider accountIdentifierTests
    
    func testFacebookAccountIdentifier() {
        
        let provider = ACAccountProvider.Facebook(appId: "", permissions: [], audience: Audience.Everyone)
        
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
    
    // MARK: ACAccountProvider accountType tests
    
    func testFacebookAccountType() {
        
        let provider = ACAccountProvider.Facebook(appId: "", permissions: [], audience: Audience.Everyone)
        
        let expected = ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
        let actual = provider.accountType
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testTwitterAccountType() {
        
        let provider = ACAccountProvider.Twitter
        
        let expected = ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        let actual = provider.accountType
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testSinaWeiboAccountType() {
        
        let provider = ACAccountProvider.SinaWeibo
        
        let expected = ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierSinaWeibo)
        let actual = provider.accountType
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    func testTencentWeibooAccountType() {
        
        let provider = ACAccountProvider.TencentWeibo(appId: "")
        
        let expected = ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTencentWeibo)
        let actual = provider.accountType
        
        XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    // MARK: ACAccountProvider accountOptions tests
    
    func testFacebookAccountOptions() {
        
        let provider = ACAccountProvider.Facebook(appId: "appID", permissions: ["email"], audience: Audience.Everyone)

        let expected = [ACFacebookAppIdKey : "appID", ACFacebookPermissionsKey : ["email"], ACFacebookAudienceKey : ACFacebookAudienceEveryone]
        let actual = provider.accountOptions
        
        XCTAssertEqualOptional(expected, actual, "expected result: \(expected), actual result: \(actual)")
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
    
    // TODO: Fix this test
    func testTencentWeibooAccountOptions() {
        
//        let provider = ACAccountProvider.TencentWeibo(appId: "appID")
//        
//        let expected: [NSObject : AnyObject]? = [ACTencentWeiboAppIdKey : "appID"]
//        let actual = provider.accountOptions
//        
//        XCTAssertEqualOptional(expected, actual, "expected result: \(expected), actual result: \(actual)")
    }
    
    // MARK: ACAccountProvider requestAccess tests
    
    func testRequestAccessSuccess() {
        
        class MockAccountStore: ACAccountStore {
            override func requestAccessToAccountsWithType(accountType: ACAccountType!, options: [NSObject : AnyObject]!, completion: ACAccountStoreRequestAccessCompletionHandler!) {
                completion(true, nil)
            }
        }
        
        let ex = expectationWithDescription("ACAccountProvider Tests")

        let provider = ACAccountProvider.Twitter
        
        provider.requestAccess(MockAccountStore()) { (granted) -> Void in
            
            let expected = true
            let actual = granted
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
            ex.fulfill()
        }
        
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
        
        provider.requestAccess(MockAccountStore()) { (granted) -> Void in
            
            let expected = false
            let actual = granted
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
            ex.fulfill()
        }
        
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
        
        provider.requestAccess(MockAccountStore()) { (granted) -> Void in
            
            let expected = false
            let actual = granted
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
            ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    // MARK: ACAccountProvider accounts tests
    
    func testNoAccounts() {
        
        class MockAccountStore: ACAccountStore {
            override func accountsWithAccountType(accountType: ACAccountType!) -> [AnyObject]! {
                return nil
            }
        }
        
        let provider = ACAccountProvider.Twitter

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
    
    func testAccountsAndAccessTokens() {
        
        class MockAccount: ACAccount {
            
            init!(accountType type: ACAccountType, username name: String?, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
        }
        
        class MockAccountStore: ACAccountStore {
            override func accountsWithAccountType(accountType: ACAccountType!) -> [AnyObject]! {
                
                let account = MockAccount(accountType: accountType, username: "username", accessToken: "accessToken")
                
                return [account]
            }
        }
        
        let provider = ACAccountProvider.Twitter
        
        do {
            
            let expected = [Account(userName: "username", accessToken: "accessToken")]
            let actual = try provider.accounts(MockAccountStore())
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail("should not have recieved an error")
        }
    }
    
    func testAccountsWithoutAccessTokens() {
        
        class MockAccount: ACAccount {
            
            init!(accountType type: ACAccountType, username name: String?, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
        }
        
        class MockAccountStore: ACAccountStore {
            override func accountsWithAccountType(accountType: ACAccountType!) -> [AnyObject]! {
                
                let account = MockAccount(accountType: accountType, username: "username", accessToken: nil)
                
                return [account]
            }
        }
        
        let provider = ACAccountProvider.Twitter
        
        do {
            
            let expected = [Account(userName: "username", accessToken: nil)]
            let actual = try provider.accounts(MockAccountStore())
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        } catch {
            XCTFail("should not have recieved an error")
        }
    }
    
    // MARK ACAccountProvider fetchAccountsClosure tests

    func testAccessNotGranted() {
        
        let provider = ACAccountProvider.Twitter
    
        switch provider.fetchAccountsClosure(granted: false) {
        case (let accounts, let error):
            
            if let accounts = accounts {
                XCTFail("expected result: nil, actual result: \(accounts)")
            }
            
            let expected = AccountError.AccessRequestFailed
            guard let actual = error else {
                XCTFail("expected result: \(expected), actual result: nil")
                return
            }
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        }
    }
    
    func testAccessGrantedAccountError() {
     
        class MockAccountStore: ACAccountStore {
            override func accountsWithAccountType(accountType: ACAccountType!) -> [AnyObject]! {
                
                return nil
            }
        }
        
        let provider = ACAccountProvider.Twitter
        
        switch provider.fetchAccountsClosure(MockAccountStore(), granted: true) {
        case (let accounts, let error):
            
            if let accounts = accounts {
                XCTFail("expected result: nil, actual result: \(accounts)")
            }
            
            let expected = AccountError.NoAccountsFound
            guard let actual = error else {
                XCTFail("expected result: \(expected), actual result: nil")
                return
            }
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        }
    }

    func testAccessGrantedAccountSuccess() {
        
        class MockAccount: ACAccount {
            
            init!(accountType type: ACAccountType, username name: String?, accessToken token: String?) {
                super.init(accountType: type)
                username = name
                credential = ACAccountCredential(OAuthToken: token, tokenSecret: nil)
            }
        }
        
        class MockAccountStore: ACAccountStore {
            override func accountsWithAccountType(accountType: ACAccountType!) -> [AnyObject]! {
                
                let account = MockAccount(accountType: accountType, username: "username", accessToken: "accessToken")
                
                return [account]
            }
        }
        
        let provider = ACAccountProvider.Twitter
        
        switch provider.fetchAccountsClosure(MockAccountStore(), granted: true) {
        case (let accounts, let error):
            
            if let error = error {
                XCTFail("expected result: nil, actual result: \(error)")
            }
            
            let expected = [Account(userName: "username", accessToken: "accessToken")]
            guard let actual = accounts else {
                XCTFail("expected result: \(expected), actual result: nil")
                return
            }
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
        }

    }

    // MARK: ACAccountProvider fetchAccounts tests
    
    func testFetchAccounts() {
     
        let ex = expectationWithDescription("ACAccountProvider Tests")
        
        let provider = ACAccountProvider.Twitter
        
        // TODO: test require user input
        provider.fetchAccounts { (accounts, error) -> Void in
            
            if let accounts = accounts {
                XCTFail("expected result: nil, actual result: \(accounts)")
                ex.fulfill()
                return
            }
            
            let expected = AccountError.NoAccountsFound
            
            guard let actual = error else {
                XCTFail("expected result: \(expected), actual result: nil")
                ex.fulfill()
                return
            }
            
            XCTAssertEqual(expected, actual, "expected result: \(expected), actual result: \(actual)")
            ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
