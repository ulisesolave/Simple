//
//  PruebaViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 11/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class PruebaViewController: UIViewController {

    @IBOutlet weak var labelNombreFB: UILabel!
    
    var data = ""
    var correoUsuario = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-------")
        print("ESTOY EN PRUEBAVIEWCONTROLLER")
        print("-------")
        print(data)
        print("-------")
        // Do any additional setup after loading the view.
        
      //  labelNombreFB.text = nombreUsuario
        
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
