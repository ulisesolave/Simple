//
//  CuentaEmailVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 7/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class CuentaEmailVC: UIViewController {
    var calorias = 0.0
    var items = [Int]()
    var cantidadMeals = 0
    var objetivo = ""
    var peso = 0.0
    var macros = [Double]()
    var altura = 0.0
    var sexo = ""
    
    
    //para guardar en tabla Dieta
    var pesoMeta = 0.0
    var semanas = 0
    
    
    @IBOutlet weak var viewCorreoContrasena: UIView!
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var contrasena: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("EN VC CUENTAEMAILVC EL VALOR DE CALORIAS ES")
        print(calorias)
        print("ITEMS")
        print(items)
        print("MACROS")
        print("-------")
        print(macros)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contrasena.resignFirstResponder()
        correo.resignFirstResponder()
        
    }

    
    @IBAction func registrarPressed(_ sender: UIButton) {
        print("Entra registrar")
        sender.isUserInteractionEnabled = false;
        contrasena.resignFirstResponder()
        correo.resignFirstResponder()

        Auth.auth().createUser(withEmail: correo.text!, password: contrasena.text!) { (user, error) in
            // ...
            
            if let u = user {
                GifVC.instance.showLoader()

                let realm = try! Realm()
                print("URL REALM")
                print(Realm.Configuration.defaultConfiguration.fileURL)
                
                let p = Peso()
                p.pesoKg = self.peso
                p.fechaRegistro = self.fechaStringADate(fechaString: Date().string(format: "dd/MM/yyyy"))

                
                let die = Dieta()
                die.calTarget = self.calorias
                die.cantMeals = self.cantidadMeals
                die.objetivo = self.objetivo
                die.fechaRegistro = Date()
                die.fechaFin = Calendar.current.date(byAdding: .day, value: self.semanas * 7, to: Date())
                die.pesoInicial = self.peso
                die.pesoMeta = self.pesoMeta
                die.semanas = self.semanas
                die.grProt = self.macros[0]
                die.grFat = self.macros[1]
                die.grCarb = self.macros[2]
                
                
                let persona = Persona()

                let userID = Auth.auth().currentUser!.uid
                persona.userID = userID
                persona.nombre = ""
                persona.correo = self.correo.text!
                persona.altura = self.altura
                persona.sexo = self.sexo
                //peso
                persona.pesos.append(p)
                persona.dieta.append(die)
                
                //alimentosBase
                
                let item0 = AlimentosBase ();item0.id = 0;item0.nombre = "Carne";item0.tipoMacro = "Proteina";item0.subMacro = "";item0.cal = 104.3;item0.prot = 13.1;item0.carb = 0.0;item0.fat = 5.8;item0.unidadPorcion = "50g";item0.porcionMin = 2;item0.porcionMax = 5;item0.desayuno = false;item0.almuerzo = true;item0.cena = true;item0.snack = false
                let item1 = AlimentosBase ();item1.id = 1;item1.nombre = "Huevo";item1.tipoMacro = "Proteina";item1.subMacro = "";item1.cal = 82.0;item1.prot = 7.0;item1.carb = 0.5;item1.fat = 5.7;item1.unidadPorcion = "1 unidad";item1.porcionMin = 1;item1.porcionMax = 2;item1.desayuno = true;item1.almuerzo = false;item1.cena = false;item1.snack = false
                let item2 = AlimentosBase ();item2.id = 2;item2.nombre = "Huevo (clara)";item2.tipoMacro = "Proteina";item2.subMacro = "";item2.cal = 15.9;item2.prot = 3.6;item2.carb = 0.2;item2.fat = 0.1;item2.unidadPorcion = "1 unidad";item2.porcionMin = 1;item2.porcionMax = 4;item2.desayuno = true;item2.almuerzo = false;item2.cena = false;item2.snack = false
                let item3 = AlimentosBase ();item3.id = 3;item3.nombre = "Jamon";item3.tipoMacro = "Proteina";item3.subMacro = "";item3.cal = 20.2;item3.prot = 2.5;item3.carb = 1.9;item3.fat = 0.3;item3.unidadPorcion = "1 tajada";item3.porcionMin = 1;item3.porcionMax = 4;item3.desayuno = true;item3.almuerzo = false;item3.cena = false;item3.snack = false
                let item4 = AlimentosBase ();item4.id = 4;item4.nombre = "Pavo";item4.tipoMacro = "Proteina";item4.subMacro = "";item4.cal = 55.2;item4.prot = 11.6;item4.carb = 0.0;item4.fat = 1.0;item4.unidadPorcion = "50g";item4.porcionMin = 2;item4.porcionMax = 5;item4.desayuno = false;item4.almuerzo = true;item4.cena = true;item4.snack = false
                let item5 = AlimentosBase ();item5.id = 5;item5.nombre = "Pescado";item5.tipoMacro = "Proteina";item5.subMacro = "";item5.cal = 66.3;item5.prot = 10.1;item5.carb = 0.0;item5.fat = 2.9;item5.unidadPorcion = "50g";item5.porcionMin = 2;item5.porcionMax = 5;item5.desayuno = false;item5.almuerzo = true;item5.cena = true;item5.snack = false
                let item6 = AlimentosBase ();item6.id = 6;item6.nombre = "Pescado (conserva)";item6.tipoMacro = "Proteina";item6.subMacro = "";item6.cal = 195.5;item6.prot = 28.8;item6.carb = 0.0;item6.fat = 8.9;item6.unidadPorcion = "1 lata";item6.porcionMin = 1;item6.porcionMax = 2;item6.desayuno = false;item6.almuerzo = true;item6.cena = true;item6.snack = false
                let item7 = AlimentosBase ();item7.id = 7;item7.nombre = "Pollo";item7.tipoMacro = "Proteina";item7.subMacro = "";item7.cal = 55.6;item7.prot = 11.5;item7.carb = 0.0;item7.fat = 1.1;item7.unidadPorcion = "50g";item7.porcionMin = 2;item7.porcionMax = 5;item7.desayuno = false;item7.almuerzo = true;item7.cena = true;item7.snack = false
                let item50 = AlimentosBase ();item50.id = 50;item50.nombre = "Arroz Integral";item50.tipoMacro = "Carbohidrato";item50.subMacro = "Arroz";item50.cal = 55.2;item50.prot = 1.2;item50.carb = 11.6;item50.fat = 0.4;item50.unidadPorcion = "50g";item50.porcionMin = 2;item50.porcionMax = 6;item50.desayuno = false;item50.almuerzo = true;item50.cena = true;item50.snack = false
                let item51 = AlimentosBase ();item51.id = 51;item51.nombre = "Avena";item51.tipoMacro = "Carbohidrato";item51.subMacro = "";item51.cal = 62.2;item51.prot = 1.9;item51.carb = 11.0;item51.fat = 1.2;item51.unidadPorcion = "1 cuchara";item51.porcionMin = 2;item51.porcionMax = 4;item51.desayuno = true;item51.almuerzo = false;item51.cena = false;item51.snack = false
                let item52 = AlimentosBase ();item52.id = 52;item52.nombre = "Camote";item52.tipoMacro = "Carbohidrato";item52.subMacro = "Tuberculo";item52.cal = 38.7;item52.prot = 0.7;item52.carb = 8.9;item52.fat = 0.1;item52.unidadPorcion = "50g";item52.porcionMin = 2;item52.porcionMax = 6;item52.desayuno = false;item52.almuerzo = true;item52.cena = true;item52.snack = false
                let item53 = AlimentosBase ();item53.id = 53;item53.nombre = "Cereal Integral";item53.tipoMacro = "Carbohidrato";item53.subMacro = "Cereal";item53.cal = 55.7;item53.prot = 1.5;item53.carb = 11.7;item53.fat = 0.3;item53.unidadPorcion = "1 cuchara";item53.porcionMin = 2;item53.porcionMax = 5;item53.desayuno = true;item53.almuerzo = false;item53.cena = false;item53.snack = true
                let item54 = AlimentosBase ();item54.id = 54;item54.nombre = "Frejoles";item54.tipoMacro = "Carbohidrato";item54.subMacro = "Menestra";item54.cal = 68.3;item54.prot = 4.5;item54.carb = 12.0;item54.fat = 0.3;item54.unidadPorcion = "50g";item54.porcionMin = 2;item54.porcionMax = 6;item54.desayuno = false;item54.almuerzo = true;item54.cena = true;item54.snack = false
                let item55 = AlimentosBase ();item55.id = 55;item55.nombre = "Granola";item55.tipoMacro = "Carbohidrato";item55.subMacro = "Cereal";item55.cal = 68.0;item55.prot = 1.1;item55.carb = 10.4;item55.fat = 2.4;item55.unidadPorcion = "1 cuchara";item55.porcionMin = 2;item55.porcionMax = 4;item55.desayuno = true;item55.almuerzo = false;item55.cena = false;item55.snack = true
                let item56 = AlimentosBase ();item56.id = 56;item56.nombre = "Lentejas";item56.tipoMacro = "Carbohidrato";item56.subMacro = "Menestra";item56.cal = 59.7;item56.prot = 4.5;item56.carb = 10.0;item56.fat = 0.2;item56.unidadPorcion = "50g";item56.porcionMin = 2;item56.porcionMax = 6;item56.desayuno = false;item56.almuerzo = true;item56.cena = true;item56.snack = false
                let item57 = AlimentosBase ();item57.id = 57;item57.nombre = "Pan Integral";item57.tipoMacro = "Carbohidrato";item57.subMacro = "Pan";item57.cal = 83.3;item57.prot = 3.5;item57.carb = 15.0;item57.fat = 1.0;item57.unidadPorcion = "1 rebanada";item57.porcionMin = 1;item57.porcionMax = 4;item57.desayuno = true;item57.almuerzo = false;item57.cena = false;item57.snack = false
                let item58 = AlimentosBase ();item58.id = 58;item58.nombre = "Papa";item58.tipoMacro = "Carbohidrato";item58.subMacro = "Tuberculo";item58.cal = 43.7;item58.prot = 1.1;item58.carb = 9.8;item58.fat = 0.1;item58.unidadPorcion = "50g";item58.porcionMin = 2;item58.porcionMax = 6;item58.desayuno = false;item58.almuerzo = true;item58.cena = true;item58.snack = false
                let item59 = AlimentosBase ();item59.id = 59;item59.nombre = "Quinua";item59.tipoMacro = "Carbohidrato";item59.subMacro = "Menestra";item59.cal = 60.0;item59.prot = 2.2;item59.carb = 10.7;item59.fat = 1.0;item59.unidadPorcion = "50g";item59.porcionMin = 2;item59.porcionMax = 6;item59.desayuno = false;item59.almuerzo = true;item59.cena = true;item59.snack = false
                let item60 = AlimentosBase ();item60.id = 60;item60.nombre = "Spaguetti";item60.tipoMacro = "Carbohidrato";item60.subMacro = "Pasta";item60.cal = 80.2;item60.prot = 2.9;item60.carb = 17.0;item60.fat = 0.1;item60.unidadPorcion = "50g";item60.porcionMin = 2;item60.porcionMax = 8;item60.desayuno = false;item60.almuerzo = true;item60.cena = true;item60.snack = false
                let item61 = AlimentosBase ();item61.id = 61;item61.nombre = "Yuca";item61.tipoMacro = "Carbohidrato";item61.subMacro = "Tuberculo";item61.cal = 77.4;item61.prot = 0.5;item61.carb = 18.6;item61.fat = 0.1;item61.unidadPorcion = "50g";item61.porcionMin = 2;item61.porcionMax = 6;item61.desayuno = false;item61.almuerzo = true;item61.cena = true;item61.snack = false
                let item100 = AlimentosBase ();item100.id = 100;item100.nombre = "Almendras";item100.tipoMacro = "Grasa";item100.subMacro = "";item100.cal = 94.3;item100.prot = 3.3;item100.carb = 2.6;item100.fat = 7.9;item100.unidadPorcion = "1 cuchara";item100.porcionMin = 1;item100.porcionMax = 3;item100.desayuno = false;item100.almuerzo = false;item100.cena = false;item100.snack = true
                let item101 = AlimentosBase ();item101.id = 101;item101.nombre = "Cashews";item101.tipoMacro = "Grasa";item101.subMacro = "";item101.cal = 88.9;item101.prot = 2.7;item101.carb = 4.7;item101.fat = 6.6;item101.unidadPorcion = "1 cuchara";item101.porcionMin = 1;item101.porcionMax = 3;item101.desayuno = false;item101.almuerzo = false;item101.cena = false;item101.snack = true
                let item102 = AlimentosBase ();item102.id = 102;item102.nombre = "Chia";item102.tipoMacro = "Grasa";item102.subMacro = "";item102.cal = 77.1;item102.prot = 3.0;item102.carb = 5.5;item102.fat = 4.8;item102.unidadPorcion = "1 cuchara";item102.porcionMin = 1;item102.porcionMax = 2;item102.desayuno = true;item102.almuerzo = false;item102.cena = false;item102.snack = false
                let item103 = AlimentosBase ();item103.id = 103;item103.nombre = "Chocolate negro 80%";item103.tipoMacro = "Grasa";item103.subMacro = "";item103.cal = 107.6;item103.prot = 1.8;item103.carb = 8.2;item103.fat = 7.5;item103.unidadPorcion = "1 pequeño";item103.porcionMin = 1;item103.porcionMax = 3;item103.desayuno = false;item103.almuerzo = false;item103.cena = false;item103.snack = true
                let item104 = AlimentosBase ();item104.id = 104;item104.nombre = "Linaza";item104.tipoMacro = "Grasa";item104.subMacro = "";item104.cal = 86.2;item104.prot = 2.9;item104.carb = 4.3;item104.fat = 6.3;item104.unidadPorcion = "1 cuchara";item104.porcionMin = 1;item104.porcionMax = 2;item104.desayuno = true;item104.almuerzo = false;item104.cena = false;item104.snack = false
                let item105 = AlimentosBase ();item105.id = 105;item105.nombre = "Mani";item105.tipoMacro = "Grasa";item105.subMacro = "";item105.cal = 90.3;item105.prot = 4.0;item105.carb = 2.4;item105.fat = 7.2;item105.unidadPorcion = "1 cuchara";item105.porcionMin = 1;item105.porcionMax = 3;item105.desayuno = false;item105.almuerzo = false;item105.cena = false;item105.snack = true
                let item106 = AlimentosBase ();item106.id = 106;item106.nombre = "Palta";item106.tipoMacro = "Grasa";item106.subMacro = "";item106.cal = 164.9;item106.prot = 1.9;item106.carb = 7.7;item106.fat = 14.1;item106.unidadPorcion = "1 mitad";item106.porcionMin = 1;item106.porcionMax = 2;item106.desayuno = true;item106.almuerzo = true;item106.cena = true;item106.snack = false
                let item107 = AlimentosBase ();item107.id = 107;item107.nombre = "Pecana";item107.tipoMacro = "Grasa";item107.subMacro = "";item107.cal = 108.6;item107.prot = 1.8;item107.carb = 1.9;item107.fat = 10.4;item107.unidadPorcion = "1 cuchara";item107.porcionMin = 1;item107.porcionMax = 3;item107.desayuno = false;item107.almuerzo = false;item107.cena = false;item107.snack = true
                let item150 = AlimentosBase ();item150.id = 150;item150.nombre = "Leche";item150.tipoMacro = "Lacteo";item150.subMacro = "";item150.cal = 44.3;item150.prot = 3.0;item150.carb = 4.9;item150.fat = 1.4;item150.unidadPorcion = "100ml";item150.porcionMin = 2;item150.porcionMax = 4;item150.desayuno = true;item150.almuerzo = false;item150.cena = false;item150.snack = false
                let item151 = AlimentosBase ();item151.id = 151;item151.nombre = "Queso";item151.tipoMacro = "Lacteo";item151.subMacro = "";item151.cal = 63.6;item151.prot = 4.5;item151.carb = 0.4;item151.fat = 4.9;item151.unidadPorcion = "1 tajada";item151.porcionMin = 1;item151.porcionMax = 3;item151.desayuno = true;item151.almuerzo = false;item151.cena = false;item151.snack = false
                let item152 = AlimentosBase ();item152.id = 152;item152.nombre = "Yogurt";item152.tipoMacro = "Lacteo";item152.subMacro = "";item152.cal = 58.8;item152.prot = 3.2;item152.carb = 9.5;item152.fat = 0.9;item152.unidadPorcion = "100ml";item152.porcionMin = 2;item152.porcionMax = 4;item152.desayuno = true;item152.almuerzo = false;item152.cena = false;item152.snack = false
                let item200 = AlimentosBase ();item200.id = 200;item200.nombre = "Aceituna";item200.tipoMacro = "Fruta";item200.subMacro = "";item200.cal = 28.3;item200.prot = 0.2;item200.carb = 1.0;item200.fat = 2.6;item200.unidadPorcion = "5 unidades";item200.porcionMin = 1;item200.porcionMax = 4;item200.desayuno = true;item200.almuerzo = false;item200.cena = false;item200.snack = true
                let item201 = AlimentosBase ();item201.id = 201;item201.nombre = "Aguaymanto";item201.tipoMacro = "Fruta";item201.subMacro = "";item201.cal = 69.5;item201.prot = 2.3;item201.carb = 13.2;item201.fat = 0.8;item201.unidadPorcion = "Media taza";item201.porcionMin = 1;item201.porcionMax = 1;item201.desayuno = true;item201.almuerzo = false;item201.cena = false;item201.snack = true
                let item202 = AlimentosBase ();item202.id = 202;item202.nombre = "Arandanos";item202.tipoMacro = "Fruta";item202.subMacro = "";item202.cal = 60.6;item202.prot = 0.5;item202.carb = 14.4;item202.fat = 0.1;item202.unidadPorcion = "Media taza";item202.porcionMin = 1;item202.porcionMax = 2;item202.desayuno = true;item202.almuerzo = false;item202.cena = false;item202.snack = true
                let item203 = AlimentosBase ();item203.id = 203;item203.nombre = "Durazno";item203.tipoMacro = "Fruta";item203.subMacro = "";item203.cal = 72.8;item203.prot = 1.4;item203.carb = 16.1;item203.fat = 0.3;item203.unidadPorcion = "1 unidad";item203.porcionMin = 1;item203.porcionMax = 1;item203.desayuno = true;item203.almuerzo = false;item203.cena = false;item203.snack = true
                let item204 = AlimentosBase ();item204.id = 204;item204.nombre = "Fresa";item204.tipoMacro = "Fruta";item204.subMacro = "";item204.cal = 49.1;item204.prot = 0.8;item204.carb = 10.0;item204.fat = 0.7;item204.unidadPorcion = "Media taza";item204.porcionMin = 1;item204.porcionMax = 2;item204.desayuno = true;item204.almuerzo = false;item204.cena = false;item204.snack = true
                let item205 = AlimentosBase ();item205.id = 205;item205.nombre = "Mandarina";item205.tipoMacro = "Fruta";item205.subMacro = "";item205.cal = 62.6;item205.prot = 0.9;item205.carb = 14.0;item205.fat = 0.4;item205.unidadPorcion = "1 unidad";item205.porcionMin = 1;item205.porcionMax = 1;item205.desayuno = true;item205.almuerzo = false;item205.cena = false;item205.snack = true
                let item206 = AlimentosBase ();item206.id = 206;item206.nombre = "Mango";item206.tipoMacro = "Fruta";item206.subMacro = "";item206.cal = 83.7;item206.prot = 0.5;item206.carb = 19.7;item206.fat = 0.3;item206.unidadPorcion = "Media taza";item206.porcionMin = 1;item206.porcionMax = 2;item206.desayuno = true;item206.almuerzo = false;item206.cena = false;item206.snack = true
                let item207 = AlimentosBase ();item207.id = 207;item207.nombre = "Manzana";item207.tipoMacro = "Fruta";item207.subMacro = "";item207.cal = 100.7;item207.prot = 0.4;item207.carb = 24.2;item207.fat = 0.2;item207.unidadPorcion = "1 unidad";item207.porcionMin = 1;item207.porcionMax = 1;item207.desayuno = true;item207.almuerzo = false;item207.cena = false;item207.snack = true
                let item208 = AlimentosBase ();item208.id = 208;item208.nombre = "Naranja";item208.tipoMacro = "Fruta";item208.subMacro = "";item208.cal = 96.4;item208.prot = 1.5;item208.carb = 21.9;item208.fat = 0.3;item208.unidadPorcion = "1 unidad";item208.porcionMin = 1;item208.porcionMax = 1;item208.desayuno = true;item208.almuerzo = false;item208.cena = false;item208.snack = true
                let item209 = AlimentosBase ();item209.id = 209;item209.nombre = "Papaya";item209.tipoMacro = "Fruta";item209.subMacro = "";item209.cal = 46.9;item209.prot = 0.6;item209.carb = 10.8;item209.fat = 0.1;item209.unidadPorcion = "Media taza";item209.porcionMin = 1;item209.porcionMax = 2;item209.desayuno = true;item209.almuerzo = false;item209.cena = false;item209.snack = true
                let item210 = AlimentosBase ();item210.id = 210;item210.nombre = "Pera";item210.tipoMacro = "Fruta";item210.subMacro = "";item210.cal = 92.6;item210.prot = 0.6;item210.carb = 21.3;item210.fat = 0.5;item210.unidadPorcion = "1 unidad";item210.porcionMin = 1;item210.porcionMax = 1;item210.desayuno = true;item210.almuerzo = false;item210.cena = false;item210.snack = true
                let item211 = AlimentosBase ();item211.id = 211;item211.nombre = "Piña";item211.tipoMacro = "Fruta";item211.subMacro = "";item211.cal = 57.8;item211.prot = 0.6;item211.carb = 13.5;item211.fat = 0.2;item211.unidadPorcion = "Media taza";item211.porcionMin = 1;item211.porcionMax = 2;item211.desayuno = true;item211.almuerzo = false;item211.cena = false;item211.snack = true
                let item212 = AlimentosBase ();item212.id = 212;item212.nombre = "Platano";item212.tipoMacro = "Fruta";item212.subMacro = "";item212.cal = 95.7;item212.prot = 1.3;item212.carb = 21.9;item212.fat = 0.3;item212.unidadPorcion = "1 unidad";item212.porcionMin = 1;item212.porcionMax = 1;item212.desayuno = true;item212.almuerzo = false;item212.cena = false;item212.snack = true
                let item213 = AlimentosBase ();item213.id = 213;item213.nombre = "Sandia";item213.tipoMacro = "Fruta";item213.subMacro = "";item213.cal = 36.6;item213.prot = 0.8;item213.carb = 8.0;item213.fat = 0.2;item213.unidadPorcion = "Media taza";item213.porcionMin = 1;item213.porcionMax = 2;item213.desayuno = true;item213.almuerzo = false;item213.cena = false;item213.snack = true
                let item214 = AlimentosBase ();item214.id = 214;item214.nombre = "Uva";item214.tipoMacro = "Fruta";item214.subMacro = "";item214.cal = 90.4;item214.prot = 0.5;item214.carb = 21.7;item214.fat = 0.2;item214.unidadPorcion = "Media taza";item214.porcionMin = 1;item214.porcionMax = 2;item214.desayuno = true;item214.almuerzo = false;item214.cena = false;item214.snack = true

                
                persona.alimentosBase.append(item0)
                persona.alimentosBase.append(item1)
                persona.alimentosBase.append(item2)
                persona.alimentosBase.append(item3)
                persona.alimentosBase.append(item4)
                persona.alimentosBase.append(item5)
                persona.alimentosBase.append(item6)
                persona.alimentosBase.append(item7)
                persona.alimentosBase.append(item50)
                persona.alimentosBase.append(item51)
                persona.alimentosBase.append(item52)
                persona.alimentosBase.append(item53)
                persona.alimentosBase.append(item54)
                persona.alimentosBase.append(item55)
                persona.alimentosBase.append(item56)
                persona.alimentosBase.append(item57)
                persona.alimentosBase.append(item58)
                persona.alimentosBase.append(item59)
                persona.alimentosBase.append(item60)
                persona.alimentosBase.append(item61)
                persona.alimentosBase.append(item100)
                persona.alimentosBase.append(item101)
                persona.alimentosBase.append(item102)
                persona.alimentosBase.append(item103)
                persona.alimentosBase.append(item104)
                persona.alimentosBase.append(item105)
                persona.alimentosBase.append(item106)
                persona.alimentosBase.append(item107)
                persona.alimentosBase.append(item150)
                persona.alimentosBase.append(item151)
                persona.alimentosBase.append(item152)
                persona.alimentosBase.append(item200)
                persona.alimentosBase.append(item201)
                persona.alimentosBase.append(item202)
                persona.alimentosBase.append(item203)
                persona.alimentosBase.append(item204)
                persona.alimentosBase.append(item205)
                persona.alimentosBase.append(item206)
                persona.alimentosBase.append(item207)
                persona.alimentosBase.append(item208)
                persona.alimentosBase.append(item209)
                persona.alimentosBase.append(item210)
                persona.alimentosBase.append(item211)
                persona.alimentosBase.append(item212)
                persona.alimentosBase.append(item213)
                persona.alimentosBase.append(item214)
                        
                
                //termina alimentosBase

                do {
                    try realm.write {
                        realm.add(persona)
                    }
                } catch {
                    print("ERROR REALM")
                    print(error)
                }
                
                //poner sesion a usuario
                let s = Sesion()
                s.userID = userID
                let ses = realm.objects(Sesion.self).first
                
                if ses == nil {
                    do {
                        try realm.write {
                            realm.add(s)
                        }
                    } catch {
                        print("ERROR REALM")
                        print(error)
                    }
                } else {
                    do {
                        try realm.write {
                            ses?.userID = userID
                        }
                    } catch {
                        print("ERROR REALM")
                        print(error)
                    }
                }
                
                
                
                let id = realm.objects(Sesion.self).first?.userID
                
//                let base = realm.objects(AlimentosBase.self).filter("ANY parentPersona.userID == %@", id!)
                

                for i in 0..<self.items.count {
                    
                    let item = realm.objects(AlimentosBase.self).filter("id == %@ AND ANY parentPersona.userID == %@", self.items[i], id!)
                   
                    do {
                        try realm.write {
                            item.first?.seleccionado = true
                        }
                    } catch {
                        print("ERROR REALM")
                        print(error)
                    }

                }
                
                //                for (index, element) in items.enumerated() {
                //                    //            print("Item \(index): \(element)")
                //                    let items = realm.objects(AlimentosBase.self).filter("id == %@", element)
                //                    if let item = items.first {
                //                        try! realm.write {
                //                            item.seleccionado = true
                //                        }
                //                    }
                //                }
                
                
                
                let deadlineTime = DispatchTime.now() + .seconds(4)
                DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                    self.performSegue(withIdentifier: "empezarSegue", sender: self)
                })
                
            } else if error != nil {
                sender.isUserInteractionEnabled = true;

                self.viewCorreoContrasena.shake()
                print("ERROR CREAR USUARIO EMAIL")

                print(error!._code)
                self.handleError(error!)      // use the handleError method
                return
            }
        }
     
        print("sale registrar")

        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "empezarSegue") {
            
            var vc = segue.destination as! TabBarViewController
            vc.items = items
            
        }
    }
    


    override func viewWillDisappear(_ animated: Bool) {
         GifVC.instance.hideLoader()

    }
    
    func fechaStringADate(fechaString: String) -> Date? { //recibe fecha en formato dd/MM/yyy
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        return dateFormatter.date(from: fechaString)
    }
    

    

}
extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "El correo proporcionado ya está registrado. Por favor, inicie sesión."
        case .userNotFound:
            return "No existe una cuenta vinculada a este correo. ¿No tienes una cuenta? Ingresa a 'Crear cuenta'."
        case .userDisabled:
            return "Tu cuenta ha sido desabilitada, envíanos un correo a XXXX."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Ingresa un correo válido."
        case .networkError:
            return "Error de conexión. Verifica tu conexión y vuelve a intentarlo."
        case .weakPassword:
            return "La contraseña proporcionada es insegura. Debe contener por lo menos 6 caracteres."
        case .wrongPassword:
            return "La contraseña es incorrecta. ¿Olvidaste tu contraseña? Ingresa a 'Olvidé mi contraseña'."
        default:
            return "Error desconocido. Por favor, contáctanos a XXXX."
        }
    }
}

extension UIViewController{
    func handleError(_ error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
