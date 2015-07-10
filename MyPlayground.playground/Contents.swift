import XCPlayground

import Foundation
import Social
import Accounts

XCPSetExecutionShouldContinueIndefinitely()

///                                                     ///
/// *************************************************** ///
///                                                     ///

enum Result<T, U:ErrorType> {
    case Success(T)
    case Failure(U)
}

enum AccountError: ErrorType {
    case NoAccountsFound
    case AccessRequestFailed
}

enum Audience {
    case Everyone
    case Friends
    case OnlyMe
}

extension Audience {
    
    var facebookValue: String {
        
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

enum Provider {
    case Facebook(appId: String, permissions: String, audience: Audience)
    case Twitter
    case SinaWeibo
    case TencentWeibo(appId: String)
}

extension Provider {
    
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
    
        return ACAccountStore().accountTypeWithAccountTypeIdentifier(self.accountIdentifier)
    }
    
    var accountOptions: [NSObject : AnyObject]? {
     
        switch self {
        case let .Facebook(appId, permissions, audience):
            return [ACFacebookAppIdKey : appId, ACFacebookPermissionsKey : permissions, ACFacebookAudienceKey : audience.facebookValue]
        case .Twitter:
            return nil
        case .SinaWeibo:
            return nil
        case let .TencentWeibo(appId):
            return [ACTencentWeiboAppIdKey : appId]
        }
    }
}

func accountsOfType(provider: Provider) throws -> [ACAccount] {
    
    guard let accounts = ACAccountStore().accountsWithAccountType(provider.accountType) as! [ACAccount]? else {
        throw AccountError.NoAccountsFound
    }
    
    return accounts
}

func requestAccessForAccountsOfType(provider: Provider, completion: (granted: Bool) -> Void) {
    
    ACAccountStore().requestAccessToAccountsWithType(provider.accountType, options: provider.accountOptions) { (granted, error) -> Void in
        
        if let _ = error {
            completion(granted: false)
        }
        
        else {
            completion(granted: granted)
        }
    }
}

func accessAccounts(provider: Provider, completion: (result: Result<[ACAccount], AccountError>) -> Void) {
    
    requestAccessForAccountsOfType(provider) { (granted) -> Void in
        
        guard granted else {
            completion(result: Result.Failure(AccountError.AccessRequestFailed))
            return
        }
        
        do {
            let accounts = try accountsOfType(provider)
            completion(result: Result.Success(accounts))
        } catch let error as AccountError {
            completion(result: Result.Failure(error))
        } catch {
            fatalError("Unexpected Error")
        }
    }
}

let provider = Provider.Facebook(appId: "", permissions: "", audience: Audience.Everyone)

accessAccounts(provider) { (result) -> Void in
    
    switch result {
    case .Success(let accounts):
        print(accounts)
    case .Failure(let error):
        print(error)
    }
}

struct FacebookProvider {
    let appToken: String
    let appSecret: String
}


//func me() -> SLRequest {
//    
//    let url = NSURL(string: "https://graph.facebook.com/me")!
//    
//    let request = SLRequest(forServiceType: SLServiceTypeFacebook, requestMethod: SLRequestMethod.GET, URL: url, parameters: nil)
//    
//    
//    
//}

let fb = FacebookProvider(appToken: "120448694199", appSecret: "ee75721bb6a5a5e563cb76662f2999ec")