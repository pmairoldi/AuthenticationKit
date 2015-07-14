import Foundation

public protocol AccountType {
    var creationRequest: NSURLRequest { get }
    var authenticationRequest: NSURLRequest { get }
}

public class TokenAccountType: AccountType {
    
    let username: String
    let accessToken: String
    
    public init(username _username: String, accessToken _accessToken: String) {
        username = _username
        accessToken = _accessToken
    }
    
    public var creationRequest: NSURLRequest {
        fatalError("Must subclass and return a request")
    }
    
    public var authenticationRequest: NSURLRequest {
        fatalError("Must subclass and return a request")
    }
}

extension TokenAccountType: Equatable { }

public func ==(lhs: TokenAccountType, rhs: TokenAccountType) -> Bool {
    
    let usernameEqual = lhs.username == rhs.username
    let accessTokenEqual = lhs.accessToken == rhs.accessToken
    
    return usernameEqual && accessTokenEqual
}

public class EmailAccountType: AccountType {
    
    let email: String
    let password: String
    
    public init(email _email: String, password _password: String) {
        email = _email
        password = _email
    }
    
    public var creationRequest: NSURLRequest {
        fatalError("Must subclass and return a request")
    }
    
    public var authenticationRequest: NSURLRequest {
        fatalError("Must subclass and return a request")
    }
}

extension EmailAccountType: Equatable { }

public func ==(lhs: EmailAccountType, rhs: EmailAccountType) -> Bool {
    
    let emailEqual = lhs.email == rhs.email
    let passwordEqual = lhs.password == rhs.password
    
    return emailEqual && passwordEqual
}
