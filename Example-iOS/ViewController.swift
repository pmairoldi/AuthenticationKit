import UIKit
import AuthenticationKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let email = EmailAccount(email: "pm@mail.com", password: "1234")
        
        let auth = AuthenticationProvider(account: email)
        
        let failure: AuthenticationProvierFailure = { (error) -> Void in
            print(error)
        }
        
        let success: AuthenticationProvierSuccess = { (statusCode, response, data) -> Void in
            print(data)
            print(statusCode)
            print(response)
        }
        
        auth.authenticateAccount(failure, success: success)
        
//        let success: (accounts: [AccountType]) -> Void = { (accounts) -> Void in
//            print(accounts)
//        }
//        
//        let failure: (error: AccountError) -> Void = { (error) -> Void in
//            print(error)
//        }
//        
//        let twitter = ACAccountProvider.Twitter
//        
//        twitter.fetchAccounts(failure, success: success)
        
//        let facebook = ACAccountProvider.Facebook(appId: "10153096457889200", permissions: ["email"], audience: Audience.Everyone)
//        
//        facebook.fetchAccounts(failure, success: success)
//        
//        let sinaWeibo = ACAccountProvider.SinaWeibo
//        
//        sinaWeibo.fetchAccounts(failure, success: success)
//        
//        let tencentWeibo = ACAccountProvider.TencentWeibo(appId: "")
//        
//        tencentWeibo.fetchAccounts(failure, success: success)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class EmailAccount: EmailAccountType {
    
    override var authenticationRequest: NSURLRequest {
        return NSURLRequest(URL: NSURL(string: "https://google.com")!)
    }
}