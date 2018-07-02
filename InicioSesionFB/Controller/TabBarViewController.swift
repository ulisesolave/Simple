//
//  TabBarViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 10/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import Foundation
import UIKit


class TabBarViewController: UITabBarController {
    var nombreUsuario = ""
    var correoUsuario = ""
    var urlFotoUsuario = NSURL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        

        print("-------")
        print("ESTOY EN TABBARVIEWCONTROLLER")
        print("-------")
        print(nombreUsuario)
        print("-------")
        // Do any additional setup after loading the view.
        
        
        guard let viewControllers = viewControllers else {
            return
        }
        
            if let principalViewController = viewControllers.first as? PrincipalViewController {
                principalViewController.nombreUsuario = self.nombreUsuario
                print("ENTRA AL IF PRINCIPAL TABBAR")
            }
        
        if   let cuentalViewController = viewControllers.last as? CuentaViewController {
        print("ENTRA AL IF CUENTA TABBAR")
        cuentalViewController.nombreUsuario = self.nombreUsuario
        }
        
        
        if   let registroViewController = viewControllers[1] as? RegistroViewController {
            print("ENTRA AL IF REGISTRO TABBAR")
            registroViewController.nombreUsuario = self.nombreUsuario
        }
        
        if   let chatViewController = viewControllers[3] as? ChatViewController {
            print("ENTRA AL IF REGISTRO TABBAR")
            chatViewController.nombreUsuario = self.nombreUsuario
            chatViewController.urlFotoUsuario = self.urlFotoUsuario
        }
        
        
      //  let secondDes = barViewControllers.viewControllers?[1] as! SecondViewController
        //secondDes.test = "Hello TabBar 2"
        
        
        
        
    }
    

}
