import Foundation

public let AuthenticationKitErrorDomain = "AuthenticationKit"

public enum AccountError: Int, ErrorType {
    case NoAccountsFound
    case AccessRequestFailed
    case NoAccessToken
    case CreationFailed
    case AuthenticationFailed
    
    func toNSError() -> NSError {
        return NSError(domain: AuthenticationKitErrorDomain, code: self.rawValue, userInfo: ["description" : "\(self)"])
    }
}

public enum Audience {
    case Everyone
    case Friends
    case OnlyMe
}

public protocol ProviderProtocol {
    func fetchAccounts(failure: (error: AccountError) -> Void, success: (accounts: [AccountType]) -> Void)
}