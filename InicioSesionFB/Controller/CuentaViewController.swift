//
//  CuentaViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 20/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase


class CuentaViewController: UIViewController {

    var nombreUsuario = ""
    var correoUsuario = ""
    var urlFotoUsuario = NSURL()
    
    @IBOutlet weak var nombreCuenta: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nombreCuenta.text = nombreUsuario
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func cerrarSesion(_ sender: UIButton) {
        print("BOTON CERRAR SESION")
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let fechaCreacionFirebase = Auth.auth().currentUser?.metadata.creationDate

//        do {
//            try Auth.auth().signOut()
//            performSegue(withIdentifier: "cuentaLogout", sender: self)
//            print("VOLVI A PANTALLA INICIAL")
//        } catch {
//            print("ERROR EN SALIR LOGOUT DE FIREBASE")
//        }
                  performSegue(withIdentifier: "cuentaLogout", sender: self)
                print("VOLVI A PANTALLA INICIAL")
             print("BOTON CERRAR SESION FECHA DE CREACION EN FIREBASE ES")
        print(fechaCreacionFirebase)
    }

        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
