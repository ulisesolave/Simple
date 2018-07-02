//
//  PrincipalViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 7/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var inicioTableView: UITableView!
  
    
  
    
    //dias y fechas
    @IBOutlet weak var d1: UIButton!
    @IBOutlet weak var d2: UIButton!
    @IBOutlet weak var d3: UIButton!
    @IBOutlet weak var d4: UIButton!
    @IBOutlet weak var d5: UIButton!
    @IBOutlet weak var d6: UIButton!
    @IBOutlet weak var d7: UIButton!
    
    //
 
    var nombreUsuario = ""
    var correoUsuario = ""
    var urlFotoUsuario = NSURL()
    
    //esto es fijo

    let comida = ["Desayuno","Merienda","Almuerzo","Cena"]

    var diaElegido = ""
    
    @IBAction func pressedD1(_ sender: UIButton) {
        diaElegido = "Monday"
        inicioTableView.reloadData()
        d1.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    @IBAction func pressedD2(_ sender: UIButton) {
        diaElegido = "Tuesday"
        inicioTableView.reloadData()
        d2.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    @IBAction func pressedD3(_ sender: Any) {
        diaElegido = "Wednesday"
        inicioTableView.reloadData()
        d3.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)

    }
    
    @IBAction func pressedD4(_ sender: UIButton) {
        diaElegido = "Thursday"
        inicioTableView.reloadData()
        d4.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    @IBAction func pressedD5(_ sender: UIButton) {
        diaElegido = "Friday"
        inicioTableView.reloadData()
        d5.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    @IBAction func pressedD6(_ sender: UIButton) {
        diaElegido = "Saturday"
        inicioTableView.reloadData()
        d6.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    @IBAction func pressedD7(_ sender: UIButton) {
        diaElegido = "Sunday"
        inicioTableView.reloadData()
        d7.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    
    func dietaDia(dia: String) -> [[String]]{
    
   
        //esto es variable
    var dieta = [ ["","",""],["","",""],["","",""],["","",""] ]
    
        
    switch dia {
    case "Monday":
         dieta = [["p_des_1","g_des_1","c_des_1"],
                       ["p_mer_1","g_mer_1","c_mer_1"],
                       ["p_alm_1","g_alm_1","c_alm_1"],
                       ["p_cen_1","g_cen_1","c_cen_1"]]

    case "Tuesday":
         dieta = [["p_des_2","g_des_2","c_des_2"],
                                  ["p_mer_2","g_mer_2","c_mer_2"],
                                  ["p_alm_2","g_alm_2","c_alm_2"],
                                  ["p_cen_2","g_cen_2","c_cen_2"]]
    case "Wednesday":
         dieta = [["p_des_3","g_des_3","c_des_3"],
                              ["p_mer_3","g_mer_3","c_mer_3"],
                              ["p_alm_3","g_alm_3","c_alm_3"],
                              ["p_cen_3","g_cen_3","c_cen_3"]]
    
    case "Thursday":
        dieta = [["p_des_4","g_des_4","c_des_4"],
                 ["p_mer_4","g_mer_4","c_mer_4"],
                 ["p_alm_4","g_alm_4","c_alm_4"],
                 ["p_cen_4","g_cen_4","c_cen_4"]]
    case "Friday":
        dieta = [["p_des_5","g_des_5","c_des_5"],
                 ["p_mer_5","g_mer_5","c_mer_5"],
                 ["p_alm_5","g_alm_5","c_alm_5"],
                 ["p_cen_5","g_cen_5","c_cen_5"]]
    case "Saturday":
        dieta = [["p_des_6","g_des_6","c_des_6"],
                 ["p_mer_6","g_mer_6","c_mer_6"],
                 ["p_alm_6","g_alm_6","c_alm_6"],
                 ["p_cen_6","g_cen_6","c_cen_6"]]
    case "Sunday":
        dieta = [["p_des_7","g_des_7","c_des_7"],
                 ["p_mer_7","g_mer_7","c_mer_7"],
                 ["p_alm_7","g_alm_7","c_alm_7"],
                 ["p_cen_7","g_cen_7","c_cen_7"]]
    default:
    print("NO DEBERIA ENTRAR ACA 2")
    }
    
    return dieta
    }
    
    let items = [["Huevos","Palta","Tostada"],
                 ["ProteMediodia","GrasaMediodia","CarboMediodia"],
                 ["Carne","Palta","Arroz"],
                 ["Pollo","Grasa3","Carb3"]]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-------")
        print("ESTOY EN PRINCIPALVIEWCONTROLLER")
       
      //  let items = armarDieta()

        
        
        fechas()
        inicioTableView.delegate = self
        inicioTableView.dataSource = self
        
    }
    
    
    func aNumero(fecha: Date) -> String{
        let diaNumero = DateFormatter()
        diaNumero.dateFormat = "dd"
        let dateNumber = diaNumero.string(from: fecha)
        return dateNumber
    }
    
    func aLetra(fecha: Date) -> String{
        let diaNombre = DateFormatter()
        diaNombre.dateFormat = "EEEE"
        let dateName = diaNombre.string(from: fecha)
        return dateName
    }

    func fechas(){
        let date = Date()
        let diaNombre = DateFormatter()
        diaNombre.dateFormat = "EEEE"
        let dateName = diaNombre.string(from: date)
        
        //botones fondo circular
        d1.layer.cornerRadius = d3.frame.size.width/2
        d1.clipsToBounds = true
        d2.layer.cornerRadius = d3.frame.size.width/2
        d2.clipsToBounds = true
        d3.layer.cornerRadius = d3.frame.size.width/2
        d3.clipsToBounds = true
        d4.layer.cornerRadius = d3.frame.size.width/2
        d4.clipsToBounds = true
        d5.layer.cornerRadius = d3.frame.size.width/2
        d5.clipsToBounds = true
        d6.layer.cornerRadius = d3.frame.size.width/2
        d6.clipsToBounds = true
        d7.layer.cornerRadius = d3.frame.size.width/2
        d7.clipsToBounds = true
        
        
        switch dateName {
        case "Monday":
            print("HOY ES LUNES")
            d1.setTitle(aNumero(fecha: Date()), for: .normal)
            d1.setTitleColor(.red, for: .normal)
            d2.setTitle(aNumero(fecha: Date().mas1), for: .normal)
            d3.setTitle(aNumero(fecha: Date().mas2), for: .normal)
            d4.setTitle(aNumero(fecha: Date().mas3), for: .normal)
            d5.setTitle(aNumero(fecha: Date().mas5), for: .normal)
            d6.setTitle(aNumero(fecha: Date().mas5), for: .normal)
            d7.setTitle(aNumero(fecha: Date().mas6), for: .normal)
        case "Tuesday":
            print("HOY ES MARTES")
            d1.setTitle(aNumero(fecha: Date().menos1), for: .normal)
            d2.setTitle(aNumero(fecha: Date()), for: .normal)
            d2.setTitleColor(.red, for: .normal)
            d3.setTitle(aNumero(fecha: Date().mas1), for: .normal)
            d4.setTitle(aNumero(fecha: Date().mas2), for: .normal)
            d5.setTitle(aNumero(fecha: Date().mas3), for: .normal)
            d6.setTitle(aNumero(fecha: Date().mas4), for: .normal)
            d7.setTitle(aNumero(fecha: Date().mas5), for: .normal)
        case "Wednesday":
            print("HOY ES MIERCOLES")
            d1.setTitle(aNumero(fecha: Date().menos2), for: .normal)
            d2.setTitle(aNumero(fecha: Date().menos1), for: .normal)
            d3.setTitle(aNumero(fecha: Date()), for: .normal)
            d3.setTitleColor(.red, for: .normal)
            d4.setTitle(aNumero(fecha: Date().mas1), for: .normal)
            d5.setTitle(aNumero(fecha: Date().mas2), for: .normal)
            d6.setTitle(aNumero(fecha: Date().mas3), for: .normal)
            d7.setTitle(aNumero(fecha: Date().mas4), for: .normal)

        case "Thursday":
            print("HOY ES JUEVES")
            d1.setTitle(aNumero(fecha: Date().menos3), for: .normal)
            d2.setTitle(aNumero(fecha: Date().menos2), for: .normal)
            d3.setTitle(aNumero(fecha: Date().menos1), for: .normal)
            d4.setTitle(aNumero(fecha: Date()), for: .normal)
            d4.setTitleColor(.red, for: .normal)
            d5.setTitle(aNumero(fecha: Date().mas1), for: .normal)
            d6.setTitle(aNumero(fecha: Date().mas2), for: .normal)
            d7.setTitle(aNumero(fecha: Date().mas3), for: .normal)
        case "Friday":
            print("HOY ES VIERNES")
            d1.setTitle(aNumero(fecha: Date().menos4), for: .normal)
            d2.setTitle(aNumero(fecha: Date().menos3), for: .normal)
            d3.setTitle(aNumero(fecha: Date().menos2), for: .normal)
            d4.setTitle(aNumero(fecha: Date().menos1), for: .normal)
            d5.setTitle(aNumero(fecha: Date()), for: .normal)
            d5.setTitleColor(.red, for: .normal)
            d6.setTitle(aNumero(fecha: Date().mas1), for: .normal)
            d7.setTitle(aNumero(fecha: Date().mas2), for: .normal)
        case "Saturday":
            print("HOY ES SABADO")
            d1.setTitle(aNumero(fecha: Date().menos5), for: .normal)
            d2.setTitle(aNumero(fecha: Date().menos4), for: .normal)
            d3.setTitle(aNumero(fecha: Date().menos3), for: .normal)
            d4.setTitle(aNumero(fecha: Date().menos2), for: .normal)
            d5.setTitle(aNumero(fecha: Date().menos1), for: .normal)
            d6.setTitle(aNumero(fecha: Date()), for: .normal)
            d6.setTitleColor(.red, for: .normal)
            d7.setTitle(aNumero(fecha: Date().mas1), for: .normal)
        case "Sunday":
            print("HOY ES DOMINGO")
            d1.setTitle(aNumero(fecha: Date().menos6), for: .normal)
            d2.setTitle(aNumero(fecha: Date().menos5), for: .normal)
            d3.setTitle(aNumero(fecha: Date().menos4), for: .normal)
            d4.setTitle(aNumero(fecha: Date().menos3), for: .normal)
            d5.setTitle(aNumero(fecha: Date().menos2), for: .normal)
            d6.setTitle(aNumero(fecha: Date().menos1), for: .normal)
            d7.setTitle(aNumero(fecha: Date()), for: .normal)
            d7.setTitleColor(.red, for: .normal)
        default:
            print("NO DEBERIA ENTRAR ACA")
        }
        
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellInicio", for: indexPath)
        
        let date = Date()
        let diaNombre = DateFormatter()
        diaNombre.dateFormat = "EEEE"
        let dateName = diaNombre.string(from: date)
        if self.diaElegido == "" {
            self.diaElegido = dateName
        }
        cell.textLabel?.text = dietaDia(dia: self.diaElegido)[indexPath.section][indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return comida[section]
    }
    
    //solo para centrar titulo de header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = NSTextAlignment.center
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.dietaDia(dia: self.diaElegido)[section].count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.comida.count
    }
    

 
    
    
    
}



extension Date {
    var menos1: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var menos2: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
    var menos3: Date {
        return Calendar.current.date(byAdding: .day, value: -3, to: noon)!
    }
    var menos4: Date {
        return Calendar.current.date(byAdding: .day, value: -4, to: noon)!
    }
    var menos5: Date {
        return Calendar.current.date(byAdding: .day, value: -5, to: noon)!
    }
    var menos6: Date {
        return Calendar.current.date(byAdding: .day, value: -6, to: noon)!
    }
    
    
    
    var mas1: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var mas2: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: noon)!
    }
    var mas3: Date {
        return Calendar.current.date(byAdding: .day, value: 3, to: noon)!
    }
    var mas4: Date {
        return Calendar.current.date(byAdding: .day, value: 4, to: noon)!
    }
    var mas5: Date {
        return Calendar.current.date(byAdding: .day, value: 5, to: noon)!
    }
    var mas6: Date {
        return Calendar.current.date(byAdding: .day, value: 6, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
}
