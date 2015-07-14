import Foundation
import Accounts
import Social

protocol ACAccountExtension {
    
    func fetchAccountDetails() throws -> AccountType
    func preparedRequest(request: SLRequest) throws -> NSURLRequest
    func fetchAdditionalDetails(url: String) throws -> AccountType
    func fetchDefaultDetails() throws -> AccountType
}

extension ACAccount: ACAccountExtension {
    
    func fetchAccountDetails() throws -> AccountType {
    
        switch try self.serviceType() {
        case SLServiceTypeTwitter:
            return try fetchAdditionalDetails("https://api.twitter.com/1.1/account/verify_credentials.json")
        case SLServiceTypeSinaWeibo:
            return try fetchAdditionalDetails("http://api.t.sina.com.cn/account/verify_credentials.json")
        default:
            return try fetchDefaultDetails()
        }
    }
    
    func preparedRequest(request: SLRequest) throws -> NSURLRequest {
        
        guard let preparedRequest = request.preparedURLRequest() else {
            throw AccountError.NoAccessToken
        }
        
        return preparedRequest
    }
    
    func fetchAdditionalDetails(url: String) throws -> AccountType {
    
        let url = NSURL(string: url)
        let serviceType = try self.serviceType()
        
        let request = SLRequest(forServiceType: serviceType, requestMethod: .GET, URL: url, parameters: nil)
        request.account = self
        
        let accessToken = try OAuth.fetchToken(preparedRequest(request))
            
        return TokenAccountType(username: self.username, accessToken: accessToken)
    }
    
    func fetchDefaultDetails() throws -> AccountType {
    
        guard let credential = self.credential, let accessToken = credential.oauthToken else {
            throw AccountError.NoAccessToken
        }
        
        return TokenAccountType(username: self.username, accessToken: accessToken)
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