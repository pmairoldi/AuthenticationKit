import Foundation

public typealias AuthenticationProvierFailure = (error: AccountError) -> Void
public typealias AuthenticationProvierSuccess = (statusCode: Int, response: NSURLResponse, data: NSData?) -> Void

public class AuthenticationProvider<T: AccountType> {
    
    let account: T
    
    public init(account _account: T) {
        account = _account
    }
    
    public func createAccount(failure: AuthenticationProvierFailure, success: AuthenticationProvierSuccess) {
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
        
        let task = session.dataTaskWithRequest(account.creationRequest) { (data, response, error) -> Void in
            
            if let _ = error {
                failure(error: AccountError.CreationFailed)
                return
            }
            
            guard let response = response as? NSHTTPURLResponse else {
                failure(error: AccountError.CreationFailed)
                return
            }
            
            success(statusCode: response.statusCode, response: response, data: data)
        }
        
        task?.resume()
    }
    
    public func authenticateAccount(failure: AuthenticationProvierFailure, success: AuthenticationProvierSuccess) {
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
        
        let task = session.dataTaskWithRequest(account.authenticationRequest) { (data, response, error) -> Void in
            
            if let _ = error {
                failure(error: AccountError.AuthenticationFailed)
                return
            }
            
            guard let response = response as? NSHTTPURLResponse else {
                failure(error: AccountError.AuthenticationFailed)
                return
            }
            
            success(statusCode: response.statusCode, response: response, data: data)
        }
        
        task?.resume()
    }
}
