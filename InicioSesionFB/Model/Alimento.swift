//
//  Alimento.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 2/07/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import Foundation
import RealmSwift


class Alimento: Object {
    
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


    
    var parentMeal = LinkingObjects(fromType: Meal.self, property: "alimentos")

}
