//
//  AgregarMisAlimentosVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 10/09/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import RealmSwift

class AgregarMisAlimentosVC: UIViewController {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var prot: UITextField!
    @IBOutlet weak var fat: UITextField!
    @IBOutlet weak var carb: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nombre.resignFirstResponder()
        prot.resignFirstResponder()
        fat.resignFirstResponder()
        carb.resignFirstResponder()
        
    }

    @IBAction func cerrar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func agregar(_ sender: UIButton) {
        //PONER IF AMBOS DATOS ESTAN LLENOS, SINO ALERTA
        let realm = try! Realm()
        print("URL REALM")

        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let id = realm.objects(Sesion.self).first?.userID
        let infoPersona = realm.objects(Persona.self).filter("userID == %@", id).first
        
        //nuevoItem
        let nuevoItem = AlimentosBase()
        nuevoItem.nombre = nombre.text!
        nuevoItem.prot = Double(prot.text!)!
        nuevoItem.fat = Double(fat.text!)!
        nuevoItem.carb = Double(carb.text!)!
        nuevoItem.miItem = true
        nuevoItem.seleccionado = true
        
        //insert
            do {
                try realm.write {
                    infoPersona!.alimentosBase.append(nuevoItem)
                }
            } catch {
                print("ERROR REALM")
                print(error)
            }
        
        dismiss(animated: true, completion: nil)

    }
}
