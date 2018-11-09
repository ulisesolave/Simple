//
//  AlimentoTableViewCell.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 5/07/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit




class AlimentoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imagenAlimento: UIImageView!
    @IBOutlet weak var nombreAlimento: UILabel!
    @IBOutlet weak var unidadAlimento: UILabel!
    @IBOutlet weak var porcionAlimento: UILabel!
    @IBOutlet weak var calAlimento: UILabel!
    @IBOutlet weak var protAlimento: UILabel!
    @IBOutlet weak var fatAlimento: UILabel!
    @IBOutlet weak var carbAlimento: UILabel!
    @IBOutlet weak var idAlimento: UILabel!
    @IBOutlet weak var descCant: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

    

    
}
