//
//  RegisterViewController.swift
//  ScrollView_Example_App
//
//  Created by Enric Broto Hernandez on 19/3/21.
//



//GENERAR SCROLLVIEW

//1- afegir component scrollView. Ajustar contrains al marge de la pamntalla (0,0,0,0) => aqui generarem errors de constrains i els arrosegarem fins que afegim el primer component de la pantalla.
//2- obligatoriament s'afegeix una vista "contentView" on afegir tot el que necessito a la meva app. En el nostre cas, una "stackView"
//3- ¡¡¡IMPORTANT!!! afegir 5 constrains
//1ª contrain: cap a on no volem fer scroll, en el nostre cas lateralment, enllaço la "contentView" (arrosegar amb botó dret de contentView a "Frame Layout Guide") i seleccionar "equal widths"(1)
//2ª a 5ª constrain: enllaço la "contentView" (arrosegar amb botó dret de contentView a "Content Layout Guide") i seleccionar "leading"(2), "trailing"(3), "bottom"(4), "top"(5)
//4- elminiar les constants de les constrains "constant = 0" i "multiplayer = 0"
//5- afegir el primer component de la pantalla => aqui desaparexein els errors de constrains
// SCROLLVIEW OK!!

// per poder treballar més comodament podem modificar la propietat "simulated size" al botó "ShowTheSizeInspector" => això modificarà el tamany de la patalla a l'storyboard, per simular la longitud de l'scroll





import Foundation
import UIKit

class RegisterViewController: BaseViewController, UITextFieldDelegate {
    
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    
    
    
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func registerButton(_ sender: Any) {
    }
    
    @IBAction func documentIDTextfield(_ sender: UITextField) {
        //        print(sender.text)
        if let text = sender.text {
            registerButton.isEnabled = isValidID(text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.isEnabled = false
        setupDataPicker()
    
    }
    
    
    func isValidID(_ documentId: String) -> Bool {
        guard let lastChar = documentId.last else { return false }
        
        if lastChar.isLetter && documentId.count == 9 {
            var documentCopy = documentId
            documentCopy.removeLast()
            
            if let numberPart: Int = Int(documentCopy) {
                let remainder = numberPart % 23
                let calculatedLetter: String = letterConversionList[remainder]
                return calculatedLetter == String(lastChar)
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    let letterConversionList = ["T", "R", "W", "A", "G", "M", "Y", "F", "P", "D", "X", "B", "N", "J", "Z", "S", "Q", "V", "H", "L", "C", "K", "E"]
    
   
    
    func setupDataPicker() {
        
        //formate date
        datePicker.datePickerMode = .date
        datePicker.sizeToFit()
        //        let datePicker = self.dateTextField.inputView as? UIDatePicker
        datePicker.preferredDatePickerStyle = .wheels
        self.dateTextField.inputView = datePicker
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        
        toolBar.isTranslucent = true
        //      toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        dateTextField.inputAccessoryView = toolBar
        dateTextField.delegate = self
        
    }
    
    @objc  func donePressed(){
        
        //    dateTextField.inputView = datePicker
        view.endEditing(true)
        print("button done")
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        //    formatter.timeZone = .current
        
        dateTextField.text = formatter.string(from: datePicker.date)
        
    }
    @objc func cancelPressed(){
        view.endEditing(true)
        print("button cancel")
        
    }
      
    
    @objc override func keyboardWillShow(notification: NSNotification) {     //li diem la tasca que ha de realitzar quan tenim el teclat present
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        
        let newLongInset: CGFloat = self.scrollView.contentInset.bottom + keyboardFrame.height
        let insets: UIEdgeInsets = UIEdgeInsets(top: self.scrollView.contentInset.top, left: self.scrollView.contentInset.left, bottom: newLongInset, right: self.scrollView.contentInset.right)
        
        self.scrollView.contentInset = insets
        self.scrollView.scrollIndicatorInsets = insets
        
    }
    
    @objc override func keyboardWillHide(notification: NSNotification) {     //li diem la tasca que ha de realitzar quan es deixa de veure el teclat
        print("has tret el teclat")
        //
        //        guard let userInfo = notification.userInfo else { return }
        //        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        //        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        //
        //
        //        var newInset: UIEdgeInsets = scrollView.contentInset
        //        newInset.bottom = keyboardFrame.size.height
        ////        let newLongInset: CGFloat = self.scrollView.contentInset.bottom - keyboardFrame.height
        ////        let insets: UIEdgeInsets = UIEdgeInsets(top: self.scrollView.contentInset.top, left: self.scrollView.contentInset.left, bottom: newLongInset, right: self.scrollView.contentInset.right)
        //
        //        self.scrollView.contentInset = newInset
        //        self.scrollView.scrollIndicatorInsets = newInset
        
        self.scrollView.contentInset = UIEdgeInsets.zero
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        
    }
  
}

