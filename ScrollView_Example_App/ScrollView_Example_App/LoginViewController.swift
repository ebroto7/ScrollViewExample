//
//  ViewController.swift
//  ScrollView_Example_App
//
//  Created by Enric Broto Hernandez on 19/3/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

