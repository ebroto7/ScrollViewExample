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

class RegisterViewController: UIViewController {
    
    
    
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func registerButton(_ sender: Any) {
    }
    
    @IBAction func documentIDTextfield(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
