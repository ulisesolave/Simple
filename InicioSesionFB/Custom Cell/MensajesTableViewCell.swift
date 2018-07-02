//
//  MensajesTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 22/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class MensajesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imagenChat: UIImageView!
    @IBOutlet weak var nombreChat: UILabel!
    @IBOutlet weak var mensajeChat: UILabel!
    @IBOutlet weak var fondoChat: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
