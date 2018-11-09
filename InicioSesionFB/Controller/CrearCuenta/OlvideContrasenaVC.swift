//
//  OlvideContrasenaVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 17/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import FirebaseAuth

class OlvideContrasenaVC: UIViewController {

    var correo = ""
    
    @IBOutlet weak var viewRestablecer: UIView!
    @IBOutlet weak var correoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        correoTextField.text = correo
        

    }

 
    
    @IBAction func restablecerContrasenaPressed(_ sender: UIButton) {
        let correo = correoTextField.text!

        if correo != "" {
        Auth.auth().sendPasswordReset(withEmail: correo) { error in
            // Your code here
             if error != nil {
                self.viewRestablecer.shake()
                print("ERROR RESTABLECER CONTRASENA")
                print(error!._code)
                self.handleError(error!)      // use the handleError method
                return
             } else {
                
                let alert = UIAlertController(title: "Revise su correo", message: "Siga las instrucciones en el correo enviado para cambiar su contraseña.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default p")
                        self.navigationController?.popViewController(animated: true)
                        
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }}))
                self.present(alert, animated: true, completion: nil)

                

                print("MANDO EL CORREO DE RESTABLECER")
            }
            
        }
        
        } else {
            viewRestablecer.shake()
        }
    
    }

}
