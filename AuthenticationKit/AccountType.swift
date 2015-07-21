import Foundation

public protocol AccountType {
    var creationRequest: NSURLRequest { get }
    var authenticationRequest: NSURLRequest { get }
}

public class TokenAccount: AccountType {
    
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

extension TokenAccount: Equatable { }

public func ==(lhs: TokenAccount, rhs: TokenAccount) -> Bool {
    
    let usernameEqual = lhs.username == rhs.username
    let accessTokenEqual = lhs.accessToken == rhs.accessToken
    
    return usernameEqual && accessTokenEqual
}

public class EmailAccount: AccountType {
    
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

extension EmailAccount: Equatable { }

public func ==(lhs: EmailAccount, rhs: EmailAccount) -> Bool {
    
    let emailEqual = lhs.email == rhs.email
    let passwordEqual = lhs.password == rhs.password
    
    return emailEqual && passwordEqual
}
