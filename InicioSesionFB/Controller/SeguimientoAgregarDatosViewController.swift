//
//  SeguimientoAgregarDatosViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 28/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class SeguimientoAgregarDatosViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var pesoIngresado: UITextField!
    @IBOutlet weak var fechaIngresada: UITextField!
    
    private var datePicker: UIDatePicker?
    
    @IBAction func agregar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cerrar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.pesoIngresado.delegate = self
        
        //teclado decimal (con punto)
        pesoIngresado.keyboardType = UIKeyboardType.decimalPad

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.locale =  NSLocale(localeIdentifier: "es_PE") as Locale
        
        datePicker?.minimumDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())
        datePicker?.maximumDate = Date()
        
        
        datePicker?.addTarget(self, action: #selector(cambiaFecha(datePicker:)), for: .valueChanged)
        
        
        //para darle dismiss si toca la fecha pero no cambia ningun valor de la fecha, en caso cambie corre la funcion cambiaFecha y le da dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        fechaIngresada.inputView = datePicker
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)

    }
    
    @objc func cambiaFecha(datePicker: UIDatePicker){
        let formatoFecha = DateFormatter()
        formatoFecha.dateFormat = "dd/MM/yyyy"
        fechaIngresada.text = formatoFecha.string(from: datePicker.date)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
