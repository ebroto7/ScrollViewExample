//
//  ViewController.swift
//  ScrollView_Example_App
//
//  Created by Enric Broto Hernandez on 19/3/21.
//

import UIKit

class LoginViewController: BaseViewController {
    
    var password: String = String()
    var user: String = String()
  
    
    @IBOutlet weak var loginBotomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewCenterYConstraint: NSLayoutConstraint!
    var stackViewCenterYConstraintValue: CGFloat = 0
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func LoginbuttonTouched(_ sender: Any) {
        
        removeUserAndPassword()
        saveUserAndPassword()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackViewCenterYConstraintValue =  stackViewCenterYConstraint.constant - 40
        
      
        loadUserAndPassword()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_ :)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    func saveUserAndPassword() {
        
        if let pass = passwordTextField.text {
        password = pass
        }
        print("3 - save password = \(password)")
        if let userName = userNameTextField.text {
            user = userName
        }
        print("4 - save userName = \(user)")
        
        KeychainService.saveString(key: .password , data: password)
        KeychainService.saveString(key: .user, data: user)
        
    }
    
    func loadUserAndPassword() {
        
        if let pass = KeychainService.loadPassword(key: .password) {
            password = pass
        }
        passwordTextField.text = password
        print("1 - load password = \(password)")
        
        if let userName = KeychainService.loadPassword(key: .user) {
            user = userName
        }
       
        userNameTextField.text = user
        print("2 - load userName = \(user)")
    }
    
    func UpdateUserAndPassword() {
   
        
    }
    
    func removeUserAndPassword() {
        
        KeychainService.removeString(key: .password)
        KeychainService.removeString(key: .user)
        
        
    }
    
    
    @objc func tapGesture(_ : UITapGestureRecognizer) {
        self.view.endEditing(true)
        print("s'amaga el teclat")
    }
    
    
    @objc override func keyboardWillShow(notification: NSNotification) {     //li diem la tasca que ha de realitzar quan tenim el teclat present
        super.keyboardWillShow(notification: notification)                  //li demananem a la funció keybordWillShow que estem sobreeescribint (override) que tambe volem implementar el que pasi a la "clase pare" de la que hereda (igual que pasa al viewDidLoad) => en aquest cas printariem print("show keysboard from baseVC")
        
        
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        

        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
                let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
                let animationCurve = UInt(exactly: curve) ?? 0
                let durationInterval = TimeInterval(exactly: duration) ?? 0.5
                UIView.animate(withDuration: durationInterval,
                               delay: 0,
                               options: [UIView.AnimationOptions(rawValue: animationCurve)],
                               animations: {
                                self.loginBotomConstraint.constant = keyboardFrame.height + 10 //modifiquem l'alçada de la constraint inferior del botó "login"
                                self.stackViewCenterYConstraint.constant = self.stackViewCenterYConstraintValue
                                self.view.layoutIfNeeded()
                }, completion: nil)
       
    }

    @objc override func keyboardWillHide(notification: NSNotification) {     //li diem la tasca que ha de realitzar quan es deixa de veure el teclat
 
        guard let userInfo = notification.userInfo else { return }
        
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
                let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
                let animationCurve = UInt(exactly: curve) ?? 0
                let durationInterval = TimeInterval(exactly: duration) ?? 0.5
                UIView.animate(withDuration: durationInterval,
                               delay: 0,
                               options: [UIView.AnimationOptions(rawValue: animationCurve)],
                               animations: {
                                self.loginBotomConstraint.constant = 50
                                self.stackViewCenterYConstraint.constant = 0
                                self.view.layoutIfNeeded()
                }, completion: nil)
        
    }
}
