//
//  RegistroViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 21/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {

    var nombreUsuario = ""
    var correoUsuario = ""
    var urlFotoUsuario = NSURL()
    
    @IBOutlet weak var nombre: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nombre.text = nombreUsuario
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
