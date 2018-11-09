//
//  Medidas.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 21/10/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import Foundation
import RealmSwift


class Medidas: Object {
    
    @objc dynamic var cadera: Double = 0.0
    @objc dynamic var cintura: Double = 0.0
    @objc dynamic var cuello: Double = 0.0
    @objc dynamic var fechaRegistro: Date? = nil
    @objc dynamic var porcentaje: Double = 0.0
    
    
    var parentPersona = LinkingObjects(fromType: Persona.self, property: "medidas")
    
}

