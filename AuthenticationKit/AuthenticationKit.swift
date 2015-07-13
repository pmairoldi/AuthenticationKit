import Foundation

public enum AccountError: ErrorType {
    case NoAccountsFound
    case AccessRequestFailed
    case NoAccessToken
}

public enum Audience {
    case Everyone
    case Friends
    case OnlyMe
}

public protocol AccountType {
    func creationRequest() throws -> NSURLRequest
    func authenticationRequest() throws -> NSURLRequest
}

public struct Account: AccountType {
    
    let username: String
    let accessToken: String
    
    public func creationRequest() throws -> NSURLRequest {
        return NSURLRequest()
    }
    
    public func authenticationRequest() throws -> NSURLRequest {
        return NSURLRequest()
    }
}

extension Account: Equatable { }

public func ==(lhs: Account, rhs: Account) -> Bool {
    
    let userNameEqual = lhs.username == rhs.username
    let accessTokenEqual = lhs.accessToken == rhs.accessToken
    
    return userNameEqual && accessTokenEqual
}

public protocol ProviderProtocol {
    func fetchAccounts(failure: (error: AccountError) -> Void, success: (accounts: [AccountType]) -> Void)
}