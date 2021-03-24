//
//  ViewController.swift
//  ScrollView_Example_App
//
//  Created by Enric Broto Hernandez on 19/3/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    var password: String = String()
    var user: String = String()
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func LoginbuttonTouched(_ sender: Any) {
        
        if let pass = passwordTextField.text {
        password = pass
        }
        print("3 - save password = \(password)")
        if let userName = userNameTextField.text {
            user = userName
        }
        print("4 - save userName = \(user)")
        
        KeychainService.savePassword(service: "pass", account: "pass", data: password)
        KeychainService.savePassword(service: "user", account: "user", data: user)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pass = KeychainService.loadPassword(service: "pass", account: "pass") {
            password = pass
        }
        passwordTextField.text = password
        print("1 - load password = \(password)")
        
        if let userName = KeychainService.loadPassword(service: "user", account: "user") {
            user = userName
        }
       
        userNameTextField.text = user
        print("2 - load userName = \(user)")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_ :)))
        //        tapGestureRecognizer.delegate = self
        //        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    
    
    
    @objc func tapGesture(_ : UITapGestureRecognizer) {
        self.view.endEditing(true)
        print("s'amaga el teclat")
    }
    
    
}

