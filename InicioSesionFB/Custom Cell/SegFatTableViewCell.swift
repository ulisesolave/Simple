//
//  SegFatTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 22/10/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import SwipeCellKit

class SegFatTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var cadera: UILabel!
    @IBOutlet weak var cintura: UILabel!
    @IBOutlet weak var cuello: UILabel!
    @IBOutlet weak var porcentaje: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
