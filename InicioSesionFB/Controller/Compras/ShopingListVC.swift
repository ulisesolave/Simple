//
//  ShopingListVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 16/10/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import RealmSwift

class ShopingListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MarcarCompradoDelegate {

    
    var lista: Results<Lista>?
    var listaCompras: Results<ListaAlimentos>?
    var alimentos: Results<Alimento>?

    @IBOutlet weak var ListaTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ListaTableView.delegate = self
        ListaTableView.dataSource = self
        ListaTableView.register(UINib(nibName: "ShoppingListTableViewCell", bundle: nil), forCellReuseIdentifier: "ShoppingListCustomCell")
        ListaTableView.register(UINib(nibName: "HeaderSLTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSLCustomCell")
        

    }

    func agregarSeleccionado(item: ListaAlimentos) {
        let realm = try! Realm()
        
        for i in 0..<(listaCompras?.count)! {
            if  listaCompras![i].nombre == item.nombre {
                
                do{
                    try realm.write {
                        listaCompras![i].comprado = true
                        
                    }
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
                
            }
        }
        
    }
    
    func borrarSeleccionado(item: ListaAlimentos) {
        let realm = try! Realm()
        
        for i in 0..<(listaCompras?.count)! {
            if  listaCompras![i].nombre == item.nombre {
                
                do{
                    try realm.write {
                        listaCompras![i].comprado = false

                    }
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
                
            }
        }
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let realm = try! Realm()
        
        let id = realm.objects(Sesion.self).first?.userID
        let infoPersona = realm.objects(Persona.self).filter("userID == %@", id!).first
       

        alimentos = realm.objects(Alimento.self).filter("ANY parentMeal.parentDieta.parentPersona.userID == %@", id!)

        print("TODOS LOS ALIMENTOS SON")
        print(alimentos)
        
        
        var nuevaListaProt = Lista()
        var nuevaListaFat = Lista()
        var nuevaListaCarb = Lista()
        var nuevaListaLact = Lista()
        var nuevaListaFr = Lista()
        

        
        for i in 0..<alimentos!.count {
            var contPorc = 0
            var nuevoItem = ListaAlimentos()
            
            //contar porciones
            for j in 0..<alimentos!.count {
                if alimentos![i].nombre == alimentos![j].nombre {
                    contPorc = contPorc + alimentos![j].porcion
                }
            }
            
            nuevoItem.porcion = contPorc
            nuevoItem.unidadPorcion = alimentos![i].unidadPorcion
            nuevoItem.nombre = alimentos![i].nombre
            nuevoItem.tipoMacro = alimentos![i].tipoMacro

            if alimentos![i].tipoMacro == "Proteina" {
                //para que no agregue duplicados
                var yala = false
                for x in 0..<nuevaListaProt.listaAlimentos.count {
                    if nuevaListaProt.listaAlimentos[x].nombre == nuevoItem.nombre {
                        yala = true
                    }
                }
                
                if yala == false {
                    nuevaListaProt.listaAlimentos.append(nuevoItem)
                    nuevaListaProt.tipoMacro = "Proteina"
                }
            } else if alimentos![i].tipoMacro == "Grasa" {
                //para que no agregue duplicados
                var yala = false
                for x in 0..<nuevaListaFat.listaAlimentos.count {
                    if nuevaListaFat.listaAlimentos[x].nombre == nuevoItem.nombre {
                        yala = true
                    }
                }
                
                if yala == false {
                    nuevaListaFat.listaAlimentos.append(nuevoItem)
                    nuevaListaFat.tipoMacro = "Grasa"
                }
            } else if alimentos![i].tipoMacro == "Carbohidrato" {
                //para que no agregue duplicados
                var yala = false
                for x in 0..<nuevaListaCarb.listaAlimentos.count {
                    if nuevaListaCarb.listaAlimentos[x].nombre == nuevoItem.nombre {
                        yala = true
                    }
                }
                
                if yala == false {
                    nuevaListaCarb.listaAlimentos.append(nuevoItem)
                    nuevaListaCarb.tipoMacro = "Carbohidrato"
                }
            } else if alimentos![i].tipoMacro == "Lacteo" {
                //para que no agregue duplicados
                var yala = false
                for x in 0..<nuevaListaLact.listaAlimentos.count {
                    if nuevaListaLact.listaAlimentos[x].nombre == nuevoItem.nombre {
                        yala = true
                    }
                }
                
                if yala == false {
                    nuevaListaLact.listaAlimentos.append(nuevoItem)
                    nuevaListaLact.tipoMacro = "Lacteo"
                }
            }  else if alimentos![i].tipoMacro == "Fruta" {
                //para que no agregue duplicados
                var yala = false
                for x in 0..<nuevaListaFr.listaAlimentos.count {
                    if nuevaListaFr.listaAlimentos[x].nombre == nuevoItem.nombre {
                        yala = true
                    }
                }
                
                if yala == false {
                    nuevaListaFr.listaAlimentos.append(nuevoItem)
                    nuevaListaFr.tipoMacro = "Fruta"
                }
            }
            
           
        }
        
        
        
        

        print("SHOPPING")
        print(lista)

        listaCompras = realm.objects(ListaAlimentos.self).filter("ANY parentLista.parentPersona.userID == %@", id!)
        
        
        //SOLO BORRAR CUANDO SE ACTUALIZAN LAS MEALS
        let existeLista = infoPersona?.lista
        


        let dieta = realm.objects(Dieta.self).filter("ANY parentPersona.userID == %@", id!)
        
        
        if dieta.first?.cambioMeal == true {
            do {
                try realm.write {
                                        for i in 0..<existeLista!.count {
                                            realm.delete((existeLista![i].listaAlimentos))
                                        }
                    realm.delete((existeLista)!)

                    infoPersona?.lista.append(nuevaListaProt)
                    infoPersona?.lista.append(nuevaListaFat)
                    infoPersona?.lista.append(nuevaListaCarb)
                    infoPersona?.lista.append(nuevaListaLact)
                    infoPersona?.lista.append(nuevaListaFr)
                    dieta.first?.cambioMeal = false
                }
            } catch {
                print("ERROR REALM")
                print(error)
            }
            
        }
       
        lista =  realm.objects(Lista.self).filter("ANY parentPersona.userID == %@", id!)

        ListaTableView.reloadData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista?[section].listaAlimentos.count ?? 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return lista?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCustomCell", for: indexPath) as! ShoppingListTableViewCell
        
        cell.delegate = self
        
        let listaAlimentosVacio = ListaAlimentos()
        let item = lista?[indexPath.section].listaAlimentos[indexPath.row] ?? listaAlimentosVacio
        
        print("ITEM LISTA")
        print(item)
        
        cell.nombre.text = item.nombre
        cell.cantidad.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: item.porcion)

        
        if item.comprado == true {
            cell.check.isSelected = true
            cell.check.setImage(UIImage(named: "checkSi.png"), for: .normal)
        } else {
            cell.check.isSelected = false
            cell.check.setImage(UIImage(named: "checkNo.png"), for: .normal)
        }
        
        
        
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSLCustomCell") as! HeaderSLTableViewCell
        
        headerCell.tipoMeal.text = lista?[section].tipoMacro ?? "no hay datos"
        
        return headerCell
    }
    
    
    
    func descripcionCantidad(unidadPorcion: String, porciones: Int) -> String{
        
        var descripcion = ""
        var numero = 0.0
        var letra = ""
        
        if unidadPorcion == "50g" {
            numero = 50.0
            letra = "Gramos"
            var mult = numero * Double(porciones)
            
            if mult > 1000 {
                letra = "Kg"
                mult = mult / 1000
            }
            
            descripcion = String(mult) + " " + letra
            
        } else if unidadPorcion == "1 unidad" {
            numero = 1
            letra = "Unidad(es)"
            var mult = numero * Double(porciones)

        } else if unidadPorcion == "1 tajada" {
            numero = 1
            letra = "Tajada(s)"
            var mult = numero * Double(porciones)

        } else if unidadPorcion == "1 lata" {
            numero = 1
            letra = "Lata(s)"
            var mult = numero * Double(porciones)

        } else if unidadPorcion == "1 cuchara" {
            numero = 1
            letra = "Cuchara(s)"
            var mult = numero * Double(porciones)

        } else if unidadPorcion == "1 rebanada" {
            numero = 1
            letra = "Rebanada(s)"
            var mult = numero * Double(porciones)

        } else if unidadPorcion == "1 pequeño" {
            numero = 1
            letra = "Unidad(es) pequeña(s)"
            var mult = numero * Double(porciones)

        } else if unidadPorcion == "1 mitad" {
            numero = 1
            letra = "1 mitad"
            var mult = numero * Double(porciones)

        } else if unidadPorcion == "100ml" {
            numero = 100
            letra = "ml"
            var mult = numero * Double(porciones)

        } else if unidadPorcion == "5 unidades" {
            numero = 5
            letra = "Unidades"
            var mult = numero * Double(porciones)

        } else if unidadPorcion == "Media taza" {
            numero = 1
            letra = "Media taza"
            var mult = numero * Double(porciones)

        }
        
        

        if letra == "Media taza" {
            if numero == 1 {
                descripcion = "Media taza"
            } else if numero == 2 {
                descripcion = "1 taza"
            } else if numero == 3 {
                descripcion = "1 taza y media"
            } else if numero == 4 {
                descripcion = "2 tazas"
            } else if numero == 5 {
                descripcion = "2 tazas y media"
            } else if numero == 6 {
                descripcion = "3 tazas"
            } else if numero == 7 {
                descripcion = "3 tazas y media"
            }
        }
        
        
        if letra == "1 mitad" {
            if numero == 1 {
                descripcion = "Media unidad"
            } else if numero == 2 {
                descripcion = "1 Unidad"
            } else if numero == 3 {
                descripcion = "1 Unidad y media"
            } else if numero == 4 {
                descripcion = "2 Unidades"
            }
        }
        
        return descripcion
        
    }

}
