//
//  HeaderAlimentoTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 24/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

protocol HeaderAlimentoDelegate {
    func cambiarMeal(meal: Meal)
}


class HeaderAlimentoTableViewCell: UITableViewHeaderFooterView {

    
    var delegate: HeaderAlimentoDelegate?
    
    @IBOutlet weak var botonCambiar: UIButton!

    
    @IBOutlet weak var nombreMeal: UILabel!
    
    @IBOutlet weak var cantCal: UILabel!
    @IBOutlet weak var cantProt: UILabel!
    @IBOutlet weak var cantCarb: UILabel!
    @IBOutlet weak var cantFat: UILabel!
    @IBOutlet weak var dia: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    @IBAction func cambiarMealPressed(_ sender: Any) {

//        botonCambiar.setTitle("", for: .normal)
//        indicator.center = botonCambiar.center
//        indicator.color = UIColor.black
        botonCambiar.isHidden = true
        indicator.startAnimating()
        
        let deadlineTime = DispatchTime.now() + .seconds(2)

        let meal = Meal()
        
        meal.tipoMeal = nombreMeal.text!
        meal.cal = Double(cantCal.text!)!
        meal.prot = Double(cantProt.text!)!
        meal.fat = Double(cantFat.text!)!
        meal.carb = Double(cantCarb.text!)!
        meal.dia = dia.text!
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            print("koko")
            self.delegate?.cambiarMeal(meal: meal)
            self.botonCambiar.isHidden = false
            self.indicator.stopAnimating()
        })
        
    }
    
    
    
    
}
