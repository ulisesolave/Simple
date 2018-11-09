//
//  seleccionarCustomAlimentoTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 14/09/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

protocol SeleccionarItemDelegate {
    func agregarSeleccionado(item: AlimentosBase)
    func borrarSeleccionado(item: AlimentosBase)

}

class seleccionarCustomAlimentoTableViewCell: UITableViewCell {

    var delegate: SeleccionarItemDelegate?

    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var unidad: UILabel!
    @IBOutlet weak var cantPorc: UITextField!
    @IBOutlet weak var botonSeleccionado: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func seleccionadoPressed(_ sender: UIButton) {
        let item = AlimentosBase()
        item.nombre = nombre.text!
        item.porcion = Int(cantPorc.text!)!
        
        if botonSeleccionado.isSelected {
            botonSeleccionado.isSelected = false
            botonSeleccionado.setImage(UIImage(named: "checkNo.png"), for: .normal)
            delegate?.borrarSeleccionado(item: item)

        } else {
            botonSeleccionado.isSelected = true
            botonSeleccionado.setImage(UIImage(named: "checkSi.png"), for: .normal)
            delegate?.agregarSeleccionado(item: item)
        }
        

    }
}
