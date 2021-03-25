//
//  BaseViewController.swift
//  ScrollView_Example_App
//
//  Created by Enric Broto Hernandez on 25/3/21.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
    }
    
    deinit {
        removeKeyBoardNotifications()
    }
    
    
    func registerKeyboardNotifications() {      // escoltem si el teclat està present o no
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyBoardNotifications() {        //deixem d'escoltar les notificacions "si el teclat apareix o despareix"
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //funcions per implementar a la classe filla
    @objc func keyboardWillShow(notification: NSNotification) {
        print("show keysboard from baseVC")
    }
    @objc func keyboardWillHide(notification: NSNotification) {}
    
}
