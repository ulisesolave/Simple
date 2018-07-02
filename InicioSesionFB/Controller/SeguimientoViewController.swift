//
//  SeguimientoViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 21/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import SwiftChart

class SeguimientoViewController: UIViewController {


    @IBOutlet weak var chart: Chart!
    
    
    @IBAction func botonAgregarDatos(_ sender: UIButton) {
        
        performSegue(withIdentifier: "agregarSeguimientoSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ESTOY EN SEGUIMIENTO VIEW CONTROLLER")

        actualizarChart()
        
        
    }
    
    func actualizarChart(){
        
        var pesos = ["70","75","80.5","75","80.5","85.5","80.5"]
        var fechas = ["02/06/2018","03/06/2018","05/06/2018","08/06/2018","12/06/2018","13/06/2018","14/06/2018"]
        
        let nuevafecha = "08/06/2018"
        //busca dias repetidos
//
//        for (index, element) in fechas.enumerated() {
//            if fechas[index] == nuevafecha {
//
//            }
//        }
        
        let doublePesos = pesos.compactMap{Double(String($0))}
        var intDias = Array(repeating: 0, count: fechas.count)
        

        
        for (index, element) in fechas.enumerated() {
            intDias[index] = segundosADias(primeraFecha: fechas[0], segundaFecha: element)
                    }
        
        
        let pointsSequence = zip(intDias, doublePesos)
        let chartPoints: [(x: Int, y: Double)] = Array(pointsSequence)
        
        print("CHARTPOINTS")
        
        
        
        
        ////////////
        
        let series = ChartSeries(data: chartPoints)
        
        
        chart.xLabelsFormatter = {  "día "  + String(Int(round($1))) }
        chart.xLabelsSkipLast = false
        
        
        chart.yLabelsFormatter = { String($1) + "Kg" }
        
        
        
        
        //   chart.yLabelsFormatter = { String($1)}
        //chart.yLabelsOnRightSide = true
        //chart.showYLabelsAndGrid = false
        chart.yLabels = doublePesos
        
        chart.add(series)
        
        
    }
    
    func fechaStringADate(fechaString: String) -> Date? { //recibe fecha en formato dd/MM/yyy
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        return dateFormatter.date(from: fechaString)
    }
    
    func segundosADias (primeraFecha: String, segundaFecha: String) -> Int{
        let f = fechaStringADate(fechaString: segundaFecha)
        let tiempoEnSegundos = f?.timeIntervalSince(fechaStringADate(fechaString: primeraFecha)!)
        let dias = Int(tiempoEnSegundos!)/86400
        return dias
    }
    
    

    

    
    

}
