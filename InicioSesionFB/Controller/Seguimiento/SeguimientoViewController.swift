//
//  SeguimientoViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 21/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftCharts
import SwipeCellKit

class SeguimientoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

//    fileprivate var chart: Chart? // arc

    
    var pesos: Results<Peso>?
    var medidas: Results<Medidas>?
    
    var ejeYmin = 0
    var ejeYmax = 0
    
    var ejeYminFat = 0
    var ejeYmaxFat = 0
    
    
    @IBOutlet weak var viewPeso: UIView!
    @IBOutlet weak var viewPorcFat: UIView!
    
    @IBOutlet weak var seguimientoTableView: UITableView!
    @IBOutlet weak var porcFatTableView: UITableView!
    
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var chartViewPorcFat: UIView!
    
    fileprivate var chart: Chart? // arc
    fileprivate var chartFat: Chart? // arc

    
    @IBOutlet weak var switchSegmented: UISegmentedControl!
    
    
    @IBAction func switchSegmentedPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewPeso.isHidden = false
            viewPorcFat.isHidden = true
            seguimientoTableView.reloadData()
            break
        case 1:
            let realm = try! Realm()
            
            var premium = (realm.objects(Sesion.self).first?.premium)!
            
            if premium == true {
                
                viewPeso.isHidden = true
                viewPorcFat.isHidden = false
                porcFatTableView.reloadData()
                break
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
                switchSegmented.selectedSegmentIndex = 0
            }
            
        default:
            break
        }
    }
    
    
    @IBAction func botonAgregarDatos(_ sender: UIButton) {
        
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "SeguimientoAgregarDatosViewController") as! SeguimientoAgregarDatosViewController
        present(vc2, animated: true, completion: nil)
        
    }
    
    @IBAction func botonAgregarDatosPorcFat(_ sender: Any) {
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "SeguimientoAgregarPorcFatViewController") as! InicioSesionFB.SegAgregarPorcFatVC
        present(vc2, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ESTOY EN SEGUIMIENTO VIEW CONTROLLER")
        let realm = try! Realm()
        print("URL REALM")
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let id = realm.objects(Sesion.self).first?.userID
        let infoPersona = realm.objects(Persona.self).filter("userID == %@", id).first
        pesos = infoPersona!.pesos.sorted(byKeyPath: "fechaRegistro", ascending: false)
        medidas = infoPersona!.medidas.sorted(byKeyPath: "fechaRegistro", ascending: false)
        
            seguimientoTableView.delegate = self
            seguimientoTableView.dataSource = self
            
            seguimientoTableView.register(UINib(nibName: "SeguimientoTableViewCell", bundle: nil), forCellReuseIdentifier: "seguimientoCustomCell")
            
            porcFatTableView.delegate = self
            porcFatTableView.dataSource = self
            porcFatTableView.register(UINib(nibName: "SegFatTableViewCell", bundle: nil), forCellReuseIdentifier: "segFatCustomCell")

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var filas = 0
        
        if tableView == self.seguimientoTableView {
            print("AAA")
            filas = pesos?.count ?? 1
            print(filas)
        } else {
            print("BBB")
            filas = medidas?.count ?? 1
            print(filas)
        }
            
        return filas
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellToReturn = UITableViewCell() // Dummy value
        
        if tableView == self.seguimientoTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "seguimientoCustomCell", for: indexPath) as! SeguimientoTableViewCell
            
            cell.delegate = self
            
            let pesoVacio = Peso()
            
            let item = pesos?[indexPath.row] ?? pesoVacio
            cell.peso.text = String(item.pesoKg)
            
            //        print("PESOS")
            //        print(pesos)
            //        print("ITEM")
            //        print(item)
            
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let myString = formatter.string(from: item.fechaRegistro!) // string purpose I add here
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "dd-MMM-yyyy"
            // again convert your date to string
            let myStringafd = formatter.string(from: yourDate!)
            
            //print(myStringafd)
            
            cell.fecha.text = myStringafd
            //falta foto
            
            cellToReturn = cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "segFatCustomCell", for: indexPath) as! SegFatTableViewCell
            
            cell.delegate = self
            
            let medidaVacio = Medidas()
            
            let item = medidas?[indexPath.row] ?? medidaVacio
            cell.cadera.text = String(item.cadera)
            cell.cuello.text = String(item.cuello)
            cell.cintura.text = String(item.cintura)
            cell.porcentaje.text = String(item.porcentaje)
            
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let myString = formatter.string(from: item.fechaRegistro!) // string purpose I add here
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "dd-MMM-yyyy"
            // again convert your date to string
            let myStringafd = formatter.string(from: yourDate!)
            
            //print(myStringafd)
            
            cell.fecha.text = myStringafd
            //falta foto
            
            cellToReturn = cell
        }
        
     
        return cellToReturn
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        switchSegmented?.setTitle("Peso", forSegmentAt: 0)
        switchSegmented?.setTitle("% Grasa", forSegmentAt: 1)

        print("VIEWDIDAPPEAR SEGUIMIENTO")
        
        let realm = try! Realm()
        
        
        let id = realm.objects(Sesion.self).first?.userID
        let infoPersona = realm.objects(Persona.self).filter("userID == %@", id).first
        
        pesos = infoPersona!.pesos.sorted(byKeyPath: "fechaRegistro", ascending: false)
        medidas = infoPersona!.medidas.sorted(byKeyPath: "fechaRegistro", ascending: false)
        
        print("pesos")
        print(pesos)
        
        seguimientoTableView.reloadData()
        porcFatTableView.reloadData()
        
        if pesos?.first != nil {
            print("NOSEQUEPONER")
        actualizarChart(pesos: pesos!.sorted(byKeyPath: "fechaRegistro", ascending: true))
        }
        
        if medidas?.first != nil {
            print("NOSEQUEPONER2")
        actualizarChartFat(medidas: medidas!.sorted(byKeyPath: "fechaRegistro", ascending: true))
        }

    }
    
    func roundToFloorFives(x : Double) -> Int {
        return 5 * Int(floor(x / 5.0))
    }
    
    func roundToCeilFives(x : Double) -> Int {
        return 5 * Int(ceil(x / 5.0))
    }
    
    func actualizarChart(pesos: Results<Peso>){

        var mayor = 0.0
        for i in 0..<pesos.count {
            
            if pesos[i].pesoKg > mayor {
                mayor = pesos[i].pesoKg
            }
        }
        
        var menor = 200.0
        for i in 0..<pesos.count {
            if pesos[i].pesoKg < menor {
                menor = pesos[i].pesoKg
            }
        }
        
        ejeYmin = Int(floor(menor))
        ejeYmax = Int(ceil(mayor))
        
        
        
        
        let labelSettings = ChartLabelSettings(font: UIFont(name: "Helvetica", size: 12) ?? UIFont.systemFont(ofSize: 12))
        
        var readFormatter = DateFormatter()
        readFormatter.dateFormat = "dd-MMM-yyyy"
        
        var displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd-MMM"
        
        let date = {(str: String) -> Date in
            return readFormatter.date(from: str)!
        }
        
        let calendar = Calendar.current
        
        let dateWithComponents = {(day: Int, month: Int, year: Int) -> Date in
            var components = DateComponents()
            components.day = day
            components.month = month
            components.year = year
            return calendar.date(from: components)!
        }
        
        func filler(_ date: Date) -> ChartAxisValueDate {
            let filler = ChartAxisValueDate(date: date, formatter: displayFormatter)
            filler.hidden = true
            return filler
        }
        
        
        
        var chartPoints = [ChartPoint]()
        
        for i in 0..<pesos.count {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: pesos[i].fechaRegistro!)
            let yourDate = formatter.date(from: myString)
            formatter.dateFormat = "dd-MMM-yyyy"
            let myStringafd = formatter.string(from: yourDate!)
            print("FECHA EN STRING CHARPOINT")
            print(myStringafd)
            chartPoints.append(            createChartPoint(dateStr: myStringafd, percent: pesos[i].pesoKg, readFormatter: readFormatter, displayFormatter: displayFormatter)
)
        }

        
        
        
//        let diezEnDiez = stride(from: 40, through: 110, by: 10).map {ChartAxisValuePercent($0, labelSettings: labelSettings)}
//        print("DIEZ EN DIEZ")
//        print(diezEnDiez)
        let yValues = stride(from: ejeYmin, through: ejeYmax, by: 1).map {ChartAxisValuePercent($0, labelSettings: labelSettings)}
//        let y = yva==
        
        
        
        var xValues = [ChartAxisValue]()
        
        for i in 0..<pesos.count {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: pesos[i].fechaRegistro!)
            let yourDate = formatter.date(from: myString)
            formatter.dateFormat = "dd-MMM-yyyy"
            let myStringafd = formatter.string(from: yourDate!)
            print("FECHA EN STRING XVALUES")
            xValues.append(createDateAxisValue(myStringafd, readFormatter: readFormatter, displayFormatter: displayFormatter))

        }
        
//        let xValues = [
//            createDateAxisValue("01-Oct-2018", readFormatter: readFormatter, displayFormatter: displayFormatter),
//            createDateAxisValue("012-Oct-2018", readFormatter: readFormatter, displayFormatter: displayFormatter),
//
//
//        ]
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        let chartFrame = CGRect(x: 0, y: 0, width: 400, height: 250)
        var iPhoneChartSettings: ChartSettings {
            var chartSettings = ChartSettings()
            chartSettings.leading = 10
            chartSettings.top = 10
            chartSettings.trailing = 10
            chartSettings.bottom = 10
            chartSettings.labelsToAxisSpacingX = 5
            chartSettings.labelsToAxisSpacingY = 5
            chartSettings.axisTitleLabelsToLabelsSpacing = 4
            chartSettings.axisStrokeWidth = 0.2
            chartSettings.spacingBetweenAxesX = 8
            chartSettings.spacingBetweenAxesY = 8
            chartSettings.labelsSpacing = 0
            return chartSettings
        }
        var iPhoneChartSettingsWithPanZoom: ChartSettings {
            var chartSettings = iPhoneChartSettings
            chartSettings.zoomPan.panEnabled = true
            chartSettings.zoomPan.zoomEnabled = true
            return chartSettings
        }
        var chartSettings = iPhoneChartSettingsWithPanZoom
        chartSettings.trailing = 80
        
        // Set a fixed (horizontal) scrollable area 2x than the original width, with zooming disabled.
        if pesos.count >= 7 {
            chartSettings.zoomPan.maxZoomX = 2 //poner 2 para 2x scroll
            chartSettings.zoomPan.minZoomX = 2 //poner 2 para 2x scroll
            chartSettings.zoomPan.minZoomY = 1
            chartSettings.zoomPan.maxZoomY = 1
        } else {
            chartSettings.zoomPan.maxZoomX = 1 //poner 2 para 2x scroll
            chartSettings.zoomPan.minZoomX = 1 //poner 2 para 2x scroll
            chartSettings.zoomPan.minZoomY = 1
            chartSettings.zoomPan.maxZoomY = 1
        }

        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.yellow, lineWidth: 3, animDuration: 1, animDelay: 0)
        
        // delayInit parameter is needed by some layers for initial zoom level to work correctly. Setting it to true allows to trigger drawing of layer manually (in this case, after the chart is initialized). This obviously needs improvement. For now it's necessary.
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel], delayInit: true)
        
        let guidelinesLayerSettings = ChartGuideLinesLayerSettings(linesColor: UIColor.black, linesWidth: 0.3)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: guidelinesLayerSettings)
        
        
        
        
        
        let viewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
            let center = chartPointModel.screenLoc
            // create a UIView, customize however you want, add labels, borders, images, animations, etc. to it.
            // you also can show it at a different position than center
            
            let vista: UIView = UIView()

            var label = UILabel(frame: CGRect(x: 80, y: 0, width: 40, height: 20))
            let t = chartPoints.count - 1
            print("TOTAL PUNTOS")
            print(t)
            if chartPointModel.index == 0 {
                 label = UILabel(frame: CGRect(x: 20, y: 0, width: 40, height: 20))
//                label.text = chartPointModel.chartPoint.y.description
                label.text = ""
                label.font = UIFont.systemFont(ofSize: 12.0)
            } else if chartPointModel.index == t {
                label = UILabel(frame: CGRect(x: -30, y: -10, width: 40, height: 20))
//                label.text = chartPointModel.chartPoint.y.description
                label.text = ""
                label.font = UIFont.systemFont(ofSize: 12.0)
            } else {
                 label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
//                label.text = chartPointModel.chartPoint.y.description
                label.text = ""
                label.font = UIFont.systemFont(ofSize: 12.0)
            vista.addSubview(label)
            }

            
            
            return vista
        }
        let myCirclesLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: viewGenerator, mode: .translate)

        
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer,
                myCirclesLayer,
            //    touchLayer
            ]
        )
        

        if pesos.count > 1 {
        chartView.addSubview(chart.view)
        }
        
        // Set scrollable area 2x than the original width, with zooming enabled. This can also be combined with e.g. minZoomX to allow only larger zooming levels.
        //        chart.zoom(scaleX: 2, scaleY: 1, centerX: 0, centerY: 0)
        
        // Now that the chart is zoomed (either with minZoom setting or programmatic zooming), trigger drawing of the line layer. Important: This requires delayInit paramter in line layer to be set to true.
        chartPointsLineLayer.initScreenLines(chart)
        
        
        self.chart = chart
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func actualizarChartFat(medidas: Results<Medidas>){
        
        var mayor = 0.0
        for i in 0..<medidas.count {
            
            if medidas[i].porcentaje > mayor {
                mayor = medidas[i].porcentaje
            }
        }
        
        var menor = 200.0
        for i in 0..<medidas.count {
            if medidas[i].porcentaje < menor {
                menor = medidas[i].porcentaje
            }
        }
        
        ejeYminFat = Int(floor(menor))
        ejeYmaxFat = Int(ceil(mayor))
        
        
        
        
        let labelSettings = ChartLabelSettings(font: UIFont(name: "Helvetica", size: 12) ?? UIFont.systemFont(ofSize: 12))
        
        var readFormatter = DateFormatter()
        readFormatter.dateFormat = "dd-MMM-yyyy"
        
        var displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd-MMM"
        
        let date = {(str: String) -> Date in
            return readFormatter.date(from: str)!
        }
        
        let calendar = Calendar.current
        
        let dateWithComponents = {(day: Int, month: Int, year: Int) -> Date in
            var components = DateComponents()
            components.day = day
            components.month = month
            components.year = year
            return calendar.date(from: components)!
        }
        
        func filler(_ date: Date) -> ChartAxisValueDate {
            let filler = ChartAxisValueDate(date: date, formatter: displayFormatter)
            filler.hidden = true
            return filler
        }
        
        
        
        var chartPoints = [ChartPoint]()
        
        for i in 0..<medidas.count {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: medidas[i].fechaRegistro!)
            let yourDate = formatter.date(from: myString)
            formatter.dateFormat = "dd-MMM-yyyy"
            let myStringafd = formatter.string(from: yourDate!)
            print("FECHA EN STRING CHARPOINT")
            print(myStringafd)
            chartPoints.append(            createChartPoint(dateStr: myStringafd, percent: medidas[i].porcentaje, readFormatter: readFormatter, displayFormatter: displayFormatter)
            )
        }
        
        
        
        
        //        let diezEnDiez = stride(from: 40, through: 110, by: 10).map {ChartAxisValuePercent($0, labelSettings: labelSettings)}
        //        print("DIEZ EN DIEZ")
        //        print(diezEnDiez)
        let yValues = stride(from: ejeYminFat, through: ejeYmaxFat, by: 1).map {ChartAxisValuePercent($0, labelSettings: labelSettings)}
        //        let y = yva==
        
        
        
        var xValues = [ChartAxisValue]()
        
        for i in 0..<medidas.count {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: medidas[i].fechaRegistro!)
            let yourDate = formatter.date(from: myString)
            formatter.dateFormat = "dd-MMM-yyyy"
            let myStringafd = formatter.string(from: yourDate!)
            print("FECHA EN STRING XVALUES")
            xValues.append(createDateAxisValue(myStringafd, readFormatter: readFormatter, displayFormatter: displayFormatter))
            
        }
        
        //        let xValues = [
        //            createDateAxisValue("01-Oct-2018", readFormatter: readFormatter, displayFormatter: displayFormatter),
        //            createDateAxisValue("012-Oct-2018", readFormatter: readFormatter, displayFormatter: displayFormatter),
        //
        //
        //        ]
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        let chartFrame = CGRect(x: 0, y: 0, width: 400, height: 250)
        var iPhoneChartSettings: ChartSettings {
            var chartSettings = ChartSettings()
            chartSettings.leading = 10
            chartSettings.top = 10
            chartSettings.trailing = 10
            chartSettings.bottom = 10
            chartSettings.labelsToAxisSpacingX = 5
            chartSettings.labelsToAxisSpacingY = 5
            chartSettings.axisTitleLabelsToLabelsSpacing = 4
            chartSettings.axisStrokeWidth = 0.2
            chartSettings.spacingBetweenAxesX = 8
            chartSettings.spacingBetweenAxesY = 8
            chartSettings.labelsSpacing = 0
            return chartSettings
        }
        var iPhoneChartSettingsWithPanZoom: ChartSettings {
            var chartSettings = iPhoneChartSettings
            chartSettings.zoomPan.panEnabled = true
            chartSettings.zoomPan.zoomEnabled = true
            return chartSettings
        }
        var chartSettings = iPhoneChartSettingsWithPanZoom
        chartSettings.trailing = 80
        
        // Set a fixed (horizontal) scrollable area 2x than the original width, with zooming disabled.
        if medidas.count >= 7 {
            chartSettings.zoomPan.maxZoomX = 2 //poner 2 para 2x scroll
            chartSettings.zoomPan.minZoomX = 2 //poner 2 para 2x scroll
            chartSettings.zoomPan.minZoomY = 1
            chartSettings.zoomPan.maxZoomY = 1
        } else {
            chartSettings.zoomPan.maxZoomX = 1 //poner 2 para 2x scroll
            chartSettings.zoomPan.minZoomX = 1 //poner 2 para 2x scroll
            chartSettings.zoomPan.minZoomY = 1
            chartSettings.zoomPan.maxZoomY = 1
        }
        
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.yellow, lineWidth: 3, animDuration: 1, animDelay: 0)
        
        // delayInit parameter is needed by some layers for initial zoom level to work correctly. Setting it to true allows to trigger drawing of layer manually (in this case, after the chart is initialized). This obviously needs improvement. For now it's necessary.
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel], delayInit: true)
        
        let guidelinesLayerSettings = ChartGuideLinesLayerSettings(linesColor: UIColor.black, linesWidth: 0.3)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: guidelinesLayerSettings)
        
        
        
        
        
        let viewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsViewsLayer, chart: Chart) -> UIView? in
            let center = chartPointModel.screenLoc
            // create a UIView, customize however you want, add labels, borders, images, animations, etc. to it.
            // you also can show it at a different position than center
            
            let vista: UIView = UIView()
            
            var label = UILabel(frame: CGRect(x: 80, y: 0, width: 40, height: 20))
            let t = chartPoints.count - 1
            print("TOTAL PUNTOS")
            print(t)
            if chartPointModel.index == 0 {
                label = UILabel(frame: CGRect(x: 20, y: 0, width: 40, height: 20))
                //                label.text = chartPointModel.chartPoint.y.description
                label.text = ""
                label.font = UIFont.systemFont(ofSize: 12.0)
            } else if chartPointModel.index == t {
                label = UILabel(frame: CGRect(x: -30, y: -10, width: 40, height: 20))
                //                label.text = chartPointModel.chartPoint.y.description
                label.text = ""
                label.font = UIFont.systemFont(ofSize: 12.0)
            } else {
                label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
                //                label.text = chartPointModel.chartPoint.y.description
                label.text = ""
                label.font = UIFont.systemFont(ofSize: 12.0)
                vista.addSubview(label)
            }
            
            
            
            return vista
        }
        let myCirclesLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: viewGenerator, mode: .translate)
        
        
        
        let chartFat = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer,
                myCirclesLayer,
                //    touchLayer
            ]
        )
        
        
        if medidas.count > 1 {
            chartViewPorcFat.addSubview(chartFat.view)
        }
        
        // Set scrollable area 2x than the original width, with zooming enabled. This can also be combined with e.g. minZoomX to allow only larger zooming levels.
        //        chart.zoom(scaleX: 2, scaleY: 1, centerX: 0, centerY: 0)
        
        // Now that the chart is zoomed (either with minZoom setting or programmatic zooming), trigger drawing of the line layer. Important: This requires delayInit paramter in line layer to be set to true.
        chartPointsLineLayer.initScreenLines(chartFat)
        
        
        self.chartFat = chartFat
        
    }
    
    
    
    
    
    
    
    
    
    
    func createChartPoint(dateStr: String, percent: Double, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartPoint {
        return ChartPoint(x: createDateAxisValue(dateStr, readFormatter: readFormatter, displayFormatter: displayFormatter), y: ChartAxisValuePercent(percent))
    }
    
    func createDateAxisValue(_ dateStr: String, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartAxisValue {
        let date = readFormatter.date(from: dateStr)!
        let labelSettings = ChartLabelSettings(font: UIFont(name: "Helvetica", size: 12) ?? UIFont.systemFont(ofSize: 12))
        return ChartAxisValueDate(date: date, formatter: displayFormatter, labelSettings: labelSettings)
    }
    
    class ChartAxisValuePercent: ChartAxisValueDouble {
        override var description: String {
            return "\(formatter.string(from: NSNumber(value: scalar))!)Kg"
        }
    }
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {

        chart?.view.removeFromSuperview()
    }
    
    
    
    
    
    
    func fechaStringADate(fechaString: String) -> Date? { //recibe fecha en formato dd/MM/yyy
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        return dateFormatter.date(from: fechaString)
    }
    

}


extension SeguimientoViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        


        guard orientation == .right else { return nil }
        let realm = try! Realm()
        //var del =
        let deleteAction = SwipeAction(style: .destructive, title: "Borrar") { action, indexPath in

            if tableView == self.seguimientoTableView {
                if let pesoABorrar = self.pesos?[indexPath.row]{
                    
                    do{
                        try! realm.write {
                            realm.delete(pesoABorrar)
                        }
                    } catch {
                        print("ERROR BORRAR REALM")
                        print(error)
                    }
                    self.chart?.view.removeFromSuperview()
                    if self.pesos?.first != nil {
                    self.actualizarChart(pesos: self.pesos!.sorted(byKeyPath: "fechaRegistro", ascending: true))
                    }
                }
            } else {
                if let medidaABorrar = self.medidas?[indexPath.row]{
                    
                    do{
                        try! realm.write {
                            realm.delete(medidaABorrar)
                        }
                    } catch {
                        print("ERROR BORRAR REALM")
                        print(error)
                    }
                    self.chartFat?.view.removeFromSuperview()
                    if self.medidas?.first != nil {
                    self.actualizarChartFat(medidas: self.medidas!.sorted(byKeyPath: "fechaRegistro", ascending: true))
                    }
                }
            }
            

            
            
            
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon.png")
//        del = deleteAction
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }

}
