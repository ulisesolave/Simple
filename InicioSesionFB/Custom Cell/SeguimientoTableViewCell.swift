//
//  SeguimientoTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 22/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import SwipeCellKit

class SeguimientoTableViewCell: SwipeTableViewCell {

    
    @IBOutlet weak var peso: UILabel!
    @IBOutlet weak var fecha: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
