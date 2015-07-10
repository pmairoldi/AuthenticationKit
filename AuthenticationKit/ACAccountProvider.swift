import Foundation
import Accounts

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

public enum ACAccountProvider {
    case Facebook(appId: String, permissions: [String], audience: Audience)
    case Twitter
    case SinaWeibo
    case TencentWeibo(appId: String)
}

extension ACAccountProvider: ProviderProtocol {
    
    var accountIdentifier: String {
        
        switch self {
        case .Facebook:
            return ACAccountTypeIdentifierFacebook
        case .Twitter:
            return ACAccountTypeIdentifierTwitter
        case .SinaWeibo:
            return ACAccountTypeIdentifierSinaWeibo
        case .TencentWeibo:
            return ACAccountTypeIdentifierTencentWeibo
        }
    }
    
    var accountType: ACAccountType {
        
        return ACAccountStore().accountTypeWithAccountTypeIdentifier(accountIdentifier)
    }
    
    var accountOptions: [NSObject : AnyObject]? {
        
        switch self {
        case let .Facebook(appId, permissions, audience):
            return [ACFacebookAppIdKey : appId, ACFacebookPermissionsKey : permissions, ACFacebookAudienceKey : audience.facebook]
        case .Twitter:
            return nil
        case .SinaWeibo:
            return nil
        case let .TencentWeibo(appId):
            return [ACTencentWeiboAppIdKey : appId]
        }
    }
    
    internal func requestAccess(store: ACAccountStore = ACAccountStore(), completion: (granted: Bool) -> Void) {
        
        store.requestAccessToAccountsWithType(accountType, options: accountOptions) { (granted, error) -> Void in
            
            if let _ = error {
                /// If you are getting a 404 error from facebook here, you need to add your application's bundle id to your app on the facebook developer site
                completion(granted: false)
            }
                
            else {
                completion(granted: granted)
            }
        }
    }
    
    internal func accounts(store: ACAccountStore = ACAccountStore()) throws -> [Account] {
        
        guard let accounts = store.accountsWithAccountType(accountType) as! [ACAccount]? else {
            throw AccountError.NoAccountsFound
        }
        
        /// TODO: does it make sense to return an account without an access token??
        return accounts.map({ (element) -> Account in
            
            guard let credential = element.credential else {
                return Account(userName: element.username, accessToken: nil)
            }
            
            guard let accessToken = credential.oauthToken else {
                return Account(userName: element.username, accessToken: nil)
            }
            
            return Account(userName: element.username, accessToken: accessToken)
        })
    }
    
    internal func fetchAccountsClosure(store: ACAccountStore = ACAccountStore(), granted: Bool) -> (accounts: [Account]?, error: AccountError?) {
        
        guard granted else {
            return (accounts: nil, error: AccountError.AccessRequestFailed)
        }
        
        do {
            let accounts = try self.accounts(store)
            return (accounts: accounts, error: nil)
        } catch let error as AccountError {
            return (accounts: nil, error: error)
        } catch {
            // TODO: find way to remove this
            return (accounts: nil, error: AccountError.NoAccountsFound)
        }
    }
    
    /// MARK : ProviderProtocol Methods
    public func fetchAccounts(completion: (accounts: [Account]?, error: AccountError?) -> Void) {
        
        requestAccess { (granted) -> Void in
            completion(self.fetchAccountsClosure(granted: granted))
        }
    }
}
