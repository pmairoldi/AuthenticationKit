import Foundation
import Accounts
import Result

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

    /// If you are getting a 404 error from facebook here, you need to add your application's bundle id to your app on the facebook developer site
    internal func requestAccess(store: ACAccountStore = ACAccountStore(), success: () -> Void, failure: (error: AccountError) -> Void) {
        
        store.requestAccessToAccountsWithType(accountType, options: accountOptions) { (granted, error) -> Void in

            guard let _ = error else {
                if granted {
                    success()
                } else {
                    failure(error: AccountError.AccessRequestFailed)
                }
                return
            }
            
            failure(error: AccountError.AccessRequestFailed)
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
    
    internal func fetchAccountsClosure(store: ACAccountStore = ACAccountStore()) throws -> [Account] {
        return try self.accounts(store)
    }
    
    /// MARK : ProviderProtocol Methods
    public func fetchAccounts(completion: (result: Result<[Account], AccountError>) -> Void) {
    
        let success: () -> Void = { () -> Void in
         
            do {
                let accounts = try self.fetchAccountsClosure()
                completion(result: Result.Success(accounts))
            } catch let error as AccountError {
                completion(result: Result.Failure(error))
            } catch {
                completion(result: Result.Failure(AccountError.NoAccountsFound))
            }
        }
        
        let failure: (error: AccountError) -> Void = { (error) -> Void in
            completion(result: Result.Failure(error))
        }
        
        requestAccess(success: success, failure: failure)
    }
}
