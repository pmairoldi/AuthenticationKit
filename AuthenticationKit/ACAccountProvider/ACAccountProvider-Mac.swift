import Foundation
import Accounts

// MARK: Private Methods
extension ACAccountProvider {
    
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
        case .LinkedIn:
            return ACAccountTypeIdentifierLinkedIn
        }
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
        case let .LinkedIn(appId, permissions):
            return [ACLinkedInAppIdKey : appId, ACLinkedInPermissionsKey: permissions]
        }
    }
}