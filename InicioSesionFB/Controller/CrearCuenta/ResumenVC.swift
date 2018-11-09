//
//  ResumenVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 7/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import PieCharts
import RealmSwift

class ResumenVC: UIViewController, PieChartDelegate {


    
    var calorias = 0.0
    var items = [Int]()
    var cantidadMeals = 0
    var objetivo = ""
    var peso = 0.0
    var macros = [Double]()
    var pesoMeta = 0.0
    var sem = 0
    var altura = 0.0
    var sexo = ""
    
    //para ver si la dieta se ha rehecho
    var dietaRehecha = false

    @IBOutlet weak var pesoActual: UILabel!
    @IBOutlet weak var pMeta: UILabel!
    @IBOutlet weak var tiempo: UILabel!
    @IBOutlet weak var cal: UILabel!
    
    
    var dieta: Results<Dieta>?

    
    @IBOutlet weak var botonTerminos: UIButton!
    @IBOutlet weak var botonPrivacidad: UIButton!
    
    
    
    @IBOutlet weak var chartView: PieChart!
    fileprivate static let alpha: CGFloat = 0.5
    let colors = [
        UIColor.yellow.withAlphaComponent(alpha),
        UIColor.green.withAlphaComponent(alpha),
        UIColor.purple.withAlphaComponent(alpha),
        UIColor.cyan.withAlphaComponent(alpha),
        UIColor.darkGray.withAlphaComponent(alpha),
        UIColor.red.withAlphaComponent(alpha),
        UIColor.magenta.withAlphaComponent(alpha),
        UIColor.orange.withAlphaComponent(alpha),
        UIColor.brown.withAlphaComponent(alpha),
        UIColor.lightGray.withAlphaComponent(alpha),
        UIColor.gray.withAlphaComponent(alpha),
        ]
    fileprivate var currentColorIndex = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("ITEMS")
        print(items)
        
        print("MACROS")
        print(macros)
        
        pesoActual.text = String(peso) + " Kg"
        pMeta.text = String(pesoMeta) + " Kg"
        tiempo.text = String(sem) + " Semanas"
        cal.text = String(Int(round(calorias))) + " Cal/Día"
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        chartView.layers = [createCustomViewsLayer(), createTextLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
    }
    
    // MARK: - PieChartDelegate
    
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice)")
    }
    
    
    fileprivate func createModels() -> [PieSliceModel] {
        let alpha: CGFloat = 0.5
        
        return [
            PieSliceModel(value: macros[0] * 4, color: UIColor.yellow.withAlphaComponent(alpha)),
            PieSliceModel(value: macros[1] * 9, color: UIColor.blue.withAlphaComponent(alpha)),
            PieSliceModel(value: macros[2] * 4, color: UIColor.green.withAlphaComponent(alpha))
        ]
    }
    
    
    // MARK: - Layers
    
    fileprivate func createCustomViewsLayer() -> PieCustomViewsLayer {
        let viewLayer = PieCustomViewsLayer()
        
        let settings = PieCustomViewsLayerSettings()
        settings.viewRadius = 135
        settings.hideOnOverflow = false
        viewLayer.settings = settings
        
        viewLayer.viewGenerator = createViewGenerator()
        
        return viewLayer
    }
    
    fileprivate func createTextLayer() -> PiePlainTextLayer {
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 60
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 18)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
            
        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
    
    fileprivate func createViewGenerator() -> (PieSlice, CGPoint) -> UIView {
        return {slice, center in
            
            let container = UIView()
            container.frame.size = CGSize(width: 100, height: 40)
            container.center = center
            let view = UIImageView()
            view.frame = CGRect(x: 30, y: 0, width: 40, height: 40)
            container.addSubview(view)
            
                let specialTextLabel = UILabel()
                specialTextLabel.textAlignment = .center
                if slice.data.id == 0 {
                    specialTextLabel.textColor = UIColor.blue
                    specialTextLabel.text = "Proteínas"
                    specialTextLabel.font = UIFont(name: specialTextLabel.font.fontName, size: 13)

                } else if slice.data.id == 1 {
                    specialTextLabel.textColor = UIColor.blue
                    specialTextLabel.text = "Grasas"
                    specialTextLabel.font = UIFont(name: specialTextLabel.font.fontName, size: 13)

                }else if slice.data.id == 2 {
                    specialTextLabel.textColor = UIColor.blue
                    specialTextLabel.text = "Carbohidratos"
                    specialTextLabel.font = UIFont(name: specialTextLabel.font.fontName, size: 12)

                }
                specialTextLabel.sizeToFit()
                specialTextLabel.frame = CGRect(x: 0, y: 40, width: 100, height: 20)
                container.addSubview(specialTextLabel)
                container.frame.size = CGSize(width: 100, height: 60)
            
            
            
            // src of images: www.freepik.com, http://www.flaticon.com/authors/madebyoliver
            let imageName: String? = {
                switch slice.data.id {
                case 0: return "meat"
                case 1: return "avocado"
                case 2: return "rice"
                default: return nil
                }
            }()
            
            view.image = imageName.flatMap{UIImage(named: $0)}
            
            return container
        }
    }
   
    
    
    
    
    
    
    
    
    
    @IBAction func mostrarPoliticas(_ sender: UIButton) {
        performSegue(withIdentifier: "privacidadSegue", sender: self)
    }
    
    @IBAction func mostrarTerminos(_ sender: UIButton) {
        performSegue(withIdentifier: "terminosSegue", sender: self)

    }
    
    @IBAction func terminosPressed(_ sender: UIButton) {
        if botonTerminos.isSelected {
            botonTerminos.isSelected = false
            botonTerminos.setImage(UIImage(named: "checkNo.png"), for: .normal)

        } else {
            botonTerminos.isSelected = true
            botonTerminos.setImage(UIImage(named: "checkSi.png"), for: .normal)
        }
    }
    
    @IBAction func privacidadPressed(_ sender: UIButton) {
        if botonPrivacidad.isSelected {
            botonPrivacidad.isSelected = false
            botonPrivacidad.setImage(UIImage(named: "checkNo.png"), for: .normal)
            
        } else {
            botonPrivacidad.isSelected = true
            botonPrivacidad.setImage(UIImage(named: "checkSi.png"), for: .normal)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        GifVC.instance.hideLoader()
    }
    
    @IBAction func terminarPressed(_ sender: UIButton) {
        
        if botonTerminos.isSelected && botonPrivacidad.isSelected {

        if dietaRehecha == false {
            
                performSegue(withIdentifier: "crearCuentaSegue", sender: self)
            
        } else {
            GifVC.instance.showLoader()
            
            let deadlineTime = DispatchTime.now() + .seconds(4)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.performSegue(withIdentifier: "rehacerDietaSegue", sender: self)
            })
            
            

            let realm = try! Realm()

            let id = realm.objects(Sesion.self).first?.userID
      
            dieta = realm.objects(Dieta.self).filter("ANY parentPersona.userID == %@", id!)

            
            let die = Dieta()
            die.calTarget = self.calorias
            die.cantMeals = self.cantidadMeals
            die.objetivo = self.objetivo
            die.fechaRegistro = Date()
            die.fechaFin = Calendar.current.date(byAdding: .day, value: self.sem * 7, to: Date())
            die.pesoInicial = self.peso
            die.pesoMeta = self.pesoMeta
            die.semanas = self.sem
            die.grProt = self.macros[0]
            die.grFat = self.macros[1]
            die.grCarb = self.macros[2]
            
            
            do {
                try realm.write {
                    dieta?.first?.objetivo = self.objetivo
                    dieta?.first?.pesoInicial = self.peso
                    dieta?.first?.pesoMeta = self.pesoMeta
                    dieta?.first?.calTarget = self.calorias
                    dieta?.first?.semanas = self.sem
                    dieta?.first?.cantMeals = self.cantidadMeals
                    dieta?.first?.fechaRegistro = Date()
                    dieta?.first?.fechaFin = Calendar.current.date(byAdding: .day, value: self.sem * 7, to: Date())
                    dieta?.first?.grProt = self.macros[0]
                    dieta?.first?.grFat = self.macros[1]
                    dieta?.first?.grCarb = self.macros[2]
                    dieta?.first?.contRehacerDieta = (dieta?.first?.contRehacerDieta)! + 1
                    dieta?.first?.rehacerDieta = true
                    
                }
            } catch {
                print("ERROR REALM")
                print(error)
            }
            
        }
        
        } else {
            let alert = UIAlertController(title: "Debes aceptar los términos", message: "Debes aceptar los Términos y Condiciones y la Política de Privacidad.", preferredStyle: UIAlertController.Style.alert)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "crearCuentaSegue") {
            
            var vc = segue.destination as! CrearCuentaVC
            vc.calorias = calorias
            vc.items = items
            vc.cantidadMeals = cantidadMeals
            vc.objetivo = objetivo
            vc.peso = peso
            vc.macros = macros
            vc.altura = altura
            vc.sexo = sexo
            vc.pesoMeta = pesoMeta
            vc.semanas = sem
        }
    }
    


}




extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}
