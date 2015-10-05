import Foundation

//public protocol AccountProtocol {
//    var creationRequest: NSURLRequest { get }
//    var authenticationRequest: NSURLRequest { get }
//}

public enum AccountType {
    case Email(email: String, password: String)
    case Facebook(email: String, accessToken: String)
    case Twitter(username: String, accessToken: String)
    case SinaWeibo(email: String, accessToken: String)
    case TencentWeibo(email: String, accessToken: String)

    #if os(OSX)
    case LinkedIn(email: String, accessToken: String)
    #else
    
    #endif
//    public var creationRequest: NSURLRequest {
//        fatalError("Must subclass and return a request")
//    }
//    
//    public var authenticationRequest: NSURLRequest {
//        fatalError("Must subclass and return a request")
//    }
}
