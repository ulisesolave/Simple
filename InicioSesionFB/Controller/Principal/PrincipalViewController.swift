//
//  PrincipalViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 7/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import RealmSwift

class PrincipalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HeaderAlimentoDelegate, HeaderSeleccionarDelegate {
    
    var premium = false
    
    let dispatchGroup = DispatchGroup()

    
    var items = [Int]()
    var rehacerDieta = false
    
    @IBOutlet weak var viewAutomatic: UIView!
    @IBOutlet weak var viewManual: UIView!
    
    
    @IBOutlet weak var inicioTableView: UITableView!
    @IBOutlet weak var customInicioTableView: UITableView!

 
    
    var p = Persona()
    var m: Results<Meal>?
    
    var dieta: Results<Dieta>?
    var desayuno: Results<Alimento>?
    var snack: Results<Alimento>?
    var almuerzo: Results<Alimento>?
    var snack2: Results<Alimento>?
    var cena: Results<Alimento>?

    var mCustom: Results<Meal>?
    
    var desayunoCustom: Results<Alimento>?
    var snackCustom: Results<Alimento>?
    var almuerzoCustom: Results<Alimento>?
    var snack2Custom: Results<Alimento>?
    var cenaCustom: Results<Alimento>?
    var idMeal = 0
    
    
    var sesion: Results<Sesion>?

    //para popup
    var itemSeleccionado = Alimento()

    
    
    //dias y fechas
    
    @IBOutlet weak var lblD1: UILabel!
    @IBOutlet weak var lblD2: UILabel!
    @IBOutlet weak var lblD3: UILabel!
    @IBOutlet weak var lblD4: UILabel!
    @IBOutlet weak var lblD5: UILabel!
    @IBOutlet weak var lblD6: UILabel!
    @IBOutlet weak var lblD7: UILabel!
    
    @IBOutlet weak var d1: UIButton!
    @IBOutlet weak var d2: UIButton!
    @IBOutlet weak var d3: UIButton!
    @IBOutlet weak var d4: UIButton!
    @IBOutlet weak var d5: UIButton!
    @IBOutlet weak var d6: UIButton!
    @IBOutlet weak var d7: UIButton!
    
    
    @IBOutlet weak var labelDia: UILabel!
    
    
    // mostrar macros
    @IBOutlet weak var lblCal: UILabel!
    @IBOutlet weak var lblProt: UILabel!
    @IBOutlet weak var lblFat: UILabel!
    @IBOutlet weak var lblCarb: UILabel!
    
    
    var diaElegido = ""
    var dia1 = ""
    var dia2 = ""
    var dia3 = ""
    var dia4 = ""
    var dia5 = ""
    var dia6 = ""
    var dia7 = ""
    
    @IBAction func switchSegmentedPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewAutomatic.isHidden = false
            viewManual.isHidden = true
            break
        case 1:
            viewAutomatic.isHidden = true
            viewManual.isHidden = false
            break
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("---------------VDA--------------------")
        let realm = try! Realm()

        dia1 = fechas()
        mealDia(dia: dia1)

        let id = realm.objects(Sesion.self).first?.userID
        
        premium = (realm.objects(Sesion.self).first?.premium)!
        
        dieta = realm.objects(Dieta.self).filter("ANY parentPersona.userID == %@", id!)
        
        rehacerDieta = (dieta?.first?.rehacerDieta)!
        
        
        
        print("M DE VDA")
        print(m)
        print(m?.count)
        
        
        if rehacerDieta == true {
            print("funcion rehacerDieta viewdidappear")
            borrarDieta()
        }
        
        if m?.first == nil {
            print("no existe ningun meal viewdidappear")
            

            

            
            armar()

            
//            let deadlineTime = DispatchTime.now() + .seconds(2)
//
//            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
//                print("2 seggggg")
//                activityView.stopAnimating()
//
//            })

        }
        
        inicioTableView.reloadData()
        
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------------VDL-----------------")

        dia1 = fechas()

        
        mealDia(dia: dia1)


        let realm = try! Realm()

        self.navigationController?.isNavigationBarHidden = true


        
        
        inicioTableView.delegate = self
        inicioTableView.dataSource = self
        inicioTableView.register(UINib(nibName: "AlimentoTableViewCell", bundle: nil), forCellReuseIdentifier: "alimentoCustomCell")
        inicioTableView.register(UINib(nibName: "HeaderAlimentoTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "headerAlimentoCustomCell")
        
        customInicioTableView.delegate = self
        customInicioTableView.dataSource = self
        customInicioTableView.register(UINib(nibName: "CustomAlimentosTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomAlimentosCustomCell")
        customInicioTableView.register(UINib(nibName: "HeaderSeleccionarTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "headerSeleccionarCustomCell")
        
        
        
        print("M ES")
        print(m)
        print(m?.count)
        

        
        if m?.first == nil {
            print("no existe ningun meal viewdidload")
            armar()
            mealDia(dia: dia1)

        } else {

        }
        
        

    }
    
    
    func borrarDieta(){
        let realm = try! Realm()
        print("URL REALM")
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        //persona
        
        let id = realm.objects(Sesion.self).first?.userID
        let infoPersona = realm.objects(Persona.self).filter("userID == %@", id).first
        

        dieta = realm.objects(Dieta.self).filter("ANY parentPersona.userID == %@", id!)
        
        let del =  infoPersona?.dieta.first?.meals
        
        sesion = realm.objects(Sesion.self)
        
        
                            do {
                                    try realm.write {
                                        dieta!.first?.cambioMeal = true
                                        for i in 0..<del!.count {
                                        realm.delete(del![i].alimentos)
                                        }
                                        realm.delete(del!)
                                        
                                        
                                        dieta!.first?.rehacerDieta = false
        
                                }
                                } catch {
                                    print("ERROR REALM")
                                    print(error)
                                }
    }

    func armar(){
//se ve feo  y no funciona
        //        var alert: UIAlertView = UIAlertView(title: "", message: "", delegate: nil, cancelButtonTitle: "Cancel");
//
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x:50, y:10, width:37, height:37))
//        loadingIndicator.center = self.view.center;
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.gray
//        loadingIndicator.startAnimating();
//
//        alert.setValue(loadingIndicator, forKey: "accessoryView")
//        loadingIndicator.startAnimating()
//
//        alert.show();
        
        
        //NO FUNCIONA
//        dispatchGroup.enter()
//
//        let activityView = UIActivityIndicatorView(style: .gray)
//        activityView.center = self.view.center
//        activityView.startAnimating()
//        self.view.addSubview(activityView)
//
//        dispatchGroup.leave()
//
//
//        dispatchGroup.notify(queue: .main, execute: {
//            activityView.stopAnimating()
//
//        })

        let realm = try! Realm()

        let id = realm.objects(Sesion.self).first?.userID
        
        dieta = realm.objects(Dieta.self).filter("ANY parentPersona.userID == %@", id!)
        
        var cantidadMeals = (dieta?.first?.cantMeals)!
       
        

        
        let itemsSeleccionados = realm.objects(AlimentosBase.self).filter("seleccionado = true AND ANY parentPersona.userID == %@", id!)
        
        
        if cantidadMeals == 2 {
            makeMeal(dia: dia1, tipoMeal: "almuerzo", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "cena",  seleccionados: itemsSeleccionados)
        } else if cantidadMeals == 3 {
            makeMeal(dia: dia1, tipoMeal: "desayuno", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "almuerzo", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "cena", seleccionados: itemsSeleccionados)
        } else if cantidadMeals == 4 {
            makeMeal(dia: dia1, tipoMeal: "desayuno", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "almuerzo", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "snack", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "cena", seleccionados: itemsSeleccionados)
        }  else if cantidadMeals == 5 {
            makeMeal(dia: dia1, tipoMeal: "desayuno", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "snack", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "almuerzo", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "snack2", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia1, tipoMeal: "cena", seleccionados: itemsSeleccionados)
        }
        
        if cantidadMeals == 2 {
            makeMeal(dia: dia2, tipoMeal: "almuerzo", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "cena",  seleccionados: itemsSeleccionados)
        } else if cantidadMeals == 3 {
            makeMeal(dia: dia2, tipoMeal: "desayuno", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "almuerzo", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "cena", seleccionados: itemsSeleccionados)
        } else if cantidadMeals == 4 {
            makeMeal(dia: dia2, tipoMeal: "desayuno", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "almuerzo", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "snack", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "cena", seleccionados: itemsSeleccionados)
        }  else if cantidadMeals == 5 {
            makeMeal(dia: dia2, tipoMeal: "desayuno", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "snack", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "almuerzo", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "snack2", seleccionados: itemsSeleccionados)
            makeMeal(dia: dia2, tipoMeal: "cena", seleccionados: itemsSeleccionados)
        }

        
        m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", dia1, id!)
        
        desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
        snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
        almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
        snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
        cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
        
        print("M DE FUNCION ARMAR")
        print(m)
        
        
        

    }
    
    
    
    
    
    

        
    

    
    
    
    func makeMeal(dia: String, tipoMeal: String, seleccionados: Results<AlimentosBase>){
        
        let realm = try! Realm()
        print("URL REALM")
        print(Realm.Configuration.defaultConfiguration.fileURL)
        let id = realm.objects(Sesion.self).first?.userID

        
        dieta = realm.objects(Dieta.self).filter("ANY parentPersona.userID == %@", id!)
        
        var cantidadMeals = (dieta?.first?.cantMeals)!
        
        var macros = [0.0, 0.0, 0.0]
        macros[0] = (dieta?.first?.grProt)!
        macros[1] = (dieta?.first?.grFat)!
        macros[2] = (dieta?.first?.grCarb)!
        
        
        var porcPorMeal = [Double]()
        
        var grProtPorMeal = [Double]()
        var grFatPorMeal = [Double]()
        var grCarbPorMeal = [Double]()
        
        var grMacroPorDesayuno = [Double]()
        var grMacroPorAlmuerzo = [Double]()
        var grMacroPorCena =  [Double]()
        var grMacroPorSnack =  [Double]()
        var grMacroPorSnack2 =  [Double]()
        
        var macrosMeal =  [Double]()
        
        
        if cantidadMeals == 2 {
            porcPorMeal = [0.5,0.5] // alm,cena
        } else if cantidadMeals == 3 {
            porcPorMeal = [0.25,0.40,0.35] // desayuno,alm,cena
        } else if cantidadMeals == 4 {
            porcPorMeal = [0.20,0.35,0.30,0.15] // desayuno,alm,cena.snack
        }  else if cantidadMeals == 5 {
            porcPorMeal = [0.20,0.30,0.30,0.10,0.10] // desayuno,alm,cena.snack
        }
        
        grProtPorMeal = porcPorMeal.map { $0 * macros[0]} //   ej  31.25,  43.75,   31.25,   18.75
        grFatPorMeal = porcPorMeal.map { $0 * macros[1]}
        grCarbPorMeal = porcPorMeal.map { $0 * macros[2]}
        
        if cantidadMeals == 2 {
            if tipoMeal == "almuerzo" {
                macrosMeal = [grProtPorMeal[0],grFatPorMeal[0], grCarbPorMeal[0]]
            } else if tipoMeal == "cena" {
                macrosMeal = [grProtPorMeal[1],grFatPorMeal[1], grCarbPorMeal[1]]
            }
            
            
        } else if cantidadMeals == 3 {
            if tipoMeal == "desayuno" {
                macrosMeal = [grProtPorMeal[0],grFatPorMeal[0], grCarbPorMeal[0]]
            } else if tipoMeal == "almuerzo" {
                macrosMeal = [grProtPorMeal[1],grFatPorMeal[1], grCarbPorMeal[1]]
            } else if tipoMeal == "cena" {
                macrosMeal = [grProtPorMeal[2],grFatPorMeal[2], grCarbPorMeal[2]]
            }
            
            
        } else if cantidadMeals == 4 {
            
//            grMacroPorDesayuno = [grProtPorMeal[0],grFatPorMeal[0], grCarbPorMeal[0]]
//            grMacroPorAlmuerzo = [grProtPorMeal[1],grFatPorMeal[1], grCarbPorMeal[1]]
//            grMacroPorCena = [grProtPorMeal[2],grFatPorMeal[2], grCarbPorMeal[2]]
//            grMacroPorSnack = [grProtPorMeal[3],grFatPorMeal[3], grCarbPorMeal[3]]
//            var grApasar = grMacroPorSnack[0] * 0.8
//            grMacroPorSnack[0] = grMacroPorSnack[0] - grApasar
//            grMacroPorDesayuno[0] = grMacroPorDesayuno[0] + grApasar * 0.15
//            grMacroPorAlmuerzo[0] = grMacroPorAlmuerzo[0] + grApasar * 0.33
//            grMacroPorCena[0] = grMacroPorCena[0] + grApasar * 0.33
            
            if tipoMeal == "desayuno" {
                macrosMeal = [grProtPorMeal[0],grFatPorMeal[0], grCarbPorMeal[0]]
            } else if tipoMeal == "almuerzo" {
                macrosMeal = [grProtPorMeal[1],grFatPorMeal[1], grCarbPorMeal[1]]
            } else if tipoMeal == "cena" {
                macrosMeal = [grProtPorMeal[2],grFatPorMeal[2], grCarbPorMeal[2]]
            } else if tipoMeal == "snack" {
                macrosMeal = [grProtPorMeal[3],grFatPorMeal[3], grCarbPorMeal[3]]
            }
              
        }  else if cantidadMeals == 5 {
//            grMacroPorDesayuno = [grProtPorMeal[0],grFatPorMeal[0], grCarbPorMeal[0]]
//            grMacroPorAlmuerzo = [grProtPorMeal[1],grFatPorMeal[1], grCarbPorMeal[1]]
//            grMacroPorCena = [grProtPorMeal[2],grFatPorMeal[2], grCarbPorMeal[2]]
//            grMacroPorSnack = [grProtPorMeal[3],grFatPorMeal[3], grCarbPorMeal[3]]
//            grMacroPorSnack2 = [grProtPorMeal[4],grFatPorMeal[4], grCarbPorMeal[4]]
//            var grApasar = (grMacroPorSnack[0] + grMacroPorSnack2[0]) * 0.8
//            grMacroPorSnack[0] = grMacroPorSnack[0] - grApasar / 2
//            grMacroPorSnack2[0] = grMacroPorSnack2[0] - grApasar / 2
//            grMacroPorDesayuno[0] = grMacroPorDesayuno[0] + grApasar * 0.15
//            grMacroPorAlmuerzo[0] = grMacroPorAlmuerzo[0] + grApasar * 0.33
//            grMacroPorCena[0] = grMacroPorCena[0] + grApasar * 0.33
            if tipoMeal == "desayuno" {
                macrosMeal = [grProtPorMeal[0],grFatPorMeal[0], grCarbPorMeal[0]]
            } else if tipoMeal == "almuerzo" {
                macrosMeal = [grProtPorMeal[1],grFatPorMeal[1], grCarbPorMeal[1]]
            } else if tipoMeal == "cena" {
                macrosMeal = [grProtPorMeal[2],grFatPorMeal[2], grCarbPorMeal[2]]
            } else if tipoMeal == "snack" {
                macrosMeal = [grProtPorMeal[3],grFatPorMeal[3], grCarbPorMeal[3]]
            } else if tipoMeal == "snack2" {
                macrosMeal = [grProtPorMeal[4],grFatPorMeal[4], grCarbPorMeal[4]]
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        
        print("TIPO MEAL")
        print(tipoMeal)
        print("MACROS DEL MEAL")
        print(macrosMeal)

        
        
        
        let calorias = macrosMeal[0] * 4 + macrosMeal[1] * 9 + macrosMeal[2] * 4
        
        print("CALORIAS")
        print(calorias)
        
        print("PASO 1")
        
        // SUAVE CON NOMBRE SNACK2
        var tipoMealPivot = tipoMeal
        if tipoMealPivot == "snack2" {
           tipoMealPivot = "snack"
        }
        let seleccionadosEnMeal = seleccionados.filter(tipoMealPivot + " = true")

        let protSeleccionadosEnMeal = seleccionados.filter(tipoMealPivot + " = true AND tipoMacro = 'Proteina'")
        let fatSeleccionadosEnMeal = seleccionados.filter(tipoMealPivot + " = true AND tipoMacro = 'Grasa'")
        let carbSeleccionadosEnMeal = seleccionados.filter(tipoMealPivot + " = true AND tipoMacro = 'Carbohidrato'")
        let lactSeleccionadosEnMeal = seleccionados.filter(tipoMealPivot + " = true AND tipoMacro = 'Lacteo'")
        let frSeleccionadosEnMeal = seleccionados.filter(tipoMealPivot + " = true AND tipoMacro = 'Fruta'")
        
        let snacksSeleccionados = seleccionados.filter("snack = true")

        print("PASO 2")
        
        var cuentaGrProt = 0.0
        var cuentaGrFat = 0.0
        var cuentaGrCarb = 0.0
        var cuentaCal = 0.0
        
        var indexSeleccionado = 0
        var porcionSeleccionado = 0.0
        

        var cumpleProt = false
        var cumpleFat = false
        var cumpleCarb = false
        var cumpleCal = false
        var cumpleTodo = false
        
        var cont = 0
        
        
        var comida = Meal()

        print("PASO 3")
        repeat {
            cumpleProt = false
            cumpleFat = false
            cumpleCarb = false
            cumpleCal = false
            cuentaGrProt = 0.0
            cuentaGrFat = 0.0
            cuentaGrCarb = 0.0
            cuentaCal = 0.0
            
            comida = Meal()
        
            
            if tipoMeal == "snack" || tipoMeal == "snack2" {
            //SNACKS
            var repSnack = ""
            var minItemsSn = 1
            var maxItemsSn = 2
            var cantItemsSn = randomNumber(inRange: minItemsSn...maxItemsSn)
            for i in 0..<cantItemsSn {
                
                indexSeleccionado = Int(arc4random_uniform(UInt32(snacksSeleccionados.count)))
                var item = snacksSeleccionados[indexSeleccionado]
                porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
                
                repeat {
                    indexSeleccionado = Int(arc4random_uniform(UInt32(snacksSeleccionados.count)))
                    item = snacksSeleccionados[indexSeleccionado]
                    porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
                } while repSnack == item.nombre
                repSnack = item.nombre
                
                cuentaGrProt = cuentaGrProt + item.prot * porcionSeleccionado
                cuentaGrFat = cuentaGrFat + item.fat * porcionSeleccionado
                cuentaGrCarb = cuentaGrCarb + item.carb * porcionSeleccionado
                cuentaCal = cuentaCal + item.cal * porcionSeleccionado
                
                let alimento = Alimento()
                alimento.nombre = item.nombre
                alimento.id = item.id
                alimento.tipoMacro = item.tipoMacro
                alimento.cal = porcionSeleccionado * item.cal
                alimento.prot = porcionSeleccionado * item.prot
                alimento.fat = porcionSeleccionado * item.fat
                alimento.carb = porcionSeleccionado * item.carb
                alimento.porcion = Int(porcionSeleccionado)
                alimento.unidadPorcion = item.unidadPorcion
                
                comida.alimentos.append(alimento)
            }
                
                
            } else {
                
                print("PASO 4")

                print("protSeleccionadosEnMeal")
print(protSeleccionadosEnMeal)
                //PROTEINAS
            var repProt = ""
            var huevo = false
            var minItemsProt = 0
            var maxItemsProt = 0
            if tipoMeal == "desayuno" {
                minItemsProt = 1
                maxItemsProt = 2
            } else if tipoMeal == "almuerzo" || tipoMeal == "cena" {
                minItemsProt = 1
                maxItemsProt = 1
            }
        var cantItemsProt = randomNumber(inRange: minItemsProt...maxItemsProt)
                
        for var i in 0..<cantItemsProt {

            
            indexSeleccionado = Int(arc4random_uniform(UInt32(protSeleccionadosEnMeal.count)))
            var item = protSeleccionadosEnMeal[indexSeleccionado]
            porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
            
            repeat {

            indexSeleccionado = Int(arc4random_uniform(UInt32(protSeleccionadosEnMeal.count)))
            item = protSeleccionadosEnMeal[indexSeleccionado]
            porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))


                print("ENTRO")

            } while repProt == item.nombre
            
            
           repProt = item.nombre

            print("PASO 4.1")
            
                if item.nombre == "Huevo"{
                    huevo = true
                }
            
            cuentaGrProt = cuentaGrProt + item.prot * porcionSeleccionado
            cuentaGrFat = cuentaGrFat + item.fat * porcionSeleccionado
            cuentaGrCarb = cuentaGrCarb + item.carb * porcionSeleccionado
            cuentaCal = cuentaCal + item.cal * porcionSeleccionado
            print("PASO 4.2")
            let alimento = Alimento()
            alimento.nombre = item.nombre
            alimento.id = item.id
            alimento.tipoMacro = item.tipoMacro
            alimento.subMacro = item.subMacro
            alimento.cal = porcionSeleccionado * item.cal
            alimento.prot = porcionSeleccionado * item.prot
            alimento.fat = porcionSeleccionado * item.fat
            alimento.carb = porcionSeleccionado * item.carb
            alimento.porcion = Int(porcionSeleccionado)
            alimento.unidadPorcion = item.unidadPorcion
            
            comida.alimentos.append(alimento)
            
            
        }
        //FATS
            var repFat = ""
            var minItemsFat = 0
            var maxItemsFat = 0
            if tipoMeal == "desayuno" {
                minItemsFat = 0
                maxItemsFat = 1
            } else if tipoMeal == "almuerzo" || tipoMeal == "cena" {
                minItemsFat = 0
                maxItemsFat = 1
            }
        var cantItemsFat = randomNumber(inRange: minItemsFat...maxItemsFat)
        for i in 0..<cantItemsFat {
            indexSeleccionado = Int(arc4random_uniform(UInt32(fatSeleccionadosEnMeal.count)))
            var item = fatSeleccionadosEnMeal[indexSeleccionado]
            porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
            
            repeat {
                indexSeleccionado = Int(arc4random_uniform(UInt32(fatSeleccionadosEnMeal.count)))
                item = fatSeleccionadosEnMeal[indexSeleccionado]
                porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
                
            } while repFat == item.nombre
            repFat = item.nombre
            
            cuentaGrProt = cuentaGrProt + item.prot * porcionSeleccionado
            cuentaGrFat = cuentaGrFat + item.fat * porcionSeleccionado
            cuentaGrCarb = cuentaGrCarb + item.carb * porcionSeleccionado
            cuentaCal = cuentaCal + item.cal * porcionSeleccionado
            
            let alimento = Alimento()
            alimento.nombre = item.nombre
            alimento.id = item.id
            alimento.tipoMacro = item.tipoMacro
            alimento.subMacro = item.subMacro
            alimento.cal = porcionSeleccionado * item.cal
            alimento.prot = porcionSeleccionado * item.prot
            alimento.fat = porcionSeleccionado * item.fat
            alimento.carb = porcionSeleccionado * item.carb
            alimento.porcion = Int(porcionSeleccionado)
            alimento.unidadPorcion = item.unidadPorcion
            
            comida.alimentos.append(alimento)
        }
                
        //CARBS
            var repCarb = ""
            var subM = ""
            var minItemsCarb = 0
            var maxItemsCarb = 0
            if tipoMeal == "desayuno" {
                minItemsCarb = 1
                maxItemsCarb = 1
            } else if tipoMeal == "almuerzo" || tipoMeal == "cena" {
                minItemsCarb = 1
                maxItemsCarb = 2
            }
        var cantItemsCarbs = randomNumber(inRange: minItemsCarb...maxItemsCarb)
        for i in 0..<cantItemsCarbs {
            indexSeleccionado = Int(arc4random_uniform(UInt32(carbSeleccionadosEnMeal.count)))
            var item = carbSeleccionadosEnMeal[indexSeleccionado]
            porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
            
            repeat {
                indexSeleccionado = Int(arc4random_uniform(UInt32(carbSeleccionadosEnMeal.count)))
                item = carbSeleccionadosEnMeal[indexSeleccionado]
                porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
            } while repCarb == item.nombre || subM == item.subMacro
            repCarb = item.nombre
            subM = item.subMacro
            
            cuentaGrProt = cuentaGrProt + item.prot * porcionSeleccionado
            cuentaGrFat = cuentaGrFat + item.fat * porcionSeleccionado
            cuentaGrCarb = cuentaGrCarb + item.carb * porcionSeleccionado
            cuentaCal = cuentaCal + item.cal * porcionSeleccionado
            
            let alimento = Alimento()
            alimento.nombre = item.nombre
            alimento.id = item.id
            alimento.tipoMacro = item.tipoMacro
            alimento.subMacro = item.subMacro
            alimento.cal = porcionSeleccionado * item.cal
            alimento.prot = porcionSeleccionado * item.prot
            alimento.fat = porcionSeleccionado * item.fat
            alimento.carb = porcionSeleccionado * item.carb
            alimento.porcion = Int(porcionSeleccionado)
            alimento.unidadPorcion = item.unidadPorcion
            
            comida.alimentos.append(alimento)
        }
        //LACTEOS
            var minItemsLact = 0
            var maxItemsLact = 0
            if tipoMeal == "desayuno" {
                minItemsLact = 0
                maxItemsLact = 1
            } else if tipoMeal == "almuerzo" || tipoMeal == "cena" {
                minItemsLact = 0
                maxItemsLact = 0
            }
        var cantItemsLact = randomNumber(inRange: minItemsLact...maxItemsLact)
        for i in 0..<cantItemsLact {
            indexSeleccionado = Int(arc4random_uniform(UInt32(lactSeleccionadosEnMeal.count)))
            var item = lactSeleccionadosEnMeal[indexSeleccionado]
            porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
            
            cuentaGrProt = cuentaGrProt + item.prot * porcionSeleccionado
            cuentaGrFat = cuentaGrFat + item.fat * porcionSeleccionado
            cuentaGrCarb = cuentaGrCarb + item.carb * porcionSeleccionado
            cuentaCal = cuentaCal + item.cal * porcionSeleccionado
            
            let alimento = Alimento()
            alimento.nombre = item.nombre
            alimento.id = item.id
            alimento.tipoMacro = item.tipoMacro
            alimento.subMacro = item.subMacro
            alimento.cal = porcionSeleccionado * item.cal
            alimento.prot = porcionSeleccionado * item.prot
            alimento.fat = porcionSeleccionado * item.fat
            alimento.carb = porcionSeleccionado * item.carb
            alimento.porcion = Int(porcionSeleccionado)
            alimento.unidadPorcion = item.unidadPorcion
            
            comida.alimentos.append(alimento)
        }
        //FRUTAS
            var minItemsFr = 0
            var maxItemsFr = 0
            if tipoMeal == "desayuno" {
                minItemsFr = 0
                maxItemsFr = 1
            } else if tipoMeal == "almuerzo" || tipoMeal == "cena" {
                minItemsFr = 0
                maxItemsFr = 0
            }
        var cantItemsfr = randomNumber(inRange: minItemsFr...maxItemsFr)
        for i in 0..<cantItemsfr {
            indexSeleccionado = Int(arc4random_uniform(UInt32(frSeleccionadosEnMeal.count)))
            var item = frSeleccionadosEnMeal[indexSeleccionado]
            porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
            
            cuentaGrProt = cuentaGrProt + item.prot * porcionSeleccionado
            cuentaGrFat = cuentaGrFat + item.fat * porcionSeleccionado
            cuentaGrCarb = cuentaGrCarb + item.carb * porcionSeleccionado
            cuentaCal = cuentaCal + item.cal * porcionSeleccionado
            
            let alimento = Alimento()
            alimento.nombre = item.nombre
            alimento.id = item.id
            alimento.tipoMacro = item.tipoMacro
            alimento.subMacro = item.subMacro
            alimento.cal = porcionSeleccionado * item.cal
            alimento.prot = porcionSeleccionado * item.prot
            alimento.fat = porcionSeleccionado * item.fat
            alimento.carb = porcionSeleccionado * item.carb
            alimento.porcion = Int(porcionSeleccionado)
            alimento.unidadPorcion = item.unidadPorcion
            
            comida.alimentos.append(alimento)
        }
            
            print("PASO 4.3")
                
             //termina else
            }
            
            
            if tipoMeal == "almuerzo" || tipoMeal == "cena" {
                if cantidadMeals <= 3 {
                
                var minItemsSn = 0
                var maxItemsSn = 1
                var cantItemsSn = randomNumber(inRange: minItemsSn...maxItemsSn)
                for i in 0..<cantItemsSn {
                    
                    indexSeleccionado = Int(arc4random_uniform(UInt32(snacksSeleccionados.count)))
                    var item = snacksSeleccionados[indexSeleccionado]
                    porcionSeleccionado = Double(randomNumber(inRange: item.porcionMin...item.porcionMax))
                    
                    
                    
                    cuentaGrProt = cuentaGrProt + item.prot * porcionSeleccionado
                    cuentaGrFat = cuentaGrFat + item.fat * porcionSeleccionado
                    cuentaGrCarb = cuentaGrCarb + item.carb * porcionSeleccionado
                    cuentaCal = cuentaCal + item.cal * porcionSeleccionado
                    
                    let alimento = Alimento()
                    alimento.nombre = item.nombre
                    alimento.id = item.id
                    alimento.tipoMacro = item.tipoMacro
                    alimento.cal = porcionSeleccionado * item.cal
                    alimento.prot = porcionSeleccionado * item.prot
                    alimento.fat = porcionSeleccionado * item.fat
                    alimento.carb = porcionSeleccionado * item.carb
                    alimento.porcion = Int(porcionSeleccionado)
                    alimento.unidadPorcion = item.unidadPorcion
                    
                    comida.alimentos.append(alimento)
                }
            }
            
            }
           
            
            
            
            
            
            
            
        print("PASO 5")
            
        comida.tipoMeal = tipoMeal
        comida.dia = dia
        comida.cal = cuentaCal
        comida.prot = cuentaGrProt
        comida.carb = cuentaGrCarb
        comida.fat = cuentaGrFat

            
        var a = [cuentaGrProt,cuentaGrFat,cuentaGrCarb]
        
        print(a)
        
        
            if tipoMeal == "snack" || tipoMeal == "snack2" {

//                if ((cuentaGrProt >= 0.7 * grMacroPorMeal[0]) &&  (cuentaGrProt <= 1.3 * grMacroPorMeal[0])){
                    cumpleProt = true
//                    print("CUMPLE PROTEINAS")
//                    print(comida)
//                }
                if ((cuentaCal >= 0.9 * calorias) &&  (cuentaCal <= 1.1 * calorias)){
                    cumpleCal = true
                    print("CUMPLE CALORIAS")
                    print(comida)
                }
                
                if ((cuentaGrFat >= 0.5 * macrosMeal[1]) &&  (cuentaGrFat <= 1.5 * macrosMeal[1])){
                    cumpleFat = true
                    print("CUMPLE FATS")
                    print(comida)

                }
                if ((cuentaGrCarb >= 0.70 * macrosMeal[2]) &&  (cuentaGrCarb <= 1.30 * macrosMeal[2])){
                    cumpleCarb = true
                    print("CUMPLE CARBS")
                    print(comida)
                    
                }
                
            } else {
                
                if ((cuentaCal >= 0.9 * calorias) &&  (cuentaCal <= 1.1 * calorias)){
                    cumpleCal = true
                    print("CUMPLE CALORIAS")
                    print(comida)
                }
                
                if ((cuentaGrProt >= 0.85 * macrosMeal[0]) &&  (cuentaGrProt <= 1.15 * macrosMeal[0])){
                    cumpleProt = true
                    print("CUMPLE PROTEINAS")
                    print(comida)
                }
                if ((cuentaGrFat >= 0.5 * macrosMeal[1]) &&  (cuentaGrFat <= 1.5 * macrosMeal[1])){
                    cumpleFat = true
                    print("CUMPLE FATS")
                    print(comida)

                }
                if ((cuentaGrCarb >= 0.5 * macrosMeal[2]) &&  (cuentaGrCarb <= 1.5 * macrosMeal[2])){
                    cumpleCarb = true
                    print("CUMPLE CARBS")
                    print(comida)

                }
        
            }
            
        
        if cumpleProt == true && cumpleFat == true && cumpleCarb == true && cumpleCal == true {
            print("CUMPLE TODO")
            cumpleTodo = true
        }
        
        print("PRIMER CONTADOR")
        
        cont = cont + 1
            
    } while cumpleTodo == false



        
        
        print("****************************************")

        print("LA MEAL ES")
        print(tipoMeal)

        
        


        //persona

        let infoPersona = realm.objects(Persona.self).filter("userID == %@", id).first
        var existeMeal = infoPersona?.dieta.first?.meals.filter("dia == %@ AND tipoMeal == %@", dia, tipoMeal).first


        sesion = realm.objects(Sesion.self)
        

        
        if existeMeal != nil {
            //update
            print("YA EXISTE ESE MEAL SE HARA UPDATE")
            do {
                try realm.write {

                    dieta!.first?.cambioMeal = true
                    print("COMIDA ES")
                    print(comida)
                    print("EXISTE MEAL ES")
                    print(existeMeal)

                    realm.delete((existeMeal?.alimentos)!)

                    let cant = comida.alimentos.count

                    print("CANT ES")
                    print(cant)

                    if cant == 1 {
                        existeMeal?.alimentos.append(comida.alimentos[0])
                    }
                    if cant == 2 {
                        existeMeal?.alimentos.append(comida.alimentos[0])
                        existeMeal?.alimentos.append(comida.alimentos[1])
                    }
                    if cant == 3  {
                        existeMeal?.alimentos.append(comida.alimentos[0])
                        existeMeal?.alimentos.append(comida.alimentos[1])
                        existeMeal?.alimentos.append(comida.alimentos[2])
                    }
                    if cant == 4  {
                        existeMeal?.alimentos.append(comida.alimentos[0])
                        existeMeal?.alimentos.append(comida.alimentos[1])
                        existeMeal?.alimentos.append(comida.alimentos[2])
                        existeMeal?.alimentos.append(comida.alimentos[2])
                    }
                    if cant == 5  {
                        existeMeal?.alimentos.append(comida.alimentos[0])
                        existeMeal?.alimentos.append(comida.alimentos[1])
                        existeMeal?.alimentos.append(comida.alimentos[2])
                        existeMeal?.alimentos.append(comida.alimentos[3])
                        existeMeal?.alimentos.append(comida.alimentos[4])
                    }
                    if cant == 6  {
                        existeMeal?.alimentos.append(comida.alimentos[0])
                        existeMeal?.alimentos.append(comida.alimentos[1])
                        existeMeal?.alimentos.append(comida.alimentos[2])
                        existeMeal?.alimentos.append(comida.alimentos[3])
                        existeMeal?.alimentos.append(comida.alimentos[4])
                        existeMeal?.alimentos.append(comida.alimentos[5])
                    }
                    if cant == 7  {
                        existeMeal?.alimentos.append(comida.alimentos[0])
                        existeMeal?.alimentos.append(comida.alimentos[1])
                        existeMeal?.alimentos.append(comida.alimentos[2])
                        existeMeal?.alimentos.append(comida.alimentos[3])
                        existeMeal?.alimentos.append(comida.alimentos[4])
                        existeMeal?.alimentos.append(comida.alimentos[5])
                        existeMeal?.alimentos.append(comida.alimentos[6])
                    }

                    existeMeal?.id = comida.id
                    existeMeal?.cal = comida.cal
                    existeMeal?.prot = comida.prot
                    existeMeal?.fat = comida.fat
                    existeMeal?.carb = comida.carb
                    existeMeal?.dia = comida.dia
                    existeMeal?.tipoMeal = comida.tipoMeal

                    existeMeal?.cambioFree = (existeMeal?.cambioFree)! + 1


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
                    dieta!.first?.cambioMeal = true

                    infoPersona?.dieta.first!.meals.append(comida)
                }
            } catch {
                print("ERROR REALM")
                print(error)
            }
        }



        
        
        
    }
    
    
    
    func cuentaMacros(){
        var cuentaCalDia = 0.0
        var cuentaProtDia = 0.0
        var cuentaFatDia = 0.0
        var cuentaCarbDia = 0.0
        
        for i in 0..<(m!.count) {
            cuentaCalDia = cuentaCalDia + m![i].cal
            cuentaProtDia = cuentaProtDia + m![i].prot
            cuentaFatDia = cuentaFatDia + m![i].fat
            cuentaCarbDia = cuentaCarbDia + m![i].carb
        }
        
        
        if viewAutomatic.isHidden == false {
            lblCal.text = String(Int(round(cuentaCalDia)))
            lblProt.text = String(Int(round(cuentaProtDia)))
            lblFat.text = String(Int(round(cuentaFatDia)))
            lblCarb.text = String(Int(round(cuentaCarbDia)))
        } else {
            
        }
        
        
    }

    func mealDia(dia: String) {

        d1.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        if dia == "lunes"{
            labelDia.text = "Lunes"
        } else if dia == "martes"{
            labelDia.text = "Martes"
        } else if dia == "miercoles"{
            labelDia.text = "Miércoles"
        } else if dia == "jueves"{
            labelDia.text = "Jueves"
        } else if dia == "viernes"{
            labelDia.text = "Viernes"
        } else if dia == "sabado"{
            labelDia.text = "Sábado"
        } else if dia == "domingo"{
            labelDia.text = "Domingo"
        }

        
        let realm = try! Realm()
  
        let id = realm.objects(Sesion.self).first?.userID
        p = realm.objects(Persona.self).filter("userID == %@", id).first!

        m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", dia, id!)

        desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia, id!)
        snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia, id!)
        almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia, id!)
        snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia, id!)
        cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia, id!)
        
        
        mCustom = realm.objects(Meal.self).filter("custom = true AND dia == %@", dia)
        
        
        
        print("M DE MEALDIA")
        print(m)
        
        
        cuentaMacros()
       
 
    }
    
    @IBAction func pressedD1(_ sender: UIButton) {
        
            diaElegido = dia1
        
            if diaElegido == "lunes"{
                labelDia.text = "Lunes"
            } else if diaElegido == "martes"{
                labelDia.text = "Martes"
            } else if diaElegido == "miercoles"{
                labelDia.text = "Miércoles"
            } else if diaElegido == "jueves"{
                labelDia.text = "Jueves"
            } else if diaElegido == "viernes"{
                labelDia.text = "Viernes"
            } else if diaElegido == "sabado"{
                labelDia.text = "Sábado"
            } else if diaElegido == "domingo"{
                labelDia.text = "Domingo"
            }
            
            d1.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            let realm = try! Realm()
            
            let id = realm.objects(Sesion.self).first?.userID
            p = realm.objects(Persona.self).filter("userID == %@", id).first!
            
            m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", dia1, id!)
            
            desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
            snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
            almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
            snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
            cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia1, id!)
            
            
            
            mCustom = realm.objects(Meal.self).filter("custom = true AND dia == %@", dia1)
            
            cuentaMacros()
            
            inicioTableView.reloadData()

        
    }
    
    @IBAction func pressedD2(_ sender: UIButton) {

            diaElegido = dia2

        if diaElegido == "lunes"{
            labelDia.text = "Lunes"
        } else if diaElegido == "martes"{
            labelDia.text = "Martes"
        } else if diaElegido == "miercoles"{
            labelDia.text = "Miércoles"
        } else if diaElegido == "jueves"{
            labelDia.text = "Jueves"
        } else if diaElegido == "viernes"{
            labelDia.text = "Viernes"
        } else if diaElegido == "sabado"{
            labelDia.text = "Sábado"
        } else if diaElegido == "domingo"{
            labelDia.text = "Domingo"
        }
        
            d2.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            let realm = try! Realm()
            
            let id = realm.objects(Sesion.self).first?.userID
            p = realm.objects(Persona.self).filter("userID == %@", id).first!
            
            m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", dia2, id!)
            
            desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia2, id!)
            snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia2, id!)
            almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia2, id!)
            snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia2, id!)
            cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia2, id!)
            
            
            mCustom = realm.objects(Meal.self).filter("custom = true AND dia == %@", dia2)
            
            cuentaMacros()
            
            inicioTableView.reloadData()
       

    }
    
    @IBAction func pressedD3(_ sender: Any) {
        if premium == false {
            print("PAGA P MIERDA")
            let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
            present(vcP, animated: true, completion: nil)
        } else {
            diaElegido = dia3
            if diaElegido == "lunes"{
                labelDia.text = "Lunes"
            } else if diaElegido == "martes"{
                labelDia.text = "Martes"
            } else if diaElegido == "miercoles"{
                labelDia.text = "Miércoles"
            } else if diaElegido == "jueves"{
                labelDia.text = "Jueves"
            } else if diaElegido == "viernes"{
                labelDia.text = "Viernes"
            } else if diaElegido == "sabado"{
                labelDia.text = "Sábado"
            } else if diaElegido == "domingo"{
                labelDia.text = "Domingo"
            }
            d3.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            let realm = try! Realm()
            
            let id = realm.objects(Sesion.self).first?.userID
            p = realm.objects(Persona.self).filter("userID == %@", id).first!
            
            m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", dia3, id!)
            
            desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia3, id!)
            snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia3, id!)
            almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia3, id!)
            snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia3, id!)
            cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia3, id!)
            
            
            mCustom = realm.objects(Meal.self).filter("custom = true AND dia == %@", dia3)
            
            cuentaMacros()
            
            inicioTableView.reloadData()
        }

    }
    
    @IBAction func pressedD4(_ sender: UIButton) {
        if premium == false {
            let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
            present(vcP, animated: true, completion: nil)
            print("PAGA P MIERDA")
        } else {
            diaElegido = dia4
            if diaElegido == "lunes"{
                labelDia.text = "Lunes"
            } else if diaElegido == "martes"{
                labelDia.text = "Martes"
            } else if diaElegido == "miercoles"{
                labelDia.text = "Miércoles"
            } else if diaElegido == "jueves"{
                labelDia.text = "Jueves"
            } else if diaElegido == "viernes"{
                labelDia.text = "Viernes"
            } else if diaElegido == "sabado"{
                labelDia.text = "Sábado"
            } else if diaElegido == "domingo"{
                labelDia.text = "Domingo"
            }
            d4.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            let realm = try! Realm()
            
            let id = realm.objects(Sesion.self).first?.userID
            p = realm.objects(Persona.self).filter("userID == %@", id).first!
            
            m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", dia4, id!)
            
            desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia4, id!)
            snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia4, id!)
            almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia4, id!)
            snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia4, id!)
            cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia4, id!)
            
            
            mCustom = realm.objects(Meal.self).filter("custom = true AND dia == %@", dia4)
            
            cuentaMacros()
            
            inicioTableView.reloadData()
        }

    }
    
    @IBAction func pressedD5(_ sender: UIButton) {
        if premium == false {
            print("PAGA P MIERDA")
            let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
            present(vcP, animated: true, completion: nil)
        } else {
            diaElegido = dia5
            if diaElegido == "lunes"{
                labelDia.text = "Lunes"
            } else if diaElegido == "martes"{
                labelDia.text = "Martes"
            } else if diaElegido == "miercoles"{
                labelDia.text = "Miércoles"
            } else if diaElegido == "jueves"{
                labelDia.text = "Jueves"
            } else if diaElegido == "viernes"{
                labelDia.text = "Viernes"
            } else if diaElegido == "sabado"{
                labelDia.text = "Sábado"
            } else if diaElegido == "domingo"{
                labelDia.text = "Domingo"
            }
            inicioTableView.reloadData()
            d5.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            let realm = try! Realm()
            
            let id = realm.objects(Sesion.self).first?.userID
            p = realm.objects(Persona.self).filter("userID == %@", id).first!
            
            m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", dia5, id!)
            
            desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia5, id!)
            snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia5, id!)
            almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia5, id!)
            snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia5, id!)
            cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia5, id!)
            
            
            mCustom = realm.objects(Meal.self).filter("custom = true AND dia == %@", dia5)
            
            cuentaMacros()
            
            inicioTableView.reloadData()
        }

    }
    
    @IBAction func pressedD6(_ sender: UIButton) {
        if premium == false {
            print("PAGA P MIERDA")
            let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
            present(vcP, animated: true, completion: nil)
        } else {
            diaElegido = dia6
            if diaElegido == "lunes"{
                labelDia.text = "Lunes"
            } else if diaElegido == "martes"{
                labelDia.text = "Martes"
            } else if diaElegido == "miercoles"{
                labelDia.text = "Miércoles"
            } else if diaElegido == "jueves"{
                labelDia.text = "Jueves"
            } else if diaElegido == "viernes"{
                labelDia.text = "Viernes"
            } else if diaElegido == "sabado"{
                labelDia.text = "Sábado"
            } else if diaElegido == "domingo"{
                labelDia.text = "Domingo"
            }
            
            inicioTableView.reloadData()
            d6.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d7.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            let realm = try! Realm()
            
            let id = realm.objects(Sesion.self).first?.userID
            p = realm.objects(Persona.self).filter("userID == %@", id).first!
            
            m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", dia6, id!)
            
            desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia6, id!)
            snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia6, id!)
            almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia6, id!)
            snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia6, id!)
            cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia6, id!)
            
            
            mCustom = realm.objects(Meal.self).filter("custom = true AND dia == %@", dia6)
            
            cuentaMacros()
            
            inicioTableView.reloadData()
            
        }
        
    }
    
    @IBAction func pressedD7(_ sender: UIButton) {
        if premium == false {
            print("PAGA P MIERDA")
            let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
            present(vcP, animated: true, completion: nil)
        } else {
            diaElegido = dia7
            if diaElegido == "lunes"{
                labelDia.text = "Lunes"
            } else if diaElegido == "martes"{
                labelDia.text = "Martes"
            } else if diaElegido == "miercoles"{
                labelDia.text = "Miércoles"
            } else if diaElegido == "jueves"{
                labelDia.text = "Jueves"
            } else if diaElegido == "viernes"{
                labelDia.text = "Viernes"
            } else if diaElegido == "sabado"{
                labelDia.text = "Sábado"
            } else if diaElegido == "domingo"{
                labelDia.text = "Domingo"
            }

            inicioTableView.reloadData()
            d7.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
            d1.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d2.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d3.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d4.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d5.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            d6.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            let realm = try! Realm()
            
            let id = realm.objects(Sesion.self).first?.userID
            p = realm.objects(Persona.self).filter("userID == %@", id).first!
            
            m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", dia7, id!)
            
            desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia7, id!)
            snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia7, id!)
            almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia7, id!)
            snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia7, id!)
            cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@  AND ANY parentMeal.parentDieta.parentPersona.userID == %@", dia7, id!)
            
            mCustom = realm.objects(Meal.self).filter("custom = true AND dia == %@", dia7)
            
            cuentaMacros()
            
            inicioTableView.reloadData()
        }

    }
    
    
    func descripcionCantidad(unidadPorcion: String, porciones: Int) -> String{
        
        var descripcion = ""
        var numero = 0
        var letra = ""
        
        if unidadPorcion == "50g" {
            numero = 50
            letra = "Gramos"
        } else if unidadPorcion == "1 unidad" {
            numero = 1
            letra = "Unidad(es)"
        } else if unidadPorcion == "1 tajada" {
            numero = 1
            letra = "Tajada(s)"
        } else if unidadPorcion == "1 lata" {
            numero = 1
            letra = "Lata(s)"
        } else if unidadPorcion == "1 cuchara" {
            numero = 1
            letra = "Cuchara(s)"
        } else if unidadPorcion == "1 rebanada" {
            numero = 1
            letra = "Rebanada(s)"
        } else if unidadPorcion == "1 pequeño" {
            numero = 1
            letra = "Unidad(es) pequeña(s)"
        } else if unidadPorcion == "1 mitad" {
            numero = 1
            letra = "1 mitad"
        } else if unidadPorcion == "100ml" {
            numero = 100
            letra = "ml"
        } else if unidadPorcion == "5 unidades" {
            numero = 5
            letra = "Unidades"
        } else if unidadPorcion == "Media taza" {
            numero = 1
            letra = "Media taza"
        }
        
        
        let mult = numero * porciones
        descripcion = String(Int(mult)) + " " + letra
        
        
        
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

    func fechas() -> String{
        
        let date = Date()
        let diaNombre = DateFormatter()
        diaNombre.dateFormat = "EEEE"
        let dateName = diaNombre.string(from: date)
        
        var dia1 = ""
        //botones fondo circular
        d1.layer.cornerRadius = d1.frame.size.width/2
        d1.clipsToBounds = true
        d2.layer.cornerRadius = d2.frame.size.width/2
        d2.clipsToBounds = true
        d3.layer.cornerRadius = d3.frame.size.width/2
        d3.clipsToBounds = true
        d4.layer.cornerRadius = d4.frame.size.width/2
        d4.clipsToBounds = true
        d5.layer.cornerRadius = d5.frame.size.width/2
        d5.clipsToBounds = true
        d6.layer.cornerRadius = d6.frame.size.width/2
        d6.clipsToBounds = true
        d7.layer.cornerRadius = d7.frame.size.width/2
        d7.clipsToBounds = true
        
        //numeros
        d1.setTitle(aNumero(fecha: Date()), for: .normal)
        d1.setTitleColor(.red, for: .normal)
        d2.setTitle(aNumero(fecha: Date().mas1), for: .normal)
        d3.setTitle(aNumero(fecha: Date().mas2), for: .normal)
        d4.setTitle(aNumero(fecha: Date().mas3), for: .normal)
        d5.setTitle(aNumero(fecha: Date().mas4), for: .normal)
        d6.setTitle(aNumero(fecha: Date().mas5), for: .normal)
        d7.setTitle(aNumero(fecha: Date().mas6), for: .normal)
        
        switch dateName {
        case "Monday":
            print("HOY ES LUNES")
            //letras
            lblD1.text = "L"
            lblD2.text = "M"
            lblD3.text = "M"
            lblD4.text = "J"
            lblD5.text = "V"
            lblD6.text = "S"
            lblD7.text = "D"
            //dias
            dia1 = "lunes"
            dia2 = "martes"
            dia3 = "miercoles"
            dia4 = "jueves"
            dia5 = "viernes"
            dia6 = "sabado"
            dia7 = "domingo"

            
        case "Tuesday":
            print("HOY ES MARTES")
            //letras
            lblD1.text = "M"
            lblD2.text = "M"
            lblD3.text = "J"
            lblD4.text = "V"
            lblD5.text = "S"
            lblD6.text = "D"
            lblD7.text = "L"
            //dias
            dia1 = "martes"
            dia2 = "miercoles"
            dia3 = "jueves"
            dia4 = "viernes"
            dia5 = "sabado"
            dia6 = "domingo"
            dia7 = "lunes"


        case "Wednesday":
            print("HOY ES MIERCOLES")
            //letras
            lblD1.text = "M"
            lblD2.text = "J"
            lblD3.text = "V"
            lblD4.text = "S"
            lblD5.text = "D"
            lblD6.text = "L"
            lblD7.text = "M"
            //dias
            dia1 = "miercoles"
            dia2 = "jueves"
            dia3 = "sabado"
            dia4 = "domingo"
            dia5 = "lunes"
            dia6 = "martes"
            dia7 = "miercoles"


        case "Thursday":
            print("HOY ES JUEVES")
            //letras
            lblD1.text = "J"
            lblD2.text = "V"
            lblD3.text = "S"
            lblD4.text = "D"
            lblD5.text = "L"
            lblD6.text = "M"
            lblD7.text = "M"
            //dias
            dia1 = "jueves"
            dia2 = "viernes"
            dia3 = "sabado"
            dia4 = "domingo"
            dia5 = "lunes"
            dia6 = "martes"
            dia7 = "miercoles"


        case "Friday":
            print("HOY ES VIERNES")
            //letras
            lblD1.text = "V"
            lblD2.text = "S"
            lblD3.text = "D"
            lblD4.text = "L"
            lblD5.text = "M"
            lblD6.text = "M"
            lblD7.text = "J"
            //dias
            dia1 = "viernes"
            dia2 = "sabado"
            dia3 = "domingo"
            dia4 = "lunes"
            dia5 = "martes"
            dia6 = "miercoles"
            dia7 = "jueves"


        case "Saturday":
            print("HOY ES SABADO")
            //letras
            lblD1.text = "S"
            lblD2.text = "D"
            lblD3.text = "L"
            lblD4.text = "M"
            lblD5.text = "M"
            lblD6.text = "J"
            lblD7.text = "V"
            //dias
            dia1 = "sabado"
            dia2 = "domingo"
            dia3 = "lunes"
            dia4 = "martes"
            dia5 = "miercoles"
            dia6 = "jueves"
            dia7 = "viernes"


        case "Sunday":
            print("HOY ES DOMINGO")
            //letras
            lblD1.text = "D"
            lblD2.text = "L"
            lblD3.text = "M"
            lblD4.text = "M"
            lblD5.text = "J"
            lblD6.text = "V"
            lblD7.text = "S"
            //dias
            dia1 = "domingo"
            dia2 = "lunes"
            dia3 = "martes"
            dia4 = "miercoles"
            dia5 = "jueves"
            dia6 = "viernes"
            dia7 = "sabado"

        default:
            print("NO DEBERIA ENTRAR ACA")
        }
        
        return dia1
    }

    

    func guardarItemMeal(meal: Meal) {
        
        print("MEAL A GUARDAR ES ")
        print(meal)
        
    }

    func agregarItemAMeal(meal: Meal) {
        //viene con el id

        performSegue(withIdentifier: "seleccionarItemsSegue", sender: self)
        
        idMeal = meal.id

    }
    
    func cambiarMeal(meal: Meal) {
        //LOGICA
        print("entra funcion cambiarMeal e imprime el meal")
        print(meal)
        
        let realm = try! Realm()
        let id = realm.objects(Sesion.self).first?.userID

        
        let itemsSeleccionados = realm.objects(AlimentosBase.self).filter("seleccionado = true")

        
        
        let macros = [meal.prot, meal.fat, meal.carb]
        
        let contadorCambio = realm.objects(Meal.self).filter("dia == %@ AND tipoMeal == %@ AND ANY parentDieta.parentPersona.userID == %@", meal.dia, meal.tipoMeal, id!).first?.cambioFree

        print("CONTADOR CAMBIO FREE")
        print(contadorCambio)
        
        if premium == false {
            if contadorCambio! < 1 {
                
                makeMeal(dia: meal.dia, tipoMeal: meal.tipoMeal, seleccionados: itemsSeleccionados)
                
                m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", meal.dia, id!)
                
                desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
                snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
                almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
                snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
                cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
                
                
                cuentaMacros()
                
                inicioTableView.reloadData()
                
            } else {
                // VERSION PAGA
                print("SEAS PENDEJO PAGA P")
                let vcP = storyboard?.instantiateViewController(withIdentifier: "HaztePremium") as! InicioSesionFB.PremiumVC
                present(vcP, animated: true, completion: nil)
            }
            
        } else {
            
            makeMeal(dia: meal.dia, tipoMeal: meal.tipoMeal, seleccionados: itemsSeleccionados)
            
            m = realm.objects(Meal.self).filter("dia == %@ AND ANY parentDieta.parentPersona.userID == %@", meal.dia, id!)
            
            desayuno = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'desayuno' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
            snack = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
            almuerzo = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'almuerzo' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
            snack2 = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'snack2' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
            cena = realm.objects(Alimento.self).filter("ANY parentMeal.tipoMeal = 'cena' AND ANY parentMeal.dia == %@ AND ANY parentMeal.parentDieta.parentPersona.userID == %@", meal.dia, id!)
            
            
            cuentaMacros()
            
            inicioTableView.reloadData()
            
        }


    }
    
    
    @IBAction func agregarMealManual(_ sender: UIButton) {
        
        //meal custom vacia
                let realm = try! Realm()

                let mealCustom = Meal()
                mealCustom.custom = true
                mealCustom.dia = diaElegido
                mealCustom.id = 99
        
        let id = realm.objects(Sesion.self).first?.userID
        let infoPersona = realm.objects(Persona.self).filter("userID == %@", id).first
                do {
                    try realm.write {
                        infoPersona?.dieta.first!.meals.append(mealCustom)
                    }
        
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
        
        mCustom = realm.objects(Meal.self).filter("custom = true AND dia == %@", diaElegido)

        customInicioTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellToReturn = UITableViewCell() // Dummy value

        if tableView == self.inicioTableView {

        print("inicia funcion cellforrowat AUTOMATICO")
        let cell = tableView.dequeueReusableCell(withIdentifier: "alimentoCustomCell", for: indexPath) as! AlimentoTableViewCell

        let alimentoVacio = Alimento()

        if  m?.count == 2{
             if indexPath.section == 0 {
                let item = almuerzo?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }  else if indexPath.section == 1 {
                let item = cena?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }
            
        } else if  m?.count == 3{
            if indexPath.section == 0 {
                let item = desayuno?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }  else if indexPath.section == 1 {
                let item = almuerzo?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }  else if indexPath.section == 2 {
                let item = cena?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }
            
        } else if  m?.count == 4{
                if indexPath.section == 0 {
                let item = desayuno?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                    cell.idAlimento.text = String(item.id)
                    cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            } else if indexPath.section == 1 {
                let item = almuerzo?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                    cell.calAlimento.text = String(item.cal)
                    cell.protAlimento.text = String(item.prot)
                    cell.carbAlimento.text = String(item.carb)
                    cell.fatAlimento.text = String(item.fat)
                    cell.idAlimento.text = String(item.id)
                    cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }  else if indexPath.section == 2 {
                let item = snack?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                    cell.calAlimento.text = String(item.cal)
                    cell.protAlimento.text = String(item.prot)
                    cell.carbAlimento.text = String(item.carb)
                    cell.fatAlimento.text = String(item.fat)
                    cell.idAlimento.text = String(item.id)
                    cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }  else if indexPath.section == 3 {
                let item = cena?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                    cell.calAlimento.text = String(item.cal)
                    cell.protAlimento.text = String(item.prot)
                    cell.carbAlimento.text = String(item.carb)
                    cell.fatAlimento.text = String(item.fat)
                    cell.idAlimento.text = String(item.id)
                    cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }
            
        } else if  m?.count == 5{
            if indexPath.section == 0 {
                let item = desayuno?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            } else if indexPath.section == 1 {
                let item = snack?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }  else if indexPath.section == 2 {
                let item = almuerzo?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }  else if indexPath.section == 3 {
                let item = snack2?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            } else if indexPath.section == 4 {
                let item = cena?[indexPath.row] ?? alimentoVacio
                cell.nombreAlimento.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcionAlimento.text = porcion
                cell.unidadAlimento.text = item.unidadPorcion
                cell.calAlimento.text = String(item.cal)
                cell.protAlimento.text = String(item.prot)
                cell.carbAlimento.text = String(item.carb)
                cell.fatAlimento.text = String(item.fat)
                cell.idAlimento.text = String(item.id)
                cell.descCant.text = descripcionCantidad(unidadPorcion: item.unidadPorcion, porciones: Int(porcion)!)
            }
        }
        
        cellToReturn = cell

        } else if tableView == self.customInicioTableView {
            print("inicia funcion cellforrowat MANUAL")

            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomAlimentosCustomCell", for: indexPath) as! CustomAlimentosTableViewCell
            
            let alimentoVacio = Alimento()
            

            print("ABC")

//            if desayunoCustom?.first != nil {
            if mCustom?.first != nil {
                print("DEF")

                if mCustom?[indexPath.section].alimentos.first != nil {
                print("ESTA LLENO")
//                let item = desayunoCustom?[indexPath.row] ?? alimentoVacio
                let item = mCustom?[indexPath.section].alimentos[indexPath.row] ?? alimentoVacio
                cell.nombre.text = item.nombre
                var n: Int = 0
                n = item.porcion
                let porcion = String(n)
                cell.porcion.text = porcion
                cell.unidad.text = item.unidadPorcion
                }
            } else {
                print("ESTA VACIO")
                let item = alimentoVacio
                cell.nombre.text = item.nombre
            }
            
            cellToReturn = cell

        }
        
        return cellToReturn
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerCellToReturn = UITableViewHeaderFooterView() // Dummy value
        
        if tableView == self.inicioTableView {
            print("ENTRA viewForHeaderInSection TABLA AUTOMATICA")

            let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerAlimentoCustomCell") as! HeaderAlimentoTableViewCell
            
            headerCell.nombreMeal.text = m?[section].tipoMeal ?? "no hay datos..."
            
            if m?.first != nil {
                headerCell.cantCal.text = String(Int(round(m![section].cal)))
                headerCell.cantProt.text = String(Int(round(m![section].prot)))
                headerCell.cantFat.text = String(Int(round(m![section].fat)))
                headerCell.cantCarb.text = String(Int(round(m![section].carb)))
                headerCell.dia.text = String(m![section].dia)
            }
            
            headerCell.delegate = self
            
            headerCellToReturn = headerCell
            print("SALE viewForHeaderInSection AUTOMATICA")

        } else if tableView == self.customInicioTableView {
            print("ENTRA viewForHeaderInSection TABLA MANUAL")

            let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerSeleccionarCustomCell") as! HeaderSeleccionarTableViewCell
            
            print("PRUEBA")
           
            //el .dia si devuleve nil. el first solo devuelve vacio pero no nil
            if mCustom?.first?.dia != nil {
                        headerCell.nombreMeal.text = mCustom?[section].tipoMeal
                                headerCell.id.text = String(section)
                
                                headerCell.cantCal.text = String(m![section].cal)
                                headerCell.cantProt.text = String(m![section].prot)
                                headerCell.cantFat.text = String(m![section].fat)
                                headerCell.cantCarb.text = String(m![section].carb)
                                headerCell.dia.text = String(m![section].dia)

            } else {
                headerCell.nombreMeal.text = "Ingrese datos"
                headerCell.id.text = String(section)

                
            }

        
            headerCell.delegate = self
            
            headerCellToReturn = headerCell
            print("SALE viewForHeaderInSection MANUAL")

        }

        return headerCellToReturn
    }
    

    
    public  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 86
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var filas = 0
        
        if tableView == self.inicioTableView {
            print("ENTRA numberOfRowsInSection AUTOMATICO")

            if m?.count == 2{
                if section == 0 {
                    filas = almuerzo?.count ?? 1
                } else if section == 1 {
                    filas = cena?.count ?? 1
                }
            } else if  m?.count == 3{
                if section == 0 {
                    filas = desayuno?.count ?? 1
                } else if section == 1 {
                    filas = almuerzo?.count ?? 1
                } else if section == 2 {
                    filas = cena?.count ?? 1
                }
            } else if  m?.count == 4{
                if section == 0 {
                    filas = desayuno?.count ?? 1
                } else if section == 1 {
                    filas = almuerzo?.count ?? 1
                } else if section == 2 {
                    filas = snack?.count ?? 1
                } else if section == 3 {
                    filas = cena?.count ?? 1
                }
            } else if  m?.count == 5{
                if section == 0 {
                    filas = desayuno?.count ?? 1
                } else if section == 1 {
                    filas = snack?.count ?? 1
                } else if section == 2 {
                    filas = almuerzo?.count ?? 1
                } else if section == 3 {
                    filas = snack2?.count ?? 1
                } else if section == 4 {
                    filas = cena?.count ?? 1
                }
            }

            
        } else if tableView == self.customInicioTableView {
            print("ENTRA numberOfRowsInSection MANUAL")

            print("numero de filas en tabla manual")
            
            if mCustom?.first?.dia != nil {
            filas = (mCustom?.first?.alimentos.count)!
            } else {
                filas = 1
            }
        }
        
        print(filas)
        
        return filas
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        var secciones = 1

        if tableView == self.inicioTableView {
            //queda
            secciones = m?.count ?? 1
        }else if tableView == self.customInicioTableView {
//            if mCustom?.first != nil {
//                print("EXISTE")
//                secciones = (mCustom?.count)!
//            } else {
//                print("NO EXISTE")
//                secciones = 1
//            }
            
            
                secciones = mCustom?.count ?? 1
            
        }
        if secciones == 0 {
            secciones = 1
        }
        
        print("SECCIONES")
        print(secciones)
        
        return secciones
    }
    

    //cuando el usuario hace tap en una celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hizo tap")
        print(indexPath)
        
        if  m?.count == 2{
            if indexPath.section == 0 {
                itemSeleccionado = (almuerzo?[indexPath.row])!
     
            }  else if indexPath.section == 1 {
                itemSeleccionado = (cena?[indexPath.row])!

            }
            
        } else if  m?.count == 3{
            if indexPath.section == 0 {
                itemSeleccionado = (desayuno?[indexPath.row])!

                
            }  else if indexPath.section == 1 {
                itemSeleccionado = (almuerzo?[indexPath.row])!

            }  else if indexPath.section == 2 {
                itemSeleccionado = (cena?[indexPath.row])!

            }
            
        } else if  m?.count == 4{
            if indexPath.section == 0 {
                itemSeleccionado = (desayuno?[indexPath.row])!
            
            } else if indexPath.section == 1 {
                itemSeleccionado = (almuerzo?[indexPath.row])!
               
            }  else if indexPath.section == 2 {
                itemSeleccionado = (snack?[indexPath.row])!
                
            }  else if indexPath.section == 3 {
                itemSeleccionado = (cena?[indexPath.row])!
               
            }
            
        } else if  m?.count == 5{
            if indexPath.section == 0 {
                itemSeleccionado = (desayuno?[indexPath.row])!

            } else if indexPath.section == 1 {
                itemSeleccionado = (snack?[indexPath.row])!

            }  else if indexPath.section == 2 {
                itemSeleccionado = (almuerzo?[indexPath.row])!

            }  else if indexPath.section == 3 {
                itemSeleccionado = (snack2?[indexPath.row])!

            } else if indexPath.section == 4 {
                itemSeleccionado = (cena?[indexPath.row])!

            }
        }
        
        
        performSegue(withIdentifier: "popUpSegue", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "popUpSegue") {
            // initialize new view controller and cast it as your view controller
            print("SEGUE A POPUP")
            print(itemSeleccionado)
            var vc = segue.destination as! PopUpAlimentosViewController
    
            vc.nombreAlimento = itemSeleccionado.nombre
            vc.cantidad = descripcionCantidad(unidadPorcion: itemSeleccionado.unidadPorcion, porciones: itemSeleccionado.porcion)
            vc.cal = itemSeleccionado.cal
            vc.prot = itemSeleccionado.prot
            vc.fat = itemSeleccionado.fat
            vc.carb = itemSeleccionado.carb
            vc.notas = "falta definir BLABLABLA"
            
        } else if (segue.identifier == "seleccionarItemsSegue") {
            // initialize new view controller and cast it as your view controller

            var vc = segue.destination as! seleccionarCustomAlimentoVC
            vc.id = idMeal
            vc.dia = diaElegido
            
            
        }
        
        
    }
    
    
    
    public func randomNumber<T : SignedInteger>(inRange range: ClosedRange<T> = 1...6) -> T {
        let length = Int64(range.upperBound - range.lowerBound + 1)
        let value = Int64(arc4random()) % length + Int64(range.lowerBound)
        return T(value)
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


