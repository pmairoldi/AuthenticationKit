import Cocoa
import AuthenticationKit

// TODO: Fix example. Should work in theory
class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let twitter = ACAccountProvider.Twitter
        
        twitter.fetchAccounts { (result) -> Void in
            
            switch result {
            case .Success(let accounts):
                print(accounts)
            case .Failure(let error):
                print(error)
            }
        }
        
        let facebook = ACAccountProvider.Facebook(appId: "10153096457889200", permissions: ["email"], audience: Audience.Everyone)
        
        facebook.fetchAccounts { (result) -> Void in
            
            switch result {
            case .Success(let accounts):
                print(accounts)
            case .Failure(let error):
                print(error)
            }
        }

        let sinaWeibo = ACAccountProvider.SinaWeibo
        
        sinaWeibo.fetchAccounts { (result) -> Void in
            
            switch result {
            case .Success(let accounts):
                print(accounts)
            case .Failure(let error):
                print(error)
            }
        }
        
        let tencentWeibo = ACAccountProvider.TencentWeibo(appId: "")
        
        tencentWeibo.fetchAccounts { (result) -> Void in
            
            switch result {
            case .Success(let accounts):
                print(accounts)
            case .Failure(let error):
                print(error)
            }
        }
        
        let linkedIn = ACAccountProvider.LinkedIn(appId: "77fe3jliohtjrz", permissions: ["r_basicprofile"])
        
        linkedIn.fetchAccounts { (result) -> Void in
            
            switch result {
            case .Success(let accounts):
                print(accounts)
            case .Failure(let error):
                print(error)
            }
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

