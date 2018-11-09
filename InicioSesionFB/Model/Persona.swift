//
//  Persona.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 2/07/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import Foundation
import RealmSwift


class Persona: Object {
    
    @objc dynamic var userID: String = ""
    @objc dynamic var nombre: String = ""
    @objc dynamic var apellido: String = ""
    @objc dynamic var correo: String = ""
    @objc dynamic var fechaNacimiento: Date? = nil
    @objc dynamic var altura: Double = 0.0
    @objc dynamic var sexo: String = ""
    
    @objc dynamic var foto: NSData? = nil
    
    var pesos = List<Peso>()
    
    var medidas = List<Medidas>()

    var dieta = List<Dieta>()

    var alimentosBase = List<AlimentosBase>()
    
    var lista = List<Lista>()

}
