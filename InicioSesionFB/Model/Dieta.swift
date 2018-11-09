//
//  Dieta.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 23/10/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import Foundation
import RealmSwift


class Dieta: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var objetivo: String = ""
    @objc dynamic var pesoInicial: Double = 0.0
    @objc dynamic var pesoMeta: Double = 0.0
    @objc dynamic var calTarget: Double = 0.0
    @objc dynamic var semanas: Int = 0
    @objc dynamic var cantMeals: Int = 0
    @objc dynamic var fechaRegistro: Date? = nil
    @objc dynamic var fechaFin: Date? = nil
    @objc dynamic var grProt: Double = 0.0
    @objc dynamic var grFat: Double = 0.0
    @objc dynamic var grCarb: Double = 0.0
    //rehacerDieta se usa para cuando se selecciona rehacer dieta Y cuando se selecciona/desselecciona algun alimento
    @objc dynamic var rehacerDieta: Bool = false
    @objc dynamic var contRehacerDieta: Int = 0
    //cuando se cambia o se hace cualquier meal, para luego ser usada en el shopping list
    @objc dynamic var cambioMeal: Bool = false
    @objc dynamic var contCambioAlimentos: Int = 0

    
    
    var meals = List<Meal>()

    var parentPersona = LinkingObjects(fromType: Persona.self, property: "dieta")
    
}
