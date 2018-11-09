//
//  ShoppingListTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 16/10/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

protocol MarcarCompradoDelegate {
    func agregarSeleccionado(item: ListaAlimentos)
    func borrarSeleccionado(item: ListaAlimentos)
    
}

class ShoppingListTableViewCell: UITableViewCell {

    
        var delegate: MarcarCompradoDelegate?

    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var cantidad: UILabel!
    @IBOutlet weak var check: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func checkPresionado(_ sender: UIButton) {
        let item = ListaAlimentos()
        item.nombre = nombre.text!
        
        if check.isSelected {
            check.isSelected = false
            check.setImage(UIImage(named: "checkNo.png"), for: .normal)
            delegate?.borrarSeleccionado(item: item)
            
        } else {
            check.isSelected = true
            check.setImage(UIImage(named: "checkSi.png"), for: .normal)
            delegate?.agregarSeleccionado(item: item)
        }
        
    }
    
}
