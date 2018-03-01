//
//  ViewController.swift
//  zai
//
//  Created by Kyota Watanabe on 6/19/16.
//  Copyright © 2016 Kyota Watanabe. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.userIdText.text = TEST_USER
        self.passwordText.text = TEST_PASSWORD
    }
    
    @IBAction func pushLoginButton(_ sender: Any) {
        let userId = self.userIdText.text!
        let password = self.passwordText.text!
        
        AccountService.login(userId: userId, password: password) { (err, account) in
            DispatchQueue.main.async {
                if let e = err {
                    let errorView = createErrorModal(title: e.errorType.rawValue, message: e.message) {_ in }
                    self.present(errorView, animated: false, completion: nil)
                } else {
                    getApp().setAccount(account: account)
                    self.performSegue(withIdentifier: self.mainViewSegue, sender: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.mainViewSegue {
        }
    }
    
    @IBOutlet weak var userIdText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    fileprivate let mainViewSegue = "mainTabSegue"

}

