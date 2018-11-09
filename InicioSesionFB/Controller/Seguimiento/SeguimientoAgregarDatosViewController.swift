//
//  SeguimientoAgregarDatosViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 28/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import RealmSwift


class SeguimientoAgregarDatosViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var pesoIngresado: UITextField!
    
    private var datePicker: UIDatePicker?
    
    @IBAction func agregar(_ sender: UIButton) {
        //LA FECHA DEBE INICIAR EN EL DIA DE HOY
        
        //PONER IF AMBOS DATOS ESTAN LLENOS, SINO ALERTA
        
        let realm = try! Realm()
        print("URL REALM")
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let id = realm.objects(Sesion.self).first?.userID
        let infoPersona = realm.objects(Persona.self).filter("userID == %@", id).first

        //peso
        let nuevoPeso = Peso()
        nuevoPeso.pesoKg = Double(pesoIngresado.text!)!
        nuevoPeso.fechaRegistro = fechaStringADate(fechaString: Date().string(format: "dd/MM/yyyy"))
        
            
        let p = realm.objects(Peso.self).filter("fechaRegistro == %@ AND ANY parentPersona.userID == %@", fechaStringADate(fechaString: Date().string(format: "dd/MM/yyyy"))!, id!)
        print("P ES")
        print(p)
        if p.first != nil {
            //update
            print("YA EXISTE EN ESA FECHA DE REGISTRO, HARA UPDATE")
            do {
                try realm.write {
                p.first?.pesoKg = Double(pesoIngresado.text!)!
                }
            } catch {
                print("ERROR REALM")
                print(error)
            }
        } else {
            //insert
            print("NO EXISTE EN ESA FECHA DE REGISTRO, HARA INSERT")
            do {
                try realm.write {
                    infoPersona!.pesos.append(nuevoPeso)
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
        self.pesoIngresado.delegate = self
        
        //teclado decimal (con punto)
        pesoIngresado.keyboardType = UIKeyboardType.decimalPad

        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        
    }
    

    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)

    }
    

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {


        var numeroOK = true
        
        let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.index(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        //es numerico
        if isNumeric == false {
            numeroOK = false
        }
            //es menor que 150
        else if let intValue = Double(newText), intValue > 150 {
            numeroOK = false
        }
            //es mayor que 40
//        else if let intValue = Double(newText), intValue < 9 {
//            numeroOK = false
//        }
            //solo hay un punto
        else if numberOfDots > 1 {
            numeroOK = false
        }
            //solo hay un decimal
        else if numberOfDecimalDigits > 1 {
            numeroOK = false
        }
        

        
        return numeroOK
    }

    func fechaStringADate(fechaString: String) -> Date? { //recibe fecha en formato dd/MM/yyy

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        
        
        return dateFormatter.date(from: fechaString)
    }
    

}



extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
