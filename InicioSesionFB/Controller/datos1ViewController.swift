//
//  datos1ViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 13/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class datos1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        //color barra
     //   navigationController?.navigationBar.barTintColor = UIColor(red: 207.0/255, green: 238.0/255, blue: 145.0/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continuar(_ sender: UIButton) {
        performSegue(withIdentifier: "datos2", sender: self)
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
