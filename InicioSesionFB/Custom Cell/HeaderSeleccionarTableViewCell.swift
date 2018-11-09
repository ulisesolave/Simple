//
//  HeaderSeleccionarTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 15/09/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

protocol HeaderSeleccionarDelegate {
    func agregarItemAMeal(meal: Meal)
}


class HeaderSeleccionarTableViewCell: UITableViewHeaderFooterView {
    
    var delegate: HeaderSeleccionarDelegate?

    
    @IBOutlet weak var nombreMeal: UILabel!
    @IBOutlet weak var cantCal: UILabel!
    @IBOutlet weak var cantProt: UILabel!
    @IBOutlet weak var cantCarb: UILabel!
    @IBOutlet weak var cantFat: UILabel!
    @IBOutlet weak var dia: UILabel!
    @IBOutlet weak var id: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    @IBAction func agregarAlimento(_ sender: Any) {

        let meal = Meal()
        meal.id = Int(id.text!)!
//        meal.tipoMeal = nombreMeal.text!
//        meal.cal = Double(cantCal.text!)!
//        meal.prot = Double(cantProt.text!)!
//        meal.fat = Double(cantFat.text!)!
//        meal.carb = Double(cantCarb.text!)!
//        meal.dia = dia.text!
        
        delegate?.agregarItemAMeal(meal: meal)
        
        
    }
    
    
    
    
}
