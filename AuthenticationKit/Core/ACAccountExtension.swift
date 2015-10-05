import Foundation
import Accounts
import Social

protocol ACAccountExtension {
    
    func fetchAccountDetails(provider: ACAccountProvider) throws -> AccountType
    func preparedRequest(request: SLRequest) throws -> NSURLRequest
    func fetchAdditionalDetails(provider: ACAccountProvider, url: String) throws -> AccountType
    func fetchDefaultDetails(provider: ACAccountProvider) throws -> AccountType
}

extension ACAccount: ACAccountExtension {
    
    func fetchAccountDetails(provider: ACAccountProvider) throws -> AccountType {
    
        switch try self.serviceType() {
        case SLServiceTypeTwitter:
            return try fetchAdditionalDetails(provider, url: "https://api.twitter.com/1.1/account/verify_credentials.json")
        case SLServiceTypeSinaWeibo:
            return try fetchAdditionalDetails(provider, url: "http://api.t.sina.com.cn/account/verify_credentials.json")
        default:
            return try fetchDefaultDetails(provider)
        }
    }
    
    func preparedRequest(request: SLRequest) throws -> NSURLRequest {
        
        guard let preparedRequest = request.preparedURLRequest() else {
            throw AccountError.NoAccessToken
        }
        
        return preparedRequest
    }
    
    func fetchAdditionalDetails(provider: ACAccountProvider, url: String) throws -> AccountType {
    
        let url = NSURL(string: url)
        let serviceType = try self.serviceType()
        
        let request = SLRequest(forServiceType: serviceType, requestMethod: .GET, URL: url, parameters: nil)
        request.account = self
        
        let accessToken = try OAuth.fetchToken(preparedRequest(request))
            
        return accountForProvider(provider, username: self.username, accessToken: accessToken)
    }
    
    func fetchDefaultDetails(provider: ACAccountProvider) throws -> AccountType {
    
        guard let credential = self.credential, let accessToken = credential.oauthToken else {
            throw AccountError.NoAccessToken
        }
        
        return accountForProvider(provider, username: self.username, accessToken: accessToken)
    }
}

extension ACAccount {
    
    func serviceType(store:ACAccountStore = ACAccountStore()) throws -> String {
        
        guard let accountIdentifier = self.accountType.identifier else {
            throw AccountError.NoAccountsFound
        }
        
        switch accountIdentifier {
        case store.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook).identifier:
            return SLServiceTypeFacebook
        case store.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter).identifier:
            return SLServiceTypeTwitter
        case store.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierSinaWeibo).identifier:
            return SLServiceTypeSinaWeibo
        case store.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTencentWeibo).identifier:
            return SLServiceTypeTencentWeibo
        default:
            throw AccountError.NoAccountsFound
        }
    }
}