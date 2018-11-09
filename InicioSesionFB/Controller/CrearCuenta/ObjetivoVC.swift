//
//  ObjetivoVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 16/07/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class ObjetivoVC: UIViewController {
    
    var objetivo = ""
    
    
    //para ver si la dieta se ha rehecho
    var dietaRehecha = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

 

    }
    
    override func viewDidAppear(_ animated: Bool) {

    }

    
    
    @IBAction func tappedPerderPeso(_ sender: UIButton) {
        objetivo = "Perder Peso"
        performSegue(withIdentifier: "datos1Segue", sender: self)
    }
    
    @IBAction func tappedGanarPeso(_ sender: UIButton) {
        objetivo = "Ganar Peso"
        performSegue(withIdentifier: "datos1Segue", sender: self)
    }

    @IBAction func tappedMantenerPeso(_ sender: UIButton) {
        objetivo = "Mantener Peso"
        performSegue(withIdentifier: "datos1Segue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vC = segue.destination as! Datos1VC
        vC.objetivo = objetivo
        vC.dietaRehecha = self.dietaRehecha
        
        
    }
}
