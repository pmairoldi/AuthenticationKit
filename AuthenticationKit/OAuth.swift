import Foundation

public struct OAuth {
    
    public static func fetchToken(request: NSURLRequest) throws -> String {
        
        guard let headers = request.allHTTPHeaderFields else {
            throw AccountError.NoAccessToken
        }
        
        guard  let authorization = headers["Authorization"] else {
            throw AccountError.NoAccessToken
        }
        
        guard let range = authorization.rangeOfString("oauth_token=\".*?\"", options: .RegularExpressionSearch) else {
            throw AccountError.NoAccessToken
        }
        
        let accessToken = authorization.substringWithRange(range).stringByReplacingOccurrencesOfString("oauth_token=", withString: "").stringByReplacingOccurrencesOfString("\"", withString: "")
        
        return accessToken
    }
}