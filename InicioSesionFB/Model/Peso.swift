//
//  Peso.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 1/07/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import Foundation
import RealmSwift


class Peso: Object {
    
    @objc dynamic var pesoKg: Double = 0.0
    @objc dynamic var fechaRegistro: Date? = nil

    

    var parentPersona = LinkingObjects(fromType: Persona.self, property: "pesos")
    
}
