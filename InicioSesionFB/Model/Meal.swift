//
//  Meal.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 2/07/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import Foundation
import RealmSwift


class Meal: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var tipoMeal: String = ""
    @objc dynamic var dia: String = ""
    @objc dynamic var cal: Double = 0.0
    @objc dynamic var prot: Double = 0.0
    @objc dynamic var fat: Double = 0.0
    @objc dynamic var carb: Double = 0.0
    @objc dynamic var custom: Bool = false
    @objc dynamic var cambioFree: Int = 0

    var alimentos = List<Alimento>()

    var parentDieta = LinkingObjects(fromType: Dieta.self, property: "meals")

}
