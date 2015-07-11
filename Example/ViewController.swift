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
        
//        let provider = ACAccountProvider.Facebook(appId: "10153096457889200", permissions: ["email"], audience: Audience.Everyone)
        let provider = ACAccountProvider.Twitter
        
        provider.fetchAccounts { (accounts, error) -> Void in
            
            if let accounts = accounts {
                print(accounts)
            } else if let error = error {
                print(error)
            } else {
                fatalError()
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
