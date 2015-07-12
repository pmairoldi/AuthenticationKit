import Foundation
import Result

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

public struct Account {
    
    let username: String
    let accessToken: String?
}

extension Account: Equatable { }

public func ==(lhs: Account, rhs: Account) -> Bool {
    
    let userNameEqual = lhs.username == rhs.username
    let accessTokenEqual = lhs.accessToken == rhs.accessToken
    
    return userNameEqual && accessTokenEqual
}

public protocol ProviderProtocol {
    
    func fetchAccounts(completion: (result: Result<[Account], AccountError>) -> Void)
}