//
//  CustomAlimentosTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 13/09/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class CustomAlimentosTableViewCell: UITableViewCell {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var unidad: UILabel!
    @IBOutlet weak var porcion: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
