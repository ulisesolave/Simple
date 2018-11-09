//
//  LoginEmailVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 9/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class LoginEmailVC: UIViewController {

 
    @IBOutlet weak var viewCorreoContrasena: UIView!
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var contrasena: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contrasena.resignFirstResponder()
        correo.resignFirstResponder()
        
    }
    
    
    @IBAction func entrarPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: correo.text!, password: contrasena.text!) { (user, error) in
         
            if let u = user {
                
                let realm = try! Realm()
                let userID = Auth.auth().currentUser?.uid
                
                let infoPersona = realm.objects(Persona.self).filter("userID == %@", userID).first

                if infoPersona != nil {
                    
                    //poner sesion a usuario
                    let s = Sesion()
                    s.userID = userID!
                    let ses = realm.objects(Sesion.self).first
                    
                    if ses == nil {
                        do {
                            try realm.write {
                                realm.add(s)
                            }
                        } catch {
                            print("ERROR REALM")
                            print(error)
                        }
                    } else {
                        do {
                            try realm.write {
                                ses?.userID = userID!
                            }
                        } catch {
                            print("ERROR REALM")
                            print(error)
                        }
                    }
                    
                    
                    
                    self.performSegue(withIdentifier: "empezarSegue", sender: self)
                    
                    
                } else {
                    
                    let alert = UIAlertController(title: "No se encontraron datos", message: "No se encontraron datos en este equipo, será redirigido a crear una cuenta.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default p")
                            //BORRAR DE FIREBASE
                            let user = Auth.auth().currentUser
                            
                            user?.delete { error in
                                if let error = error {
                                    // An error happened.
                                    print("ERROR BORRAR USUARIO DE FIREBASE")
                                } else {
                                    // Account deleted.
                                    print("USUARIO BORRADO DE FIREBASE")
                                }
                            }
                            //MANDAR A CREAR CUENTA
                            self.performSegue(withIdentifier: "nuevaCuentaSegue", sender: self)
                        case .cancel:
                            print("cancel")
                        case .destructive:
                            print("destructive")
                        }}))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                

                
            } else if error != nil {
                print("ERROR LOGIN USUARIO EMAIL")
                self.viewCorreoContrasena.shake()
                print(error!._code)
                self.handleError(error!)      // use the handleError method
                return
            }
        }
        
    }
    
    
    @IBAction func olvideContrasenaPressed(_ sender: UIButton) {
    
        performSegue(withIdentifier: "olvideContrasenaSegue", sender: self)
    }
    
    @IBAction func crearCuentaSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "nuevaCuentaSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "olvideContrasenaSegue") {
            
            var vc = segue.destination as! OlvideContrasenaVC
            vc.correo = correo.text!
            
        }
    }
    
}





