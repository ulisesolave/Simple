//
//  MisAlimentosTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 10/09/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class MisAlimentosTableViewCell: UITableViewCell {

    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var prot: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var carb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
