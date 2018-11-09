//
//  SegAgregarPorcFatVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 21/10/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import RealmSwift

class SegAgregarPorcFatVC: UIViewController  {

    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var lblCadera: UILabel!
    @IBOutlet weak var cadera: UITextField!
    @IBOutlet weak var cintura: UITextField!
    @IBOutlet weak var cuello: UITextField!

    private var datePicker: UIDatePicker?
    
    @IBAction func agregar(_ sender: UIButton) {
        
        //PONER IF AMBOS DATOS ESTAN LLENOS, SINO ALERTA
        
        let realm = try! Realm()
        print("URL REALM")
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let id = realm.objects(Sesion.self).first?.userID
        let infoPersona = realm.objects(Persona.self).filter("userID == %@", id).first
        let sexo = infoPersona!.sexo
        let altura = infoPersona!.altura
        
        var porcentajeFat = 0.0
        
        if sexo == "Mujer" {

        let cint = Double(cintura.text!)!
        let cad = Double(cadera.text!)!
        let cue = Double(cuello.text!)!

            porcentajeFat = 495 / (1.29579 - 0.35004 * log10(cad + cint - cue) + 0.22100 * log10(altura)) - 450
        } else {
            let cint = Double(cintura.text!)!
            let cue = Double(cuello.text!)!
            porcentajeFat = 86.010 * log10(cint - cue) - 70.041 * log10(altura) + 36.76

        }

        
        
        //agregar medidas
        let nuevaMedida = Medidas()
        
        if sexo == "Mujer" {
            nuevaMedida.cadera = Double(cadera.text!)!
            nuevaMedida.cintura = Double(cintura.text!)!
            nuevaMedida.cuello = Double(cuello.text!)!
            nuevaMedida.porcentaje = porcentajeFat
        } else {
            nuevaMedida.cintura = Double(cintura.text!)!
            nuevaMedida.cuello = Double(cuello.text!)!
            nuevaMedida.porcentaje = porcentajeFat

        }

        nuevaMedida.fechaRegistro = fechaStringADate(fechaString: Date().string(format: "dd/MM/yyyy"))
        
        
        let p = realm.objects(Medidas.self).filter("fechaRegistro = %@ AND ANY parentPersona.userID == %@", fechaStringADate(fechaString: Date().string(format: "dd/MM/yyyy"))!, id! )
        print("Medidas P ES")
        print(p)
        if p.first != nil {
            //update
            print("YA EXISTE EN ESA FECHA DE REGISTRO, HARA UPDATE")
            do {
                try realm.write {
                    if sexo == "Mujer" {
                    p.first?.cadera = nuevaMedida.cadera
                    p.first?.cintura = nuevaMedida.cintura
                    p.first?.cuello = nuevaMedida.cuello
                    p.first?.porcentaje = nuevaMedida.porcentaje
                    } else {
                        p.first?.cintura = nuevaMedida.cintura
                        p.first?.cuello = nuevaMedida.cuello
                        p.first?.porcentaje = nuevaMedida.porcentaje
                    }
                }
            } catch {
                print("ERROR REALM")
                print(error)
            }
        } else {
            //insert
            print("NO EXISTE MEDIDAS EN ESA FECHA DE REGISTRO, HARA INSERT")
            do {
                try realm.write {
                    infoPersona!.medidas.append(nuevaMedida)
                }
            } catch {
                print("ERROR REALM")
                print(error)
            }
        }
        
        
        
        // vver si no hay ningunA
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cerrar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        //  performSegue(withIdentifier: "abc", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("VIEWDIDLOAD AGREGAR")
//        self.cadera.delegate = self
//        self.cintura.delegate = self
//        self.cuello.delegate = self
        
        //teclado decimal (con punto)
        cadera.keyboardType = UIKeyboardType.decimalPad
        cintura.keyboardType = UIKeyboardType.decimalPad
        cuello.keyboardType = UIKeyboardType.decimalPad

        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        
        
        let realm = try! Realm()
        print("URL REALM")
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let id = realm.objects(Sesion.self).first?.userID
        let sexo = realm.objects(Persona.self).filter("userID == %@", id).first?.sexo
     
        
        if sexo == "Hombre" {
            lblCadera.isHidden = true
            cadera.isHidden = true
        } else {
            lblCadera.isHidden = false
            cadera.isHidden = false
        }
        
    }
    
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
        
    }
    
    
        
        
    
    func fechaStringADate(fechaString: String) -> Date? { //recibe fecha en formato dd/MM/yyy
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        
        
        return dateFormatter.date(from: fechaString)
    }
    
    
}




