import Foundation

public enum AccountError: ErrorType {
    case NoAccountsFound
    case AccessRequestFailed
    case NoAccessToken
    case CreationFailed
    case AuthenticationFailed
}

public enum Audience {
    case Everyone
    case Friends
    case OnlyMe
}

public protocol ProviderProtocol {
    func fetchAccounts(failure: (error: AccountError) -> Void, success: (accounts: [AccountType]) -> Void)
}