//
//  PrimeraVezViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 12/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class PrimeraVezViewController: UIViewController {

    //variables que jala vista ant
        var nombreUsuario = ""
        var correoUsuario = ""
        var urlFotoUsuario = NSURL()
    
    //variables nuevas
    @IBOutlet weak var fotoPerfil: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("-------")
        print("ESTOY EN PRIMERAVEZVIEWCONTROLLER")
        print("-------")
        print(nombreUsuario)
         print(correoUsuario)
         print(urlFotoUsuario)
        print("-------")
        
        nombre.text = nombreUsuario
        
       
        let url = URL(string: urlFotoUsuario.absoluteString!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.fotoPerfil.image = UIImage(data: data!)
                self.fotoPerfil.layer.cornerRadius = self.fotoPerfil.frame.size.width/2
                self.fotoPerfil.clipsToBounds = true
            }
        }
        
        
    }
    
    
    @IBAction func continuar(_ sender: UIButton) {
        
        performSegue(withIdentifier: "datos1", sender: self)
    }
    
    @IBAction func cerrarSesionFB(_ sender: UIButton) {
        print("BOTON CERRAR SESION PRIMERAVEZVIEWCONTROLLER")
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        do {
        try Auth.auth().signOut()
            performSegue(withIdentifier: "logout", sender: self)
            print("VOLVI A PANTALLA INICIAL")
        } catch {
            print("ERROR EN SALIR LOGOUT DE FIREBASE")
        }
        
        
    }
    
    
    
 


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
