//
//  Datos1VC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 16/07/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import TextFieldEffects

class Datos1VC: UIViewController, UITextFieldDelegate {
    var isKeyboardAppear = false

    
    var objetivo = ""
    
    @IBOutlet weak var botonH: UIButton!
    
    @IBOutlet weak var botonM: UIButton!
    
    var diferencia = 0.0
    var recomendadoMax = 0.0
    var recomendadoMin = 0.0
    var recomendadoMedio = 0.0
    var maximo = 0.0
    var minimo = 0.0
    var recomendadoSemMin = 0
    var recomendadoSemMax = 0
    var recomendadoSemMedio = 0
    var semMin = 0
    var semMax = 0
    var pesoMetaMin = 0
    var pesoMetaMax = 0
    var pMeta = 0.0
    var semanas = 0

    //para ver si la dieta se ha rehecho
    var dietaRehecha = false
    
    //variables a pasar
    var sexo = ""
    var fatLossXweek = 0.0
    
    
    @IBOutlet weak var edadTextField: UITextField!
    @IBOutlet weak var alturaTextField: UITextField!
    @IBOutlet weak var pesoActual: UITextField!
    @IBOutlet weak var pesoMeta: UITextField!
    @IBOutlet weak var sliderFijarMeta: UISlider!
    @IBOutlet weak var meta: UILabel!
    @IBOutlet weak var kgPerdidosPorSemana: UILabel!
    @IBOutlet weak var metaKg: UILabel!
    
    
    //otras variables validacion
    var pesoActualValido = false
    var pesoMetaValido = false

    //variables hoshi
    @IBOutlet weak var edd: HoshiTextField!
    @IBOutlet weak var alt: HoshiTextField!
    @IBOutlet weak var pes: HoshiTextField!
    @IBOutlet weak var pesMet: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Continuar", style: .done, target: self, action: #selector(continuar))
        
//        NotificationCenter.default.addObserver(self, selector: #selector(Datos1VC.keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(Datos1VC.keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
//

        
        print("imprime onjetivo")
        print(objetivo)
        kgPerdidosPorSemana.isHidden = true
        sliderFijarMeta.isHidden = true
        metaKg.isHidden = true
        meta.isHidden = true

        if objetivo == "Perder Peso" {
            kgPerdidosPorSemana.text = "Pérdida por semana:"

        } else if objetivo == "Ganar Peso" {
            kgPerdidosPorSemana.text = "Aumento por semana:"
        } else if objetivo == "Mantener Peso" {
            pesoMeta.isHidden = true
        }
        
        
        self.edadTextField.delegate = self
        self.alturaTextField.delegate = self
        self.pesoActual.delegate = self
        self.pesoMeta.delegate = self

        
        //teclado decimal (con punto)
        edadTextField.keyboardType = UIKeyboardType.numberPad
        alturaTextField.keyboardType = UIKeyboardType.numberPad
        pesoActual.keyboardType = UIKeyboardType.decimalPad
        pesoMeta.keyboardType = UIKeyboardType.decimalPad
        
        
        botonH.layer.cornerRadius = 8;
        botonH.layer.masksToBounds = true;
        botonH.layer.borderWidth = 1;
        botonH.layer.borderColor = UIColor(red:101/255, green:133/255, blue:37/255, alpha: 1).cgColor
        
        botonM.layer.cornerRadius = 8;
        botonM.layer.masksToBounds = true;
        botonM.layer.borderWidth = 1;
        botonM.layer.borderColor = UIColor(red:101/255, green:133/255, blue:37/255, alpha: 1).cgColor
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let current = view.getSelectedTextField()
        print("CURRENT TF")
        print(current)

        print(current?.frame.midY)
        
        if Double((current?.frame.midY)!) > 400.0 {
        
        if !isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            isKeyboardAppear = true
        }
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
            isKeyboardAppear = false
        }
    }
    
    
    @IBAction func mujer(_ sender: UIButton) {
        sender.pulsate()
        sexo = "Mujer"
        
        if botonM.isSelected {
            botonM.isSelected = false
        } else {
            botonM.isSelected = true
            botonM.tintColor =  UIColor(red:249/255, green:0/255, blue:0/255, alpha: 1)
            botonM.backgroundColor = UIColor(red:231/255, green:231/255, blue:231/255, alpha: 1)
            //desseleccionar boton hombre
            botonH.isSelected = false
            botonH.backgroundColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 1)
        }
        
    }
    
    @IBAction func hombre(_ sender: UIButton) {
        sender.pulsate()
        sexo = "Hombre"
        
        if botonH.isSelected {
            botonH.isSelected = false
        } else {
            botonH.isSelected = true
            botonH.tintColor =  UIColor(red:249/255, green:0/255, blue:0/255, alpha: 1)
            botonH.backgroundColor = UIColor(red:231/255, green:231/255, blue:231/255, alpha: 1)
            //desseleccionar boton mujer
            botonM.isSelected = false
            botonM.backgroundColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha: 1)
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        edadTextField.resignFirstResponder()
        alturaTextField.resignFirstResponder()
        pesoActual.resignFirstResponder()
        pesoMeta.resignFirstResponder()

    }
    
    
    @IBAction func edadCambio(_ sender: UITextField) {
        let anos = Int(sender.text!)
        if anos != nil {
            if anos! >= 18 && anos! <= 60 {
                edd.placeholderColor = .black

            } else {
                edadTextField.text =  ""
                let alert = UIAlertController(title: "Error en tu edad", message: "Tu edad no puede ser menor de 18 años ni mayor de 60 años.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }}))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    @IBAction func alturaCambio(_ sender: UITextField) {
        let cms = Int(sender.text!)
        if cms != nil {
            if cms! >= 140 && cms! <= 210 {
                alt.placeholderColor = .black

            } else {
                alturaTextField.text =  ""
                let alert = UIAlertController(title: "Error en tu altura", message: "Tu altura no puede ser menor de 140 cm ni mayor de 210 cm.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }}))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    
    @IBAction func pesoActualCambio(_ sender: UITextField) {
        pesoMeta.text = ""
        pesoMetaValido = false

        let pesoAct = Double(sender.text!)
        if pesoAct != nil {
            if pesoAct! >= 40 && pesoAct! <= 150 {
                pesoActualValido = true
                pes.placeholderColor = .black
                print("PESO ACTUAL CAMBIO")
                if objetivo == "Perder Peso" {
                    pesoMetaMin = Int(pesoAct!) * 85 / 100
                    pesoMetaMax = Int(pesoAct!) - 1
                    
                    minimo = 0.003 * Double(pesoAct!)
                    recomendadoMin = 0.005 * Double(pesoAct!)
                    recomendadoMedio = (recomendadoMin + recomendadoMax) / 2
                    recomendadoMax = 0.01 * Double(pesoAct!)
                    maximo = 0.012 * Double(pesoAct!)
                    
                } else if objetivo == "Ganar Peso" {
                    pesoMetaMin = Int(pesoAct!) + 1
                    pesoMetaMax = Int(pesoAct!) * 115 / 100
                    
                    minimo = 0.00125 * Double(pesoAct!)
                    recomendadoMin = 0.00175 * Double(pesoAct!)
                    recomendadoMedio = (recomendadoMin + recomendadoMax) / 2
                    recomendadoMax = 0.00275 * Double(pesoAct!)
                    maximo = 0.00375 * Double(pesoAct!)
                }
                

                print("KG POR SEMANA PERDIDOS ")
                
                print(minimo)
                print(recomendadoMin)
                print(recomendadoMedio)
                print(recomendadoMax)
                print(maximo)
                
                sliderFijarMeta.maximumValue = Float(maximo)
                sliderFijarMeta.minimumValue = Float(minimo)
                sliderFijarMeta.setValue(Float(recomendadoMedio), animated: true)
                
                //igual que cuando el slider cambia
                let x = sliderFijarMeta.value
                let y = Double(round(1000*x)/1000)
                fatLossXweek = Double(x)
                let kg = String(format: "%.1f", y)
                metaKg.text =  kg + " Kg por semana"
                
            } else {
                pesoActualValido = false
                metaKg.text =  ""
                pesoActual.text = ""
                
                let alert = UIAlertController(title: "Error en tu peso", message: "Tu peso actual no puede ser menor de 40 Kg ni mayor de 150 Kg.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }}))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        print("PESO ACTUAL VALIDO")
        print(pesoActualValido)
        print("PESO META VALIDO")
        print(pesoMetaValido)
        habilitarSlider()
    }


 
    
    
    @IBAction func pesoMetaCambio(_ sender: UITextField) {
print("PESO META MIN Y MAX")
        
        print(pesoMetaMin)
        print(pesoMetaMax)
        pMeta = Double(sender.text!)!
        if pMeta != nil {
            
        if pesoActualValido == true {

            if pMeta >= Double(pesoMetaMin) && pMeta <= Double(pesoMetaMax) {
                    pesoMetaValido = true
                    pesMet.placeholderColor = .black
                    diferencia = Double(pesoActual.text!)! - pMeta
                    
                } else {
                    pesoMetaValido = false
                    pesoMeta.text = ""
                    let alert = UIAlertController(title: "Error en tu peso meta", message: "Tu peso meta no puede ser mayor de " + String(pesoMetaMax) + " Kg ni menor de " + String(pesoMetaMin) + " Kg", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                        case .cancel:
                            print("cancel")
                        case .destructive:
                            print("destructive")
                        }}))
                    self.present(alert, animated: true, completion: nil)
                }
          

            

        } else {
            pesoMetaValido = false
            pesoMeta.text = ""
            let alert = UIAlertController(title: "Error en tu peso actual", message: "Primero ingrese un peso actual válido.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        
        }
        
        print("PESO ACTUAL VALIDO")
        print(pesoActualValido)
        print("PESO META VALIDO")
        print(pesoMetaValido)
        habilitarSlider()
        
    }
    
    
   
    @IBAction func sliderFijarMetaCambio(_ sender: UISlider) {
        
        print("EL SLIDER CAMBIO A ")

        print(sender.value)
        semanas = 0
        
        let x = sender.value
        let y = Double(round(1000*x)/1000)
        
        fatLossXweek = Double(x)

        let kg = String(format: "%.1f", y)
        metaKg.text =  kg + " Kg por semana"
        
       
        if objetivo == "Perder Peso" {
            semanas = Int(round(diferencia / Double(sender.value)))
        } else if objetivo == "Ganar Peso" {
            semanas = (Int(round(diferencia / Double(sender.value)))) * -1

        }
    
        
        print("SEMANAS")
        print(semanas)
        
        meta.text = String(semanas) + " Semanas"
        
        
    }
    
    func habilitarSlider(){
        if pesoActualValido == true && pesoMetaValido == true {
            kgPerdidosPorSemana.isHidden = false
            sliderFijarMeta.isHidden = false
            metaKg.isHidden = false
            meta.isHidden = false
        } else {
            kgPerdidosPorSemana.isHidden = true
            sliderFijarMeta.isHidden = true
            metaKg.isHidden = true
            meta.isHidden = true
        }
    }
    
    
    @objc func continuar(){
        let datosLLenos = datosLlenos()
        if datosLLenos == true {
            performSegue(withIdentifier: "datos2Segue", sender: self)

        } else {
            print("LOS DATOS NO ESTAN LLENOS")
        }
        
    }

    
    func datosLlenos() -> Bool{
        var Ok = true
        //validar llenado datos, (no datos correctos sino llenos)
        //para todos los casos: edad, altura
        //let edad = edadTextField.text!
        
        if edadTextField.text == "" {
            edd.placeholderColor = .red
            edd.shake()
            Ok = false
        }
        if alturaTextField.text == "" {
            alt.placeholderColor = .red
            alt.shake()
            Ok = false
        }
        if pesoActual.text == "" {
            pes.placeholderColor = .red
            pes.shake()
            Ok = false
        }
        if sexo == "" {
            botonH.shake()
            botonM.shake()
            Ok = false
        }
        
        if objetivo == "Perder Peso" {
            if pesoMeta.text == "" {
                pesMet.placeholderColor = .red
                pesMet.shake()
                Ok = false
            }
        } else if objetivo == "Ganar Peso" {
            if pesoMeta.text == "" {
                pesMet.placeholderColor = .red
                pesMet.shake()
                Ok = false
            }
        } else if objetivo == "Mantener Peso" {
            
        }
        
        return Ok
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "datos2Segue") {
            
            var vc = segue.destination as! Datos2VC
            //LUEGO crear variables para validarlas y no pasar el input del textfield direcamente
            vc.edad = Int(edadTextField.text!)!
            vc.peso = Double(pesoActual.text!)!
            vc.sexo = sexo
            vc.estatura = Double(alturaTextField.text!)!
            vc.fatLossXweek = fatLossXweek
            vc.objetivo = objetivo
            vc.sem = semanas
            vc.pMeta = pMeta
            vc.dietaRehecha = self.dietaRehecha
        }
    }
    
}

extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
    
    func floor(nearest: Double) -> Double {
        let intDiv = Double(Int(self / nearest))
        return intDiv * nearest
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.4
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -3.0, 3.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func getSelectedTextField() -> UITextField? {
        
        let totalTextFields = getTextFieldsInView(view: self)
        
        for textField in totalTextFields{
            if textField.isFirstResponder{
                return textField
            }
        }
        
        return nil
        
    }
    
    func getTextFieldsInView(view: UIView) -> [UITextField] {
        
        var totalTextFields = [UITextField]()
        
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                totalTextFields += [textField]
            } else {
                totalTextFields += getTextFieldsInView(view: subview)
            }
        }
        
        return totalTextFields
    }
}

extension UITextField {
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy)
    }
}
