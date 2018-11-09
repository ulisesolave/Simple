//
//  Datos2VC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 6/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class Datos2VC: UIViewController {

    var objetivo = ""
    
    var sexo = ""
    var peso = 0.0
    var edad = 0
    var estatura = 0.0
    var fatLossXweek = 0.0
    var pMeta = 0.0
    var sem = 0

    var bmr = 0.0
    var tdee = 0.0
    var targetCal = 0.0
    
    var actividadFisica = 0.0
    
    var macros = [Double]()
    
    //para ver si la dieta se ha rehecho
    var dietaRehecha = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("EDAD")
        print(edad)
        print("SEXO")
        print(sexo)

        print("PESO")
        print(peso)

        print("ESTATURA")
        print(estatura)

        print("fatLossXweek")
        print(fatLossXweek)


        
        if (sexo == "Hombre"){
             bmr = 88 + 13.4 * peso + 4.8 * estatura - 5.7 * Double(edad)
        } else {
            bmr = 448 + 9.2 * peso + 3.1 * estatura - 4.3 * Double(edad)
        }

        
        print("BMR")
        print(bmr)
        
    }
    
    func calcularTargetCalorias(actividadFisica: Double){
        tdee = bmr * actividadFisica
        print("TDEE")
        print(tdee)
        
    
        if objetivo == "Perder Peso" {
            targetCal = tdee - fatLossXweek * 1100

        } else if objetivo == "Ganar Peso" {
            targetCal = tdee + fatLossXweek * 2.2 * 3000 * 4 / 30

        } else if objetivo == "Mantener Peso" {
            targetCal = tdee 
            
        }
        print("TARGET CALORIAS:")
        print(targetCal)
        
        
        
        
        
        
        var grProteina = 0.0
        var grGrasa = 0.0
        var grGrasaRec = 0.0
        var grCarbohidrato = 0.0
        
        if objetivo == "Perder Peso" {
            grProteina = 2.0 * peso
            grGrasa = 0.2 * targetCal / 9
            grGrasaRec = 0.5 * peso
            grCarbohidrato = (targetCal - grProteina * 4 - grGrasa * 9) / 4
        } else if objetivo == "Ganar Peso" {
            grProteina = 1.8 * peso
            grGrasa = 0.25 * targetCal / 9
            grGrasaRec = 0.5 * peso
            grCarbohidrato = (targetCal - grProteina * 4 - grGrasa * 9) / 4
        } else if objetivo == "Mantener Peso" {
            grProteina = 2.0 * peso
            grGrasa = 0.2 * targetCal / 9
            grGrasaRec = 0.5 * peso
            grCarbohidrato = (targetCal - grProteina * 4 - grGrasa * 9) / 4
        }
        
        print("GRASA RECOMENDADA")
        print(grGrasaRec)
        print(grGrasa)
        
        if grGrasaRec > grGrasa {
            grGrasa = grGrasaRec
        }
        
        
        
        macros = [grProteina, grGrasa, grCarbohidrato] //ej 125, 66.7, 225 proteinas-fat-carb
    }
    
    //poner el segue aca
    @IBAction func a1(_ sender: UIButton) {
        actividadFisica = 1.2
        calcularTargetCalorias(actividadFisica: actividadFisica)
        performSegue(withIdentifier: "datos3Segue", sender: self)

    }
    @IBAction func a2(_ sender: UIButton) {
        actividadFisica = 1.375
        calcularTargetCalorias(actividadFisica: actividadFisica)
        performSegue(withIdentifier: "datos3Segue", sender: self)

    }
    @IBAction func a3(_ sender: UIButton) {
        actividadFisica = 1.55
        calcularTargetCalorias(actividadFisica: actividadFisica)
        performSegue(withIdentifier: "datos3Segue", sender: self)

    }
    @IBAction func a4(_ sender: UIButton) {
        actividadFisica = 1.725
        calcularTargetCalorias(actividadFisica: actividadFisica)
        performSegue(withIdentifier: "datos3Segue", sender: self)

    }
    @IBAction func a5(_ sender: UIButton) {
        actividadFisica = 1.9
        calcularTargetCalorias(actividadFisica: actividadFisica)
        performSegue(withIdentifier: "datos3Segue", sender: self)

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "datos3Segue") {
            
            var vc = segue.destination as! datos3ViewController
            vc.calorias = targetCal
            vc.objetivo = objetivo
            vc.peso = peso
            vc.macros = macros
            vc.sem = sem
            vc.pMeta = pMeta
            vc.altura = estatura
            vc.sexo = sexo
            vc.dietaRehecha = self.dietaRehecha
        }
    }
    




}
