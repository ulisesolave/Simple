//
//  resumenDatosViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 13/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class resumenDatosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editarDatos(_ sender: UIButton) {
        performSegue(withIdentifier: "editarDatos", sender: self)
    }
    
    @IBAction func empezar(_ sender: UIButton) {
        performSegue(withIdentifier: "empezar", sender: self)
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
