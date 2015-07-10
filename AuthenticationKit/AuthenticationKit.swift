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

public struct Account {
    
    let userName: String
    let accessToken: String?
}

extension Account: Equatable { }

public func ==(lhs: Account, rhs: Account) -> Bool {
    
    let userNameEqual = lhs.userName == rhs.userName
    
    if let lhsAccessToken = lhs.accessToken, let rhsAccessToken = rhs.accessToken {
        
        if lhsAccessToken == rhsAccessToken {
            return userNameEqual
        } else {
            return false
        }
    } else if let _ = lhs.accessToken {
        return false
    } else if let _ = rhs.accessToken {
        return false
    } else {
        return userNameEqual
    }
}

public protocol ProviderProtocol {
    
    func fetchAccounts(completion: (accounts: [Account]?, error: AccountError?) -> Void)
}