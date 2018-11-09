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

    var window: UIWindow?

    var items = [Int]()

    
    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController!.selectedIndex = 1

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if window?.rootViewController as? UITabBarController != nil {
            let tabBarController = window!.rootViewController as! UITabBarController
            tabBarController.selectedIndex = 0
        }

        print("-------")
        print("ESTOY EN TABBARVIEWCONTROLLER")


        guard let viewControllers = viewControllers else {
            return
        }
        
            if let principalViewController = viewControllers.first as? PrincipalViewController {

                principalViewController.items = items
                print("ENTRA AL IF PRINCIPAL TABBAR")
            }

        if   let cuentalViewController = viewControllers.last as? CuentaViewController {
        print("ENTRA AL IF CUENTA TABBAR")
        }


        if   let registroViewController = viewControllers[1] as? RegistroViewController {
            print("ENTRA AL IF REGISTRO TABBAR")
        }

        if   let seguimientoViewController = viewControllers[2] as? SeguimientoViewController {
            print("ENTRA AL IF SEGUIMIENTO TABBAR")
        }

        if   let chatViewController = viewControllers[3] as? ChatViewController {
            print("ENTRA AL IF CHAT TABBAR")
        }
        
    }
    

}
