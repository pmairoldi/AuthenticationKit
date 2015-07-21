import Cocoa
import AuthenticationKit

// TODO: Fix example. Should work in theory
class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let success: (accounts: [AccountType]) -> Void = { (accounts) -> Void in
            print(accounts)
        }
        
        let failure: (error: AccountError) -> Void = { (error) -> Void in
            print(error)
        }
        
        let twitter = ACAccountProvider.Twitter
        
        twitter.fetchAccounts(failure, success: success)
        
        let facebook = ACAccountProvider.Facebook(appId: "10153096457889200", permissions: ["email"], audience: Audience.Everyone)
        
        facebook.fetchAccounts(failure, success: success)
        
        let sinaWeibo = ACAccountProvider.SinaWeibo
        
        sinaWeibo.fetchAccounts(failure, success: success)
        
        let tencentWeibo = ACAccountProvider.TencentWeibo(appId: "")
        
        tencentWeibo.fetchAccounts(failure, success: success)
        
        let linkedIn = ACAccountProvider.LinkedIn(appId: "77fe3jliohtjrz", permissions: ["r_basicprofile"])
    
        linkedIn.fetchAccounts(failure, success: success)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

