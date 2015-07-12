//
//  ViewController.swift
//  Example
//
//  Created by Pierre-Marc Airoldi on 2015-07-10.
//  Copyright © 2015 Pierre-Marc Airoldi. All rights reserved.
//

import UIKit
import AuthenticationKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    }

    func alert(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))

        return alert
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

