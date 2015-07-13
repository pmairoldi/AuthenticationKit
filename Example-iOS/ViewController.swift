import UIKit
import AuthenticationKit

class ViewController: UIViewController {
    
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