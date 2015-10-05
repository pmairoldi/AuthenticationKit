import Foundation
import Accounts
import Social

extension Audience {
    
    var facebook: String {
        switch self {
        case .Everyone:
            return ACFacebookAudienceEveryone
        case .Friends:
            return ACFacebookAudienceFriends
        case .OnlyMe:
            return ACFacebookAudienceOnlyMe
        }
    }
}

// TODO: TencentWeibo support needs testing. I am unable to get an appId
public enum ACAccountProvider {
    case Facebook(appId: String, permissions: [String], audience: Audience)
    case Twitter
    case SinaWeibo
    case TencentWeibo(appId: String)
    
    #if os(OSX)
    case LinkedIn(appId: String, permissions: [String])
    #else
    
    #endif
}

// MARK: Public Methods
extension ACAccountProvider: ProviderProtocol {
    
    // MARK: ProviderProtocol Methods
    public func fetchAccounts(failure: (error: AccountError) -> Void, success: (accounts: [AccountType]) -> Void) {
    
        let success: () -> Void = { () -> Void in
            
            do {
                let accounts = try self.fetchAccountsClosure()
                success(accounts: accounts)
            } catch let error as AccountError {
                failure(error: error)
            } catch {
               failure(error: AccountError.NoAccountsFound)
            }
        }
        
        let failure: (error: AccountError) -> Void = { (error) -> Void in
            failure(error: error)
        }
        
        requestAccess(failure: failure, success: success)
    }
}

// MARK: Private Methods
extension ACAccountProvider {
    
    var accountType: ACAccountType {
        
        return ACAccountStore().accountTypeWithAccountTypeIdentifier(accountIdentifier)
    }
    
    /// If you are getting a 404 error from facebook here, you need to add your application's bundle id to your app on the facebook developer site
    internal func requestAccess(store: ACAccountStore = ACAccountStore(), failure: (error: AccountError) -> Void, success: () -> Void) {
        
        store.requestAccessToAccountsWithType(accountType, options: accountOptions) { (granted, error) -> Void in
            
            guard let _ = error else {
                if granted {
                    success()
                } else {
                    failure(error: AccountError.AccessRequestFailed)
                }
                return
            }
            
            failure(error: AccountError.NoAccountsFound)
        }
    }
    
    internal func map(accounts: [ACAccount]) -> [AccountType] {
        
        return accounts.reduce([AccountType](), combine: { (accumulator, element) in
            
            do {
                let account = try element.fetchAccountDetails(self)
                
                var newAccumulator = accumulator
                newAccumulator.append(account)
                
                return newAccumulator
            } catch {
                return accumulator
            }
        })
    }
    
    internal func accounts(store: ACAccountStore = ACAccountStore()) throws -> [AccountType] {
        
        guard let accounts = store.accountsWithAccountType(accountType) as! [ACAccount]? where accounts.count > 0 else {
            throw AccountError.NoAccountsFound
        }
        
        return map(accounts)
    }
    
    internal func fetchAccountsClosure(store: ACAccountStore = ACAccountStore()) throws -> [AccountType] {
        return try self.accounts(store)
    }
}