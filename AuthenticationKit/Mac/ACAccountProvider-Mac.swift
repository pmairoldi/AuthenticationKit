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

extension ACAccount {
    
    func accountForProvider(provider: ACAccountProvider, username: String, accessToken: String) -> AccountType {
        
        switch provider {
        case .Facebook:
            return AccountType.Facebook(email: username, accessToken: accessToken)
        case .Twitter:
            return AccountType.Twitter(username: username, accessToken: accessToken)
        case .SinaWeibo:
            return AccountType.SinaWeibo(email: username, accessToken: accessToken)
        case .TencentWeibo:
            return AccountType.TencentWeibo(email: username, accessToken: accessToken)
        case .LinkedIn:
            return AccountType.LinkedIn(email: username, accessToken: accessToken)
        }
    }
}

extension AccountType: Equatable { }
public func ==(lhs: AccountType, rhs: AccountType) -> Bool {
    
    switch (lhs, rhs) {
    case let (.Email(a, b), .Email(c, d)) where a == c && b == d:
        return true
    case let (.Facebook(a, b), .Facebook(c, d)) where a == c && b == d:
        return true
    case let (.Twitter(a, b), .Twitter(c, d)) where a == c && b == d:
        return true
    case let (.SinaWeibo(a, b), .SinaWeibo(c, d)) where a == c && b == d:
        return true
    case let (.TencentWeibo(a, b), .TencentWeibo(c, d)) where a == c && b == d:
        return true
    case let (.LinkedIn(a, b), .LinkedIn(c, d)) where a == c && b == d:
        return true
    default:
        return false
    }
}
