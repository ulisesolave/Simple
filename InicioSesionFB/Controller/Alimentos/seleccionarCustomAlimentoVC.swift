//
//  seleccionarCustomAlimentoVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 14/09/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import RealmSwift

class seleccionarCustomAlimentoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SeleccionarItemDelegate {
    var id = 0
    var dia = ""
    
    //lista que se muestra
    var lista: Results<AlimentosBase>?
    var listaPivot: Results<AlimentosBase>?

    
    var cargarElegidos: List<Alimento>?

    var existeComida: Results<Meal>?
    var infoPersona: Results<Persona>?
    
    @IBOutlet weak var seleccionarCustomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        
        lista = realm.objects(AlimentosBase.self).filter("seleccionado = true")


        print("ID DE MEAL ES")
        print(id)
        
        seleccionarCustomTableView.delegate = self
        seleccionarCustomTableView.dataSource = self
        seleccionarCustomTableView.register(UINib(nibName: "seleccionarCustomAlimentoTableViewCell", bundle: nil), forCellReuseIdentifier: "seleccionarCustomAlimentoCustomCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        let realm = try! Realm()

        lista = realm.objects(AlimentosBase.self).filter("seleccionado = true")
        

        existeComida = realm.objects(Meal.self).filter("custom = true AND dia == %@ AND id == %@", dia, id)
        
        cargarElegidos = existeComida?.first?.alimentos

        print("cargar elegidos")
        print(cargarElegidos)
        
        if cargarElegidos != nil  {
        
        for i in 0..<(lista?.count)! {
//            print(lista![i].nombre)

            for y in 0..<(cargarElegidos?.count)! {
                //cuidado con el segundo !
//                print(cargarElegidos![y].nombre )
                if lista![i].nombre == cargarElegidos![y].nombre {
//                    print("NOMBRES IGUALES")
                    do {
                        try realm.write {
                            lista![i].enEstaMeal = true
                            lista![i].enEstaMealPorc = cargarElegidos![y].porcion
                            print(lista![i].enEstaMeal)

                        }
                    } catch {
                        print("ERROR REALM")
                        print(error)
                    }
                    
                } else {
//                    do {
//                        try realm.write {
//                            lista![i].enEstaMeal = false
//                            lista![i].enEstaMealPorc = 0
//                        }
//                    } catch {
//                        print("ERROR REALM")
//                        print(error)
//                    }
                }
                
            }
            
        }
        
        }
//        print("lista despues de actualizar elegidos")
//        print(lista)
//
        seleccionarCustomTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "seleccionarCustomAlimentoCustomCell", for: indexPath) as! seleccionarCustomAlimentoTableViewCell
        
        let alimentoVacio = AlimentosBase()
        
                let item = lista?[indexPath.row] ?? alimentoVacio
                cell.nombre.text = item.nombre
//                var n: Int = 0
//                n = item.porcion
//                let porcion = String(n)
//                cell.porcionAlimento.text = porcion
                cell.unidad.text = item.unidadPorcion
//                cell.calAlimento.text = String(item.cal)
//                cell.protAlimento.text = String(item.prot)
//                cell.carbAlimento.text = String(item.carb)
//                cell.fatAlimento.text = String(item.fat)
//                cell.idAlimento.text = String(item.id)
        if item.enEstaMeal == true {
            print("ES TRUE")
            cell.botonSeleccionado.isSelected = true
            cell.botonSeleccionado.setImage(UIImage(named: "checkSi.png"), for: .normal)
            cell.cantPorc.text = String(item.enEstaMealPorc)
        } else {
            cell.botonSeleccionado.isSelected = false
            cell.botonSeleccionado.setImage(UIImage(named: "checkNo.png"), for: .normal)
            cell.cantPorc.text = ""
        }
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (lista?.count)!
    }
    

    func agregarSeleccionado(item: AlimentosBase) {
        let realm = try! Realm()

        for i in 0..<(lista?.count)! {
            if  lista![i].nombre == item.nombre {
            
                do{
                    try realm.write {
                        lista![i].enEstaMeal = true
                        lista![i].enEstaMealPorc = item.porcion

                    }
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
            
            }
        }

    }
    
    func borrarSeleccionado(item: AlimentosBase) {
        let realm = try! Realm()
        
        for i in 0..<(lista?.count)! {
            if  lista![i].nombre == item.nombre {
                
                do{
                    try realm.write {
                        lista![i].enEstaMeal = false
                        lista![i].enEstaMealPorc = 0
                        
                    }
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
                
            }
        }
        
    }
    
    @IBAction func cerrar(_ sender: UIButton) {
    print("//////////////////////////////////")
        
        let realm = try! Realm()
        
        let uid = realm.objects(Sesion.self).first?.userID
        let infoPersona = realm.objects(Persona.self).filter("userID == %@", uid).first
        
        print("******")
        
        existeComida = realm.objects(Meal.self).filter("custom = true AND dia == %@ AND id == %@", dia, id)
        print("EXISTE ESA COMIDA?")
        print(existeComida)

        
        var comida = Meal()
        comida.id = id
        comida.custom = true
        comida.dia = dia
        
        
        // pasar de tipo alimentobase a alimento
        lista = lista?.filter("enEstaMeal = true")
        listaPivot = lista
        
        
        print("LISTA ES")
        print(lista)
        
        for i in 0..<(lista?.count)! {
            let alim = Alimento()
            alim.nombre = (lista?[i].nombre)!
            alim.cal = (lista?[i].cal)!
            alim.prot = (lista?[i].prot)!
            alim.carb = (lista?[i].carb)!
            alim.fat = (lista?[i].fat)!
            alim.id = (lista?[i].id)!
            print("PORCION")
            print((lista?[i].porcion)!)
            alim.porcion = (lista?[i].enEstaMealPorc)!
            comida.alimentos.append(alim)

        }
        
        

        let cant = comida.alimentos.count

        
        if cant > 0 {
            
            if existeComida?.first?.tipoMeal != nil {
                //update
                print("YA EXISTE ESE MEAL SE HARA UPDATE")
                do {
                    try realm.write {
                        //borro los que ya existen
                        realm.delete((existeComida?.first?.alimentos)!)
                        
             
                       //ingreso nuevos
                        for (i,elemento) in comida.alimentos.enumerated()
                        {
                        existeComida?.first?.alimentos.append(comida.alimentos[i])

                  
                        }
                        
//                        existeComida?.id = comida.id
//                        existeComida?.cal = comida.cal
//                        existeComida?.prot = comida.prot
//                        existeComida?.fat = comida.fat
//                        existeComida?.carb = comida.carb
//                        existeComida?.dia = comida.dia
//                        existeComida?.tipoMeal = comida.tipoMeal
//
                    }
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
            } else {
                //insert
                print("NO EXISTE ESE MEAL, HARA INSERT")
                do {
                    try realm.write {
                        infoPersona?.dieta.first!.meals.append(comida)
                    }
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
            }
            
            
            
        }
        
        

        print("NUEVOS SELECCIONADOS COUNT")
        print((lista?.count)!)

        var n: Results<AlimentosBase>?
        n = lista

        //borrar campos enEstaMeal (se creara de nuevo en el viewdidapear

                for i in 0..<(lista?.count)! {

                    
                    do {
                        try realm.write {
                            print("A")
                            print("I")
                            print(i)
                            lista?.first?.enEstaMealPorc = 0
                            print("B")
                            lista?.first?.enEstaMeal = false
                        }
                    }catch {
                        print("ERROR REALM")
                        print(error)
                    }
                    print("----")
 
            }

        
        
        dismiss(animated: true, completion: nil)
    }
    
}
