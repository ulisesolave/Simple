//
//  AlimentosBase.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 15/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import Foundation
import RealmSwift


class AlimentosBase: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var tipoMacro: String = ""
    @objc dynamic var subMacro: String = ""
    @objc dynamic var nombre: String = ""
    @objc dynamic var cal: Double = 0.0
    @objc dynamic var prot: Double = 0.0
    @objc dynamic var fat: Double = 0.0
    @objc dynamic var carb: Double = 0.0
    @objc dynamic var porcion: Int = 0
    @objc dynamic var unidadPorcion: String = ""
    @objc dynamic var seleccionado: Bool = false
    @objc dynamic var desayuno: Bool = false
    @objc dynamic var almuerzo: Bool = false
    @objc dynamic var cena: Bool = false
    @objc dynamic var snack: Bool = false
    @objc dynamic var porcionMax: Int = 0
    @objc dynamic var porcionMin: Int = 0
    @objc dynamic var miItem: Bool = false
    @objc dynamic var enEstaMeal: Bool = false
    @objc dynamic var enEstaMealPorc: Int = 0

    
    var parentPersona = LinkingObjects(fromType: Persona.self, property: "alimentosBase")

    
}
