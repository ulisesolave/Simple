//
//  RegistroViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 21/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class RegistroViewController: UIViewController//, UITableViewDelegate, UITableViewDataSource
{

    var premium = false
    
    var contCambioAlimentos = 0
    
    var misItems: Results<AlimentosBase>?
    var alimentosSeleccionados: Results<AlimentosBase>?

    var listaInicio = [Int]()

    
//    @IBOutlet weak var misAlimentosTableView: UITableView!
    
    @IBOutlet weak var viewProteinas: UIView!
    @IBOutlet weak var viewCarb: UIView!
    @IBOutlet weak var viewFat: UIView!
    @IBOutlet weak var viewLact: UIView!
    @IBOutlet weak var viewFrutas: UIView!
    
    //outlets para poner bordes
    @IBOutlet weak var p1: UIButton!
    @IBOutlet weak var p2: UIButton!
    @IBOutlet weak var p3: UIButton!
    @IBOutlet weak var p4: UIButton!
    @IBOutlet weak var p5: UIButton!
    @IBOutlet weak var p6: UIButton!
    @IBOutlet weak var p7: UIButton!
    @IBOutlet weak var p8: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var c4: UIButton!
    @IBOutlet weak var c5: UIButton!
    @IBOutlet weak var c6: UIButton!
    @IBOutlet weak var c7: UIButton!
    @IBOutlet weak var c8: UIButton!
    @IBOutlet weak var c9: UIButton!
    @IBOutlet weak var c10: UIButton!
    @IBOutlet weak var c11: UIButton!
    @IBOutlet weak var c12: UIButton!
    
    @IBOutlet weak var f1: UIButton!
    @IBOutlet weak var f2: UIButton!
    @IBOutlet weak var f3: UIButton!
    @IBOutlet weak var f4: UIButton!
    @IBOutlet weak var f5: UIButton!
    @IBOutlet weak var f6: UIButton!
    @IBOutlet weak var f7: UIButton!
    @IBOutlet weak var f8: UIButton!

    @IBOutlet weak var l1: UIButton!
    @IBOutlet weak var l2: UIButton!
    @IBOutlet weak var l3: UIButton!
    
    @IBOutlet weak var fr1: UIButton!
    @IBOutlet weak var fr2: UIButton!
    @IBOutlet weak var fr3: UIButton!
    @IBOutlet weak var fr4: UIButton!
    @IBOutlet weak var fr5: UIButton!
    @IBOutlet weak var fr6: UIButton!
    @IBOutlet weak var fr7: UIButton!
    @IBOutlet weak var fr8: UIButton!
    @IBOutlet weak var fr9: UIButton!
    @IBOutlet weak var fr10: UIButton!
    @IBOutlet weak var fr11: UIButton!
    @IBOutlet weak var fr12: UIButton!
    @IBOutlet weak var fr13: UIButton!
    @IBOutlet weak var fr14: UIButton!
    @IBOutlet weak var fr15: UIButton!
    

    var cuentaP = 0
    var cuentaF = 0
    var cuentaC = 0
    var cuentaL = 0
    var cuentaFr = 0
    

    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return misItems?.count ?? 1
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MisAlimentosCustomCell", for: indexPath) as! MisAlimentosTableViewCell
//
//
//        let alimentoVacio = AlimentosBase()
//
//        let item = misItems?[indexPath.row] ?? alimentoVacio
//
//        cell.nombre.text = item.nombre
//        cell.prot.text = String(item.prot)
//        cell.fat.text = String(item.fat)
//        cell.carb.text = String(item.carb)
//
//        print("ITEM")
//        print(item)
//
//        return cell
//
//    }
    
    
//    @IBAction func agregarAlimentosPressed(_ sender: UIButton) {
//        let vc2 = storyboard?.instantiateViewController(withIdentifier: "AgregarMisAlimentosVC") as! AgregarMisAlimentosVC
//        present(vc2, animated: true, completion: nil)
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        var cambio = false
        
        //primero veo si tienen el mismo tama;o, sino saldra error abajo
        if listaInicio.count != alimentosSeleccionados?.count {
                cambio = true
        } else {
            for i in 0..<alimentosSeleccionados!.count {
                if listaInicio[i] != alimentosSeleccionados![i].id {
                    cambio = true
                }
            }
            
        }
        
        
        
        print("CAMBIO?")
        print(cambio)
        
        if cambio == true {
            
        let realm = try! Realm()
        let id = realm.objects(Sesion.self).first?.userID
        var dieta = realm.objects(Dieta.self).filter("ANY parentPersona.userID == %@", id!)
        
        do {
            try realm.write {
                dieta.first?.rehacerDieta = true
                dieta.first?.contCambioAlimentos = (dieta.first?.contCambioAlimentos)! + 1
            }
        } catch {
            print("ERROR REALM")
            print(error)
        }

        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        

        print("VIEWDIDAPPEAR SEGUIMIENTO")
        
        let realm = try! Realm()
        let id = realm.objects(Sesion.self).first?.userID


        premium = (realm.objects(Sesion.self).first?.premium)!
        
        var dieta = realm.objects(Dieta.self).filter("ANY parentPersona.userID == %@", id!)
        contCambioAlimentos = (dieta.first?.contCambioAlimentos)!

        if premium == false {
        if contCambioAlimentos < 1 {
            let alert = UIAlertController(title: "Aviso", message: "Solo puedes cambiar una vez estos alimentos en la versión free.", preferredStyle: UIAlertController.Style.alert)
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
        
        cuentaP = realm.objects(AlimentosBase.self).filter("seleccionado = true AND tipoMacro = 'Proteina' AND ANY parentPersona.userID == %@", id!).count
        cuentaF = realm.objects(AlimentosBase.self).filter("seleccionado = true AND tipoMacro = 'Grasa' AND ANY parentPersona.userID == %@", id!).count
        cuentaC = realm.objects(AlimentosBase.self).filter("seleccionado = true AND tipoMacro = 'Carbohidrato' AND ANY parentPersona.userID == %@", id!).count
        cuentaL = realm.objects(AlimentosBase.self).filter("seleccionado = true AND tipoMacro = 'Lacteo' AND ANY parentPersona.userID == %@", id!).count
        cuentaFr = realm.objects(AlimentosBase.self).filter("seleccionado = true AND tipoMacro = 'Fruta' AND ANY parentPersona.userID == %@", id!).count

      

        //poner userid
       // misItems = realm.objects(AlimentosBase.self).filter("miItem = true")
        
        
//        print("misItems")
//        print(misItems)
        
//        misAlimentosTableView.reloadData()
        
        alimentosSeleccionados = realm.objects(AlimentosBase.self).filter("seleccionado = true AND ANY parentPersona.userID == %@", id!)
        
        //para armar el arreglo de lista inicial
        listaInicio.removeAll()
        for i in 0..<alimentosSeleccionados!.count {
            listaInicio.append(alimentosSeleccionados![i].id)
        }

        
        for i in 0..<alimentosSeleccionados!.count {

            if alimentosSeleccionados![i].id == 0 {
                p1.layer.borderWidth = 2;
                p1.layer.cornerRadius = 7;
                p1.layer.masksToBounds = true;
                p1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                p1.isSelected = true
            } else if alimentosSeleccionados![i].id == 1 {
                p2.layer.borderWidth = 2;
                p2.layer.cornerRadius = 7;
                p2.layer.masksToBounds = true;
                p2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                p2.isSelected = true
            } else if alimentosSeleccionados![i].id == 2 {
                p3.layer.borderWidth = 2;
                p3.layer.cornerRadius = 7;
                p3.layer.masksToBounds = true;
                p3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                p3.isSelected = true
            } else if alimentosSeleccionados![i].id == 3 {
                p4.layer.borderWidth = 2;
                p4.layer.cornerRadius = 7;
                p4.layer.masksToBounds = true;
                p4.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                p4.isSelected = true
            } else if alimentosSeleccionados![i].id == 4 {
                p5.layer.borderWidth = 2;
                p5.layer.cornerRadius = 7;
                p5.layer.masksToBounds = true;
                p5.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                p5.isSelected = true
            } else if alimentosSeleccionados![i].id == 5 {
                p6.layer.borderWidth = 2;
                p6.layer.cornerRadius = 7;
                p6.layer.masksToBounds = true;
                p6.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                p6.isSelected = true
            } else if alimentosSeleccionados![i].id == 6 {
                p7.layer.borderWidth = 2;
                p7.layer.cornerRadius = 7;
                p7.layer.masksToBounds = true;
                p7.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                p7.isSelected = true
            } else if alimentosSeleccionados![i].id == 7 {
                p8.layer.borderWidth = 2;
                p8.layer.cornerRadius = 7;
                p8.layer.masksToBounds = true;
                p8.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                p8.isSelected = true
            } else if alimentosSeleccionados![i].id == 50 {
                c1.layer.borderWidth = 2;
                c1.layer.cornerRadius = 7;
                c1.layer.masksToBounds = true;
                c1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c1.isSelected = true
            } else if alimentosSeleccionados![i].id == 51 {
                c2.layer.borderWidth = 2;
                c2.layer.cornerRadius = 7;
                c2.layer.masksToBounds = true;
                c2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c2.isSelected = true
            } else if alimentosSeleccionados![i].id == 52 {
                c3.layer.borderWidth = 2;
                c3.layer.cornerRadius = 7;
                c3.layer.masksToBounds = true;
                c3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c3.isSelected = true
            } else if alimentosSeleccionados![i].id == 53 {
                c4.layer.borderWidth = 2;
                c4.layer.cornerRadius = 7;
                c4.layer.masksToBounds = true;
                c4.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c4.isSelected = true
            } else if alimentosSeleccionados![i].id == 54 {
                c5.layer.borderWidth = 2;
                c5.layer.cornerRadius = 7;
                c5.layer.masksToBounds = true;
                c5.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c5.isSelected = true
            } else if alimentosSeleccionados![i].id == 55 {
                c6.layer.borderWidth = 2;
                c6.layer.cornerRadius = 7;
                c6.layer.masksToBounds = true;
                c6.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c6.isSelected = true
            } else if alimentosSeleccionados![i].id == 56 {
                c7.layer.borderWidth = 2;
                c7.layer.cornerRadius = 7;
                c7.layer.masksToBounds = true;
                c7.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c7.isSelected = true
            } else if alimentosSeleccionados![i].id == 57 {
                c8.layer.borderWidth = 2;
                c8.layer.cornerRadius = 7;
                c8.layer.masksToBounds = true;
                c8.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c8.isSelected = true
            } else if alimentosSeleccionados![i].id == 58 {
                c9.layer.borderWidth = 2;
                c9.layer.cornerRadius = 7;
                c9.layer.masksToBounds = true;
                c9.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c9.isSelected = true
            } else if alimentosSeleccionados![i].id == 59 {
                c10.layer.borderWidth = 2;
                c10.layer.cornerRadius = 7;
                c10.layer.masksToBounds = true;
                c10.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c10.isSelected = true
            } else if alimentosSeleccionados![i].id == 60 {
                c11.layer.borderWidth = 2;
                c11.layer.cornerRadius = 7;
                c11.layer.masksToBounds = true;
                c11.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c11.isSelected = true
            } else if alimentosSeleccionados![i].id == 61 {
                c12.layer.borderWidth = 2;
                c12.layer.cornerRadius = 7;
                c12.layer.masksToBounds = true;
                c12.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                c12.isSelected = true
            } else if alimentosSeleccionados![i].id == 100 {
                f1.layer.borderWidth = 2;
                f1.layer.cornerRadius = 7;
                f1.layer.masksToBounds = true;
                f1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                f1.isSelected = true
            } else if alimentosSeleccionados![i].id == 101 {
                f2.layer.borderWidth = 2;
                f2.layer.cornerRadius = 7;
                f2.layer.masksToBounds = true;
                f2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                f2.isSelected = true
            } else if alimentosSeleccionados![i].id == 102 {
                f3.layer.borderWidth = 2;
                f3.layer.cornerRadius = 7;
                f3.layer.masksToBounds = true;
                f3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                f3.isSelected = true
            } else if alimentosSeleccionados![i].id == 103 {
                f4.layer.borderWidth = 2;
                f4.layer.cornerRadius = 7;
                f4.layer.masksToBounds = true;
                f4.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                f4.isSelected = true
            } else if alimentosSeleccionados![i].id == 104 {
                f5.layer.borderWidth = 2;
                f5.layer.cornerRadius = 7;
                f5.layer.masksToBounds = true;
                f5.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                f5.isSelected = true
            } else if alimentosSeleccionados![i].id == 105 {
                f6.layer.borderWidth = 2;
                f6.layer.cornerRadius = 7;
                f6.layer.masksToBounds = true;
                f6.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                f6.isSelected = true
            } else if alimentosSeleccionados![i].id == 106 {
                f7.layer.borderWidth = 2;
                f7.layer.cornerRadius = 7;
                f7.layer.masksToBounds = true;
                f7.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                f7.isSelected = true
            } else if alimentosSeleccionados![i].id == 107 {
                f8.layer.borderWidth = 2;
                f8.layer.cornerRadius = 7;
                f8.layer.masksToBounds = true;
                f8.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                f8.isSelected = true
            } else if alimentosSeleccionados![i].id == 150 {
                l1.layer.borderWidth = 2;
                l1.layer.cornerRadius = 7;
                l1.layer.masksToBounds = true;
                l1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                l1.isSelected = true
            } else if alimentosSeleccionados![i].id == 151 {
                l2.layer.borderWidth = 2;
                l2.layer.cornerRadius = 7;
                l2.layer.masksToBounds = true;
                l2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                l2.isSelected = true
            } else if alimentosSeleccionados![i].id == 152 {
                l3.layer.borderWidth = 2;
                l3.layer.cornerRadius = 7;
                l3.layer.masksToBounds = true;
                l3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                l3.isSelected = true
            } else if alimentosSeleccionados![i].id == 200 {
                fr1.layer.borderWidth = 2;
                fr1.layer.cornerRadius = 7;
                fr1.layer.masksToBounds = true;
                fr1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr1.isSelected = true
            } else if alimentosSeleccionados![i].id == 201 {
                fr2.layer.borderWidth = 2;
                fr2.layer.cornerRadius = 7;
                fr2.layer.masksToBounds = true;
                fr2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr2.isSelected = true
            } else if alimentosSeleccionados![i].id == 202 {
                fr3.layer.borderWidth = 2;
                fr3.layer.cornerRadius = 7;
                fr3.layer.masksToBounds = true;
                fr3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr3.isSelected = true
            } else if alimentosSeleccionados![i].id == 203 {
                fr4.layer.borderWidth = 2;
                fr4.layer.cornerRadius = 7;
                fr4.layer.masksToBounds = true;
                fr4.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr4.isSelected = true
            } else if alimentosSeleccionados![i].id == 204 {
                fr5.layer.borderWidth = 2;
                fr5.layer.cornerRadius = 7;
                fr5.layer.masksToBounds = true;
                fr5.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr5.isSelected = true
            } else if alimentosSeleccionados![i].id == 205 {
                fr6.layer.borderWidth = 2;
                fr6.layer.cornerRadius = 7;
                fr6.layer.masksToBounds = true;
                fr6.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr6.isSelected = true
            } else if alimentosSeleccionados![i].id == 206 {
                fr7.layer.borderWidth = 2;
                fr7.layer.cornerRadius = 7;
                fr7.layer.masksToBounds = true;
                fr7.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr7.isSelected = true
            } else if alimentosSeleccionados![i].id == 207 {
                fr8.layer.borderWidth = 2;
                fr8.layer.cornerRadius = 7;
                fr8.layer.masksToBounds = true;
                fr8.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr8.isSelected = true
            } else if alimentosSeleccionados![i].id == 208 {
                fr9.layer.borderWidth = 2;
                fr9.layer.cornerRadius = 7;
                fr9.layer.masksToBounds = true;
                fr9.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr9.isSelected = true
            } else if alimentosSeleccionados![i].id == 209 {
                fr10.layer.borderWidth = 2;
                fr10.layer.cornerRadius = 7;
                fr10.layer.masksToBounds = true;
                fr10.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr10.isSelected = true
            } else if alimentosSeleccionados![i].id == 210 {
                fr11.layer.borderWidth = 2;
                fr11.layer.cornerRadius = 7;
                fr11.layer.masksToBounds = true;
                fr11.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr11.isSelected = true
            } else if alimentosSeleccionados![i].id == 211 {
                fr12.layer.borderWidth = 2;
                fr12.layer.cornerRadius = 7;
                fr12.layer.masksToBounds = true;
                fr12.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr12.isSelected = true
            } else if alimentosSeleccionados![i].id == 212 {
                fr13.layer.borderWidth = 2;
                fr13.layer.cornerRadius = 7;
                fr13.layer.masksToBounds = true;
                fr13.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr13.isSelected = true
            } else if alimentosSeleccionados![i].id == 213 {
                fr14.layer.borderWidth = 2;
                fr14.layer.cornerRadius = 7;
                fr14.layer.masksToBounds = true;
                fr14.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr14.isSelected = true
            } else if alimentosSeleccionados![i].id == 214 {
                fr15.layer.borderWidth = 2;
                fr15.layer.cornerRadius = 7;
                fr15.layer.masksToBounds = true;
                fr15.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
                fr15.isSelected = true
            }
            


        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        misAlimentosTableView.delegate = self
//        misAlimentosTableView.dataSource = self
//        misAlimentosTableView.register(UINib(nibName: "MisAlimentosTableViewCell", bundle: nil), forCellReuseIdentifier: "MisAlimentosCustomCell")

        
        
        viewProteinas.layer.cornerRadius = 11;
        viewProteinas.layer.masksToBounds = true;
        viewProteinas.layer.borderWidth = 3;
        viewProteinas.layer.borderColor = UIColor(red:235/255, green:235/255, blue:249/255, alpha: 1).cgColor
        viewCarb.layer.cornerRadius = 11;
        viewCarb.layer.masksToBounds = true;
        viewCarb.layer.borderWidth = 3;
        viewCarb.layer.borderColor = UIColor(red:235/255, green:235/255, blue:249/255, alpha: 1).cgColor
        viewFat.layer.cornerRadius = 11;
        viewFat.layer.masksToBounds = true;
        viewFat.layer.borderWidth = 3;
        viewFat.layer.borderColor = UIColor(red:235/255, green:235/255, blue:249/255, alpha: 1).cgColor
        viewLact.layer.cornerRadius = 11;
        viewLact.layer.masksToBounds = true;
        viewLact.layer.borderWidth = 3;
        viewLact.layer.borderColor = UIColor(red:235/255, green:235/255, blue:249/255, alpha: 1).cgColor
        viewFrutas.layer.cornerRadius = 11;
        viewFrutas.layer.masksToBounds = true;
        viewFrutas.layer.borderWidth = 3;
        viewFrutas.layer.borderColor = UIColor(red:235/255, green:235/255, blue:249/255, alpha: 1).cgColor
        
        
    }
    

    
    func seleccion(boton: UIButton, id: Int){
        let realm = try! Realm()
        
        let uid = realm.objects(Sesion.self).first?.userID
        let item = realm.objects(AlimentosBase.self).filter("id == %@ AND ANY parentPersona.userID == %@", id, uid!)

        
        if boton.isSelected {
            boton.layer.borderWidth = 0;
            boton.isSelected = false
            
            
                            do {
                                try realm.write {
                                    item.first!.seleccionado = false
                            
                                }
                            }  catch {
                                print("ERROR REALM")
                                print(error)
                            }
            
            
        } else {
            boton.layer.borderWidth = 2;
            boton.layer.cornerRadius = 7;
            boton.layer.masksToBounds = true;
            boton.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
            boton.isSelected = true
            
            
            do {
                try realm.write {
                    item.first!.seleccionado = true
                    
                }
            }  catch {
                print("ERROR REALM")
                print(error)
            }
            
            
        }
        
    }
    
    func cuentaProteinas(boton: UIButton){
        if boton.isSelected {
            cuentaP = cuentaP + 1
        } else {
            cuentaP = cuentaP - 1
        }
        print("CANTIDAD DE PROTEINAS SELECCIONADAS")
        print(cuentaP)
        
    }
    
    func cuentaFat(boton: UIButton){
        if boton.isSelected {
            cuentaF = cuentaF + 1
        } else {
            cuentaF = cuentaF - 1
        }
        print("CANTIDAD DE FAT SELECCIONADAS")
        print(cuentaF)
        
    }
    
    func cuentaCarb(boton: UIButton){
        if boton.isSelected {
            cuentaC = cuentaC + 1
        } else {
            cuentaC = cuentaC - 1
        }
        print("CANTIDAD DE CARB SELECCIONADAS")
        print(cuentaC)
    }
    
    func cuentaLact(boton: UIButton){
        if boton.isSelected {
            cuentaL = cuentaL + 1
        } else {
            cuentaL = cuentaL - 1
        }
        print("CANTIDAD DE LACT SELECCIONADAS")
        print(cuentaL)
    }
    
    func cuentaFrutas(boton: UIButton){
        if boton.isSelected {
            cuentaFr = cuentaFr + 1
        } else {
            cuentaFr = cuentaFr - 1
        }
        print("CANTIDAD DE FRUTAS SELECCIONADAS")
        print(cuentaFr)
    }
    
    
    @IBAction func p1(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: p1, id: 0)
                cuentaProteinas(boton: p1)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: p1, id: 0)
            cuentaProteinas(boton: p1)
        }
    }
    @IBAction func p2(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: p2, id: 1)
                cuentaProteinas(boton: p2)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: p2, id: 1)
            cuentaProteinas(boton: p2)
        }

    }
    @IBAction func p3(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: p3, id: 2)
                cuentaProteinas(boton: p3)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: p3, id: 2)
            cuentaProteinas(boton: p3)
        }

    }
    @IBAction func p4(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: p4, id: 3)
                cuentaProteinas(boton: p4)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: p4, id: 3)
            cuentaProteinas(boton: p4)
        }

    }
    @IBAction func p5(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: p5, id: 4)
                cuentaProteinas(boton: p5)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: p5, id: 4)
            cuentaProteinas(boton: p5)
        }

    }
    @IBAction func p6(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: p6, id: 5)
                cuentaProteinas(boton: p6)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: p6, id: 5)
            cuentaProteinas(boton: p6)
        }

    }
    @IBAction func p7(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: p7, id: 6)
                cuentaProteinas(boton: p7)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: p7, id: 6)
            cuentaProteinas(boton: p7)
        }

    }
    @IBAction func p8(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: p8, id: 7)
                cuentaProteinas(boton: p8)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: p8, id: 7)
            cuentaProteinas(boton: p8)
        }

    }

    
    @IBAction func c1(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c1, id: 50)
                cuentaCarb(boton: c1)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c1, id: 50)
            cuentaCarb(boton: c1)
        }

    }
    @IBAction func c2(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c2, id: 51)
                cuentaCarb(boton: c2)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c2, id: 51)
            cuentaCarb(boton: c2)
        }

    }
    @IBAction func c3(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c3, id: 52)
                cuentaCarb(boton: c3)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c3, id: 52)
            cuentaCarb(boton: c3)
        }

    }
    @IBAction func c4(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c4, id: 53)
                cuentaCarb(boton: c4)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c4, id: 53)
            cuentaCarb(boton: c4)
        }

    }
    @IBAction func c5(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c5, id: 54)
                cuentaCarb(boton: c5)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c5, id: 54)
            cuentaCarb(boton: c5)
        }

    }
    @IBAction func c6(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c6, id: 55)
                cuentaCarb(boton: c6)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c6, id: 55)
            cuentaCarb(boton: c6)
        }

    }
    @IBAction func c7(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c7, id: 56)
                cuentaCarb(boton: c7)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c7, id: 56)
            cuentaCarb(boton: c7)
        }

    }
    @IBAction func c8(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c8, id: 57)
                cuentaCarb(boton: c8)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c8, id: 57)
            cuentaCarb(boton: c8)
        }

    }
    @IBAction func c9(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c9, id: 58)
                cuentaCarb(boton: c9)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c9, id: 58)
            cuentaCarb(boton: c9)
        }

    }
    @IBAction func c10(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c10, id: 59)
                cuentaCarb(boton: c10)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c10, id: 59)
            cuentaCarb(boton: c10)
        }

    }
    @IBAction func c11(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c11, id: 60)
                cuentaCarb(boton: c11)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c11, id: 60)
            cuentaCarb(boton: c11)
        }

    }
    @IBAction func c12(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: c12, id: 61)
                cuentaCarb(boton: c12)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: c12, id: 61)
            cuentaCarb(boton: c12)
        }

    }
    
    @IBAction func f1(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: f1, id: 100)
                cuentaFat(boton: f1)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: f1, id: 100)
            cuentaFat(boton: f1)
        }

    }
    @IBAction func f2(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: f2, id: 101)
                cuentaFat(boton: f2)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: f2, id: 101)
            cuentaFat(boton: f2)
        }

    }
    @IBAction func f3(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: f3, id: 102)
                cuentaFat(boton: f3)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: f3, id: 102)
            cuentaFat(boton: f3)
        }

    }
    @IBAction func f4(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: f4, id: 103)
                cuentaFat(boton: f4)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: f4, id: 103)
            cuentaFat(boton: f4)
        }

    }
    @IBAction func f5(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: f5, id: 104)
                cuentaFat(boton: f5)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: f5, id: 104)
            cuentaFat(boton: f5)
        }

    }
    @IBAction func f6(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: f6, id: 105)
                cuentaFat(boton: f6)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: f6, id: 105)
            cuentaFat(boton: f6)
        }

    }
    @IBAction func f7(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: f7, id: 106)
                cuentaFat(boton: f7)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: f7, id: 106)
            cuentaFat(boton: f7)
        }

    }
    @IBAction func f8(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: f8, id: 107)
                cuentaFat(boton: f8)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: f8, id: 107)
            cuentaFat(boton: f8)
        }

    }

    @IBAction func l1(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: l1, id: 150)
                cuentaLact(boton: l1)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: l1, id: 150)
            cuentaLact(boton: l1)
        }

    }
    @IBAction func l2(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: l2, id: 151)
                cuentaLact(boton: l2)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: l2, id: 151)
            cuentaLact(boton: l2)
        }

    }
    @IBAction func l3(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: l3, id: 152)
                cuentaLact(boton: l3)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: l3, id: 152)
            cuentaLact(boton: l3)
        }

    }
    
    @IBAction func fr1(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr1, id: 200)
                cuentaFrutas(boton: fr1)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr1, id: 200)
            cuentaFrutas(boton: fr1)
        }

    }
    @IBAction func fr2(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr2, id: 201)
                cuentaFrutas(boton: fr2)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr2, id: 201)
            cuentaFrutas(boton: fr2)
        }

    }
    @IBAction func fr3(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr3, id: 202)
                cuentaFrutas(boton: fr3)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr3, id: 202)
            cuentaFrutas(boton: fr3)
        }

    }
    @IBAction func fr4(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr4, id: 203)
                cuentaFrutas(boton: fr4)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr4, id: 203)
            cuentaFrutas(boton: fr4)
        }

    }
    @IBAction func fr5(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr5, id: 204)
                cuentaFrutas(boton: fr5)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr5, id: 204)
            cuentaFrutas(boton: fr5)
        }

    }
    @IBAction func fr6(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr6, id: 205)
                cuentaFrutas(boton: fr6)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr6, id: 205)
            cuentaFrutas(boton: fr6)
        }

    }
    @IBAction func fr7(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr7, id: 206)
                cuentaFrutas(boton: fr7)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr7, id: 206)
            cuentaFrutas(boton: fr7)
        }

    }
    @IBAction func fr8(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr8, id: 207)
                cuentaFrutas(boton: fr8)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr8, id: 207)
            cuentaFrutas(boton: fr8)
        }

    }
    @IBAction func fr9(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr9, id: 208)
                cuentaFrutas(boton: fr9)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr9, id: 208)
            cuentaFrutas(boton: fr9)
        }

    }
    @IBAction func fr10(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr10, id: 209)
                cuentaFrutas(boton: fr10)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr10, id: 209)
            cuentaFrutas(boton: fr10)
        }

    }
    @IBAction func fr11(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr11, id: 210)
                cuentaFrutas(boton: fr11)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr11, id: 210)
            cuentaFrutas(boton: fr11)
        }

    }
    @IBAction func fr12(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr12, id: 211)
                cuentaFrutas(boton: fr12)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr12, id: 211)
            cuentaFrutas(boton: fr12)
        }

    }
    @IBAction func fr13(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr13, id: 212)
                cuentaFrutas(boton: fr13)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr13, id: 212)
            cuentaFrutas(boton: fr13)
        }

    }
    @IBAction func fr14(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr14, id: 213)
                cuentaFrutas(boton: fr14)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr14, id: 213)
            cuentaFrutas(boton: fr14)
        }

    }
    @IBAction func fr15(_ sender: Any) {
        if premium == false {
            if contCambioAlimentos < 1 {
                seleccion(boton: fr15, id: 214)
                cuentaFrutas(boton: fr15)
            } else {
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
        } else {
            seleccion(boton: fr15, id: 214)
            cuentaFrutas(boton: fr15)
        }

    }
    

    
    
    @objc func continuar(){
        //CAMBIAR POR PASAR A OTRA TAB
        
        if cuentaP >= 5 && cuentaF >= 5 && cuentaC >= 5 {
            
            performSegue(withIdentifier: "resumenSegue", sender: self)
            
        } else {
            if cuentaP < 5 {
                viewProteinas.shake()
                
                let alert = UIAlertController(title: "Selecciona más proteínas", message: "Debes seleccionar por lo menos 5 proteínas para poder continuar.", preferredStyle: UIAlertController.Style.alert)
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
            if cuentaC < 5 {
                viewCarb.shake()
                
                let alert = UIAlertController(title: "Selecciona más carbohidratos", message: "Debes seleccionar por lo menos 5 carbohidratos para poder continuar.", preferredStyle: UIAlertController.Style.alert)
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
            if cuentaF < 5 {
                viewFat.shake()
                
                let alert = UIAlertController(title: "Selecciona más grasas", message: "Debes seleccionar por lo menos 5 grasas para poder continuar.", preferredStyle: UIAlertController.Style.alert)
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


//    @IBAction func haztePremiumPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: "haztePremiumSegue", sender: self)
//    }


    

}
