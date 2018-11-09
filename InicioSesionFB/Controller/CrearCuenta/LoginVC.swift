//
//  LoginVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 9/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FacebookLogin
import FacebookCore
import RealmSwift

class LoginVC: UIViewController {

    
    @IBOutlet weak var botonFB: UIButton!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.frame = CGRect(x: 80, y: 320, width: 215, height: 50)
        let imagenFB = UIImage(named: "loginFB") as UIImage?
        myLoginButton.setImage(imagenFB, for: .normal)
        //myLoginButton.center = view.center;
        
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(apretarCustomFB), for: .touchUpInside)
        // Add the button to the view
        view.addSubview(myLoginButton)
        
    }
    
    @objc func apretarCustomFB() {
        let manager = LoginManager()
        
        manager.logIn(readPermissions: [.publicProfile], viewController: self) { (result) in
            switch result {
            case .success:
                
                //    self.fetchProfile()
                
                print("ENTRO FBBBB")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        // ...
                        print("ENTRO POR FB PERO HAY ERROR SING IN FIREBASE")
                        let alert = UIAlertController(title: "Primero cree una cuenta", message: "No cuenta con una cuenta registrada, por favor, cree una.", preferredStyle: UIAlertController.Style.alert)
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

                        return
                    }
                    
                    let realm = try! Realm()
                    let userID = Auth.auth().currentUser?.uid
                    
                    let infoPersona = realm.objects(Persona.self).filter("userID == %@", userID).first
                    
                    if infoPersona != nil {
                        // User is signed in'
                        print("SIGN IN CON FB")
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
                        
                        self.performSegue(withIdentifier: "signInFB", sender: self)
                        
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

                    
                    
                   

                    
                }
                
                
            case .failed(let errorCtm):
                print(errorCtm)
            case .cancelled:
                print("User cancelled login.")
            }
            
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    
    
    @IBAction func emailPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "loginEmailSegue", sender: self)
        
    }
    
}
