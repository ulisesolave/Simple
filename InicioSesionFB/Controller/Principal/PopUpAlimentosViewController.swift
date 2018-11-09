//
//  PopUpAlimentosViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 4/07/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import SwiftCharts
import PieCharts

class PopUpAlimentosViewController: UIViewController, PieChartDelegate  {

    @IBOutlet weak var popUpView: UIView!
    
    var nombreAlimento = ""
    var porcionesAlimento = 0
    var unidadAlimento = ""
    var cantidad = ""
    var cal = 0.0
    var prot = 0.0
    var fat = 0.0
    var carb = 0.0
    var notas = ""
    
    
    var totalGr = 0.0
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var lblCantidad: UILabel!
    @IBOutlet weak var lblNotas: UILabel!
    @IBOutlet weak var viewFotoAlimento: UIImageView!
    @IBOutlet weak var pieAlimento: PieChart!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        
        print("ESTOY EN POPUP ALIMENTOS")
        print(nombreAlimento)
        
        nombre.text = nombreAlimento
        lblCantidad.text = cantidad
        lblNotas.text = notas
        
        var n = nombreAlimento + ".png"
        n = "hombre-1.png"
        viewFotoAlimento.image = UIImage(named: n)

    }
    


  
    @IBAction func cerrarPopUp(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
 
    
    
    override func viewDidAppear(_ animated: Bool) {
        totalGr = prot + fat + carb
        
        pieAlimento.layers = [createTextLayer(), createCustomViewsLayer()]
//        pieAlimento.layers = [createCustomViewsLayer(), createTextWithLinesLayer()]

        pieAlimento.delegate = self
        pieAlimento.models = createModels() // order is important - models have to be set at the end
    }
    
    // MARK: - PieChartDelegate
    
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice)")
    }
    
    
    fileprivate func createModels() -> [PieSliceModel] {
        let alpha: CGFloat = 0.5
        var a = [PieSliceModel]()
        
        
        if prot > 0 {
        a.append(PieSliceModel(value: prot, color: UIColor.yellow.withAlphaComponent(alpha)))
        }
        if fat > 0 {
            a.append(PieSliceModel(value: fat, color: UIColor.blue.withAlphaComponent(alpha)))
        }
        if carb > 0 {
            a.append(PieSliceModel(value: carb, color: UIColor.green.withAlphaComponent(alpha)))
        }
       return a
    }
    
    
    // MARK: - Layers
    
    fileprivate func createCustomViewsLayer() -> PieCustomViewsLayer {
        let viewLayer = PieCustomViewsLayer()
        
        let settings = PieCustomViewsLayerSettings()
        settings.viewRadius = 40
        settings.hideOnOverflow = false
        viewLayer.settings = settings
        
        viewLayer.viewGenerator = createViewGenerator()
        
        return viewLayer
    }
    
    fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
        let lineTextLayer = PieLineTextLayer()
        var lineTextLayerSettings = PieLineTextLayerSettings()
        lineTextLayerSettings.lineColor = UIColor.lightGray
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
        lineTextLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
        }
        
        lineTextLayer.settings = lineTextLayerSettings
        return lineTextLayer
    }

    
    
    fileprivate func createTextLayer() -> PiePlainTextLayer {
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 50
        textLayerSettings.hideOnOverflow = false
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 13)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * self.totalGr as NSNumber).map{"\($0)Gr"} ?? ""
//            return formatter.string(from: slice.data.percentage  as NSNumber).map{"\($0)%"} ?? ""

        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
    

    
    fileprivate func createViewGenerator() -> (PieSlice, CGPoint) -> UIView {
        return {slice, center in
            
            let container = UIView()
//            container.frame.size = CGSize(width: 20, height: 10)
            container.center = center
            let view = UIImageView()
            view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            container.addSubview(view)
            
            let specialTextLabel = UILabel()
            specialTextLabel.textAlignment = .center
            if slice.data.id == 0 {
                specialTextLabel.textColor = UIColor.blue
                specialTextLabel.text = ""
//                specialTextLabel.text = "Proteínas"
                specialTextLabel.font = UIFont(name: specialTextLabel.font.fontName, size: 11)
                
            } else if slice.data.id == 1 {
                specialTextLabel.textColor = UIColor.blue
                specialTextLabel.text = ""
//                specialTextLabel.text = "Grasas"
                specialTextLabel.font = UIFont(name: specialTextLabel.font.fontName, size: 11)
                
            }else if slice.data.id == 2 {
                specialTextLabel.textColor = UIColor.blue
                specialTextLabel.text = ""
//                specialTextLabel.text = "Carbohidratos"
                specialTextLabel.font = UIFont(name: specialTextLabel.font.fontName, size: 11)
                
            }
            specialTextLabel.sizeToFit()
            specialTextLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 10)
            container.addSubview(specialTextLabel)
            container.frame.size = CGSize(width: 40, height: 10)
            
            
            
//            // src of images: www.freepik.com, http://www.flaticon.com/authors/madebyoliver
//            let imageName: String? = {
//                switch slice.data.id {
//                case 0: return "meat"
//                case 1: return "avocado"
//                case 2: return "rice"
//                default: return nil
//                }
//            }()
//
//            view.image = imageName.flatMap{UIImage(named: $0)}
//
            return container
        }
    }
    
}
