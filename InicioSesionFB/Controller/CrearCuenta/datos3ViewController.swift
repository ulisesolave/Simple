//
//  datos3ViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 13/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit

class datos3ViewController: UIViewController {
    var calorias = 0.0
    var objetivo = ""
    var cantidadMeals = 0
    var peso = 0.0
    var macros = [Double]()
    var pMeta = 0.0
    var sem = 0
    var altura = 0.0
    var sexo = ""

    //para ver si la dieta se ha rehecho
    var dietaRehecha = false

    
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
    
    var cuentaP = 8
    var cuentaF = 8
    var cuentaC = 12
    var cuentaL = 3
    var cuentaFr = 15
    
    var items = [0,1,2,3,4,5,6,7,
                 50,51,52,53,54,55,56,57,58,59,60,61,
                 100,101,102,103,104,105,106,107,
                 150,151,152,
                 200,201,202,203,204,205,206,207,208,209,210,211,212,213,214]

    
    @IBOutlet weak var boton2: UIButton!
    @IBOutlet weak var boton3: UIButton!
    @IBOutlet weak var boton4: UIButton!
    @IBOutlet weak var boton5: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EN VC DATOS3 EL VALOR DE CALORIAS ES")
        print(calorias)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Continuar", style: .done, target: self, action: #selector(continuar))

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
        
        p1.layer.cornerRadius = 7;
        p1.layer.masksToBounds = true;
        p1.layer.borderWidth = 2;
        p1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        p2.layer.cornerRadius = 7;
        p2.layer.masksToBounds = true;
        p2.layer.borderWidth = 2;
        p2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        p3.layer.cornerRadius = 7;
        p3.layer.masksToBounds = true;
        p3.layer.borderWidth = 2;
        p3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        p4.layer.cornerRadius = 7;
        p4.layer.masksToBounds = true;
        p4.layer.borderWidth = 2;
        p4.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        p5.layer.cornerRadius = 7;
        p5.layer.masksToBounds = true;
        p5.layer.borderWidth = 2;
        p5.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        p6.layer.cornerRadius = 7;
        p6.layer.masksToBounds = true;
        p6.layer.borderWidth = 2;
        p6.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        p7.layer.cornerRadius = 7;
        p7.layer.masksToBounds = true;
        p7.layer.borderWidth = 2;
        p7.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        p8.layer.cornerRadius = 7;
        p8.layer.masksToBounds = true;
        p8.layer.borderWidth = 2;
        p8.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        

        c1.layer.cornerRadius = 7;
        c1.layer.masksToBounds = true;
        c1.layer.borderWidth = 2;
        c1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c2.layer.cornerRadius = 7;
        c2.layer.masksToBounds = true;
        c2.layer.borderWidth = 2;
        c2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c3.layer.cornerRadius = 7;
        c3.layer.masksToBounds = true;
        c3.layer.borderWidth = 2;
        c3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c4.layer.cornerRadius = 7;
        c4.layer.masksToBounds = true;
        c4.layer.borderWidth = 2;
        c4.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c5.layer.cornerRadius = 7;
        c5.layer.masksToBounds = true;
        c5.layer.borderWidth = 2;
        c5.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c6.layer.cornerRadius = 7;
        c6.layer.masksToBounds = true;
        c6.layer.borderWidth = 2;
        c6.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c7.layer.cornerRadius = 7;
        c7.layer.masksToBounds = true;
        c7.layer.borderWidth = 2;
        c7.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c8.layer.cornerRadius = 7;
        c8.layer.masksToBounds = true;
        c8.layer.borderWidth = 2;
        c8.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c9.layer.cornerRadius = 7;
        c9.layer.masksToBounds = true;
        c9.layer.borderWidth = 2;
        c9.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c10.layer.cornerRadius = 7;
        c10.layer.masksToBounds = true;
        c10.layer.borderWidth = 2;
        c10.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c11.layer.cornerRadius = 7;
        c11.layer.masksToBounds = true;
        c11.layer.borderWidth = 2;
        c11.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        c12.layer.cornerRadius = 7;
        c12.layer.masksToBounds = true;
        c12.layer.borderWidth = 2;
        c12.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        

        f1.layer.cornerRadius = 7;
        f1.layer.masksToBounds = true;
        f1.layer.borderWidth = 2;
        f1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        f2.layer.cornerRadius = 7;
        f2.layer.masksToBounds = true;
        f2.layer.borderWidth = 2;
        f2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        f3.layer.cornerRadius = 7;
        f3.layer.masksToBounds = true;
        f3.layer.borderWidth = 2;
        f3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        f4.layer.cornerRadius = 7;
        f4.layer.masksToBounds = true;
        f4.layer.borderWidth = 2;
        f4.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        f5.layer.cornerRadius = 7;
        f5.layer.masksToBounds = true;
        f5.layer.borderWidth = 2;
        f5.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        f6.layer.cornerRadius = 7;
        f6.layer.masksToBounds = true;
        f6.layer.borderWidth = 2;
        f6.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        f7.layer.cornerRadius = 7;
        f7.layer.masksToBounds = true;
        f7.layer.borderWidth = 2;
        f7.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        f8.layer.cornerRadius = 7;
        f8.layer.masksToBounds = true;
        f8.layer.borderWidth = 2;
        f8.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        l1.layer.cornerRadius = 7;
        l1.layer.masksToBounds = true;
        l1.layer.borderWidth = 2;
        l1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        l2.layer.cornerRadius = 7;
        l2.layer.masksToBounds = true;
        l2.layer.borderWidth = 2;
        l2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        l3.layer.cornerRadius = 7;
        l3.layer.masksToBounds = true;
        l3.layer.borderWidth = 2;
        l3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr1.layer.cornerRadius = 7;
        fr1.layer.masksToBounds = true;
        fr1.layer.borderWidth = 2;
        fr1.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr2.layer.cornerRadius = 7;
        fr2.layer.masksToBounds = true;
        fr2.layer.borderWidth = 2;
        fr2.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr3.layer.cornerRadius = 7;
        fr3.layer.masksToBounds = true;
        fr3.layer.borderWidth = 2;
        fr3.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr4.layer.cornerRadius = 7;
        fr4.layer.masksToBounds = true;
        fr4.layer.borderWidth = 2;
        fr4.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr5.layer.cornerRadius = 7;
        fr5.layer.masksToBounds = true;
        fr5.layer.borderWidth = 2;
        fr5.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr6.layer.cornerRadius = 7;
        fr6.layer.masksToBounds = true;
        fr6.layer.borderWidth = 2;
        fr6.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr7.layer.cornerRadius = 7;
        fr7.layer.masksToBounds = true;
        fr7.layer.borderWidth = 2;
        fr7.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr8.layer.cornerRadius = 7;
        fr8.layer.masksToBounds = true;
        fr8.layer.borderWidth = 2;
        fr8.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr9.layer.cornerRadius = 7;
        fr9.layer.masksToBounds = true;
        fr9.layer.borderWidth = 2;
        fr9.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr10.layer.cornerRadius = 7;
        fr10.layer.masksToBounds = true;
        fr10.layer.borderWidth = 2;
        fr10.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr11.layer.cornerRadius = 7;
        fr11.layer.masksToBounds = true;
        fr11.layer.borderWidth = 2;
        fr11.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr12.layer.cornerRadius = 7;
        fr12.layer.masksToBounds = true;
        fr12.layer.borderWidth = 2;
        fr12.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr13.layer.cornerRadius = 7;
        fr13.layer.masksToBounds = true;
        fr13.layer.borderWidth = 2;
        fr13.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr14.layer.cornerRadius = 7;
        fr14.layer.masksToBounds = true;
        fr14.layer.borderWidth = 2;
        fr14.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
        fr15.layer.cornerRadius = 7;
        fr15.layer.masksToBounds = true;
        fr15.layer.borderWidth = 2;
        fr15.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
        
    }


    @IBAction func dosPressed(_ sender: UIButton) {
        sender.pulsate()
        cantidadMeals = 2
        if boton2.isSelected {
            boton2.isSelected = false
        } else {
            boton2.isSelected = true
            boton2.setImage(UIImage(named: "2Si.png"), for: .normal)
            //desseleccionar demas
            boton3.isSelected = false
            boton4.isSelected = false
            boton5.isSelected = false
            boton3.setImage(UIImage(named: "3.png"), for: .normal)
            boton4.setImage(UIImage(named: "4.png"), for: .normal)
            boton5.setImage(UIImage(named: "5.png"), for: .normal)
        }
    }
    @IBAction func tresPressed(_ sender: UIButton) {
        sender.pulsate()
        cantidadMeals = 3
        if boton3.isSelected {
            boton3.isSelected = false
        } else {
            boton3.isSelected = true
            boton3.setImage(UIImage(named: "3Si.png"), for: .normal)
            //desseleccionar demas
            boton2.isSelected = false
            boton4.isSelected = false
            boton5.isSelected = false
            boton2.setImage(UIImage(named: "2.png"), for: .normal)
            boton4.setImage(UIImage(named: "4.png"), for: .normal)
            boton5.setImage(UIImage(named: "5.png"), for: .normal)
        }
    }
    @IBAction func cuatroPressed(_ sender: UIButton) {
        sender.pulsate()
        cantidadMeals = 4
        if boton4.isSelected {
            boton4.isSelected = false
        } else {
            boton4.isSelected = true
            boton4.setImage(UIImage(named: "4Si.png"), for: .normal)
            //desseleccionar demas
            boton3.isSelected = false
            boton2.isSelected = false
            boton5.isSelected = false
            boton3.setImage(UIImage(named: "3.png"), for: .normal)
            boton2.setImage(UIImage(named: "2.png"), for: .normal)
            boton5.setImage(UIImage(named: "5.png"), for: .normal)
        }
    }
    @IBAction func cincoPressed(_ sender: UIButton) {
        sender.pulsate()
        cantidadMeals = 5
        if boton5.isSelected {
            boton5.isSelected = false
        } else {
            boton5.isSelected = true
            boton5.setImage(UIImage(named: "5Si.png"), for: .normal)
            //desseleccionar demas
            boton3.isSelected = false
            boton4.isSelected = false
            boton2.isSelected = false
            boton3.setImage(UIImage(named: "3.png"), for: .normal)
            boton4.setImage(UIImage(named: "4.png"), for: .normal)
            boton2.setImage(UIImage(named: "2.png"), for: .normal)
        }
    }
    
    
    func seleccion(boton: UIButton, id: Int){
        
        if boton.isSelected {
            boton.layer.borderWidth = 2;
            boton.layer.cornerRadius = 7;
            boton.layer.masksToBounds = true;
            boton.layer.borderColor = UIColor(red:0/255, green:249/255, blue:0/255, alpha: 1).cgColor
            boton.isSelected = false
            
            items.append(id)
        } else {
            boton.layer.borderWidth = 0;
            boton.isSelected = true
            items = items.filter() { $0 != id }
        }
        
    }
    
    func cuentaProteinas(boton: UIButton){
        if boton.isSelected {
            cuentaP = cuentaP - 1
        } else {
            cuentaP = cuentaP + 1
        }
        print("CANTIDAD DE PROTEINAS SELECCIONADAS")
        print(cuentaP)

    }
    
    func cuentaFat(boton: UIButton){
        if boton.isSelected {
            cuentaF = cuentaF - 1
        } else {
            cuentaF = cuentaF + 1
        }
        print("CANTIDAD DE FAT SELECCIONADAS")
        print(cuentaF)

    }
    
    func cuentaCarb(boton: UIButton){
        if boton.isSelected {
            cuentaC = cuentaC - 1
        } else {
            cuentaC = cuentaC + 1
        }
        print("CANTIDAD DE CARB SELECCIONADAS")
        print(cuentaC)
    }
    
    func cuentaLact(boton: UIButton){
        if boton.isSelected {
            cuentaL = cuentaL - 1
        } else {
            cuentaL = cuentaL + 1
        }
        print("CANTIDAD DE LACT SELECCIONADAS")
        print(cuentaL)
    }
    
    func cuentaFrutas(boton: UIButton){
        if boton.isSelected {
            cuentaFr = cuentaFr - 1
        } else {
            cuentaFr = cuentaFr + 1
        }
        print("CANTIDAD DE FRUTAS SELECCIONADAS")
        print(cuentaFr)
    }
    
    
    @IBAction func p1(_ sender: Any) {
        seleccion(boton: p1, id: 0)
        cuentaProteinas(boton: p1)
    }
    @IBAction func p2(_ sender: Any) {
        seleccion(boton: p2, id: 1)
        cuentaProteinas(boton: p2)
 }
    @IBAction func p3(_ sender: Any) {
        seleccion(boton: p3, id: 2)
        cuentaProteinas(boton: p3)
}
    @IBAction func p4(_ sender: Any) {
        seleccion(boton: p4, id: 3)
        cuentaProteinas(boton: p4)
}
    @IBAction func p5(_ sender: Any) {
        seleccion(boton: p5, id: 4)
        cuentaProteinas(boton: p5)
}
    @IBAction func p6(_ sender: Any) {
        seleccion(boton: p6, id: 5)
        cuentaProteinas(boton: p6)
}
    @IBAction func p7(_ sender: Any) {
        seleccion(boton: p7, id: 6)
        cuentaProteinas(boton: p7)
}
    @IBAction func p8(_ sender: Any) {
        seleccion(boton: p8, id: 7)
        cuentaProteinas(boton: p8)
 }

    
    @IBAction func c1(_ sender: Any) {
        seleccion(boton: c1, id: 50)
        cuentaCarb(boton: c1)
    }
    @IBAction func c2(_ sender: Any) {
        seleccion(boton: c2, id: 51)
        cuentaCarb(boton: c2)
    }
    @IBAction func c3(_ sender: Any) {
        seleccion(boton: c3, id: 52)
        cuentaCarb(boton: c3)
    }
    @IBAction func c4(_ sender: Any) {
        seleccion(boton: c4, id: 53)
        cuentaCarb(boton: c4)
    }
    @IBAction func c5(_ sender: Any) {
        seleccion(boton: c5, id: 54)
        cuentaCarb(boton: c5)
    }
    @IBAction func c6(_ sender: Any) {
        seleccion(boton: c6, id: 55)
        cuentaCarb(boton: c6)
    }
    @IBAction func c7(_ sender: Any) {
        seleccion(boton: c7, id: 56)
        cuentaCarb(boton: c7)
    }
    @IBAction func c8(_ sender: Any) {
        seleccion(boton: c8, id: 57)
        cuentaCarb(boton: c8)
    }
    @IBAction func c9(_ sender: Any) {
        seleccion(boton: c9, id: 58)
        cuentaCarb(boton: c9)
    }
    @IBAction func c10(_ sender: Any) {
        seleccion(boton: c10, id: 59)
        cuentaCarb(boton: c10)
    }
    @IBAction func c11(_ sender: Any) {
        seleccion(boton: c11, id: 60)
        cuentaCarb(boton: c11)
    }
    @IBAction func c12(_ sender: Any) {
        seleccion(boton: c12, id: 61)
        cuentaCarb(boton: c12)
    }
 
    @IBAction func f1(_ sender: Any) {
        seleccion(boton: f1, id: 100)
        cuentaFat(boton: f1)
    }
    @IBAction func f2(_ sender: Any) {
        seleccion(boton: f2, id: 101)
        cuentaFat(boton: f2)
    }
    @IBAction func f3(_ sender: Any) {
        seleccion(boton: f3, id: 102)
        cuentaFat(boton: f3)
    }
    @IBAction func f4(_ sender: Any) {
        seleccion(boton: f4, id: 103)
        cuentaFat(boton: f4)
    }
    @IBAction func f5(_ sender: Any) {
        seleccion(boton: f5, id: 104)
        cuentaFat(boton: f5)
    }
    @IBAction func f6(_ sender: Any) {
        seleccion(boton: f6, id: 105)
        cuentaFat(boton: f6)
    }
    @IBAction func f7(_ sender: Any) {
        seleccion(boton: f7, id: 106)
        cuentaFat(boton: f7)
    }
    @IBAction func f8(_ sender: Any) {
        seleccion(boton: f8, id: 107)
        cuentaFat(boton: f8)
    }

    
    @IBAction func l1(_ sender: Any) {
        seleccion(boton: l1, id: 150)
        cuentaLact(boton: l1)
    }
    @IBAction func l2(_ sender: Any) {
        seleccion(boton: l2, id: 151)
        cuentaLact(boton: l2)
    }
    @IBAction func l3(_ sender: Any) {
        seleccion(boton: l3, id: 152)
        cuentaLact(boton: l3)
    }

    @IBAction func fr1(_ sender: Any) {
        seleccion(boton: fr1, id: 200)
        cuentaFrutas(boton: fr1)
    }
    @IBAction func fr2(_ sender: Any) {
        seleccion(boton: fr2, id: 201)
        cuentaFrutas(boton: fr2)
    }
    @IBAction func fr3(_ sender: Any) {
        seleccion(boton: fr3, id: 202)
        cuentaFrutas(boton: fr3)
    }
    @IBAction func fr4(_ sender: Any) {
        seleccion(boton: fr4, id: 203)
        cuentaFrutas(boton: fr4)
    }
    @IBAction func fr5(_ sender: Any) {
        seleccion(boton: fr5, id: 204)
        cuentaFrutas(boton: fr5)
    }
    @IBAction func fr6(_ sender: Any) {
        seleccion(boton: fr6, id: 205)
        cuentaFrutas(boton: fr6)
    }
    @IBAction func fr7(_ sender: Any) {
        seleccion(boton: fr7, id: 206)
        cuentaFrutas(boton: fr7)
    }
    @IBAction func fr8(_ sender: Any) {
        seleccion(boton: fr8, id: 207)
        cuentaFrutas(boton: fr8)
    }
    @IBAction func fr9(_ sender: Any) {
        seleccion(boton: fr9, id: 208)
        cuentaFrutas(boton: fr9)
    }
    @IBAction func fr10(_ sender: Any) {
        seleccion(boton: fr10, id: 209)
        cuentaFrutas(boton: fr10)
    }
    @IBAction func fr11(_ sender: Any) {
        seleccion(boton: fr11, id: 210)
        cuentaFrutas(boton: fr11)
    }
    @IBAction func fr12(_ sender: Any) {
        seleccion(boton: fr12, id: 211)
        cuentaFrutas(boton: fr12)
    }
    @IBAction func fr13(_ sender: Any) {
        seleccion(boton: fr13, id: 212)
        cuentaFrutas(boton: fr13)
    }
    @IBAction func fr14(_ sender: Any) {
        seleccion(boton: fr14, id: 213)
        cuentaFrutas(boton: fr14)
    }
    @IBAction func fr15(_ sender: Any) {
        seleccion(boton: fr15, id: 214)
        cuentaFrutas(boton: fr15)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "resumenSegue") {
            
            var vc = segue.destination as! ResumenVC
            vc.calorias = calorias
            vc.items = items
            vc.cantidadMeals = cantidadMeals
            vc.objetivo = objetivo
            vc.peso = peso
            vc.macros = macros
            vc.sem = sem

            vc.pesoMeta = pMeta
            vc.altura = altura
            vc.sexo = sexo
            
            vc.dietaRehecha = self.dietaRehecha
        }
    }

    
    @objc func continuar(){
    print("CANTIDAD DE MEALS")
        print(cantidadMeals)
        
        if cuentaP >= 6 && cuentaF >= 5 && cuentaC >= 8 && cuentaL >= 2 && cuentaFr >= 10 && cantidadMeals > 0 {
            
            performSegue(withIdentifier: "resumenSegue", sender: self)

        } else {
        if cuentaP < 6 {
            viewProteinas.shake()

            let alert = UIAlertController(title: "Selecciona más proteínas", message: "Debes seleccionar por lo menos 6 proteínas para poder continuar.", preferredStyle: UIAlertController.Style.alert)
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
        if cuentaC < 8 {
            viewCarb.shake()

            let alert = UIAlertController(title: "Selecciona más carbohidratos", message: "Debes seleccionar por lo menos 8 carbohidratos para poder continuar.", preferredStyle: UIAlertController.Style.alert)
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
            if cuentaL < 2 {
                viewLact.shake()
                
                let alert = UIAlertController(title: "Selecciona más lácteos", message: "Debes seleccionar por lo menos 2 lácteos para poder continuar.", preferredStyle: UIAlertController.Style.alert)
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
            if cuentaFr < 10 {
                viewLact.shake()
                
                let alert = UIAlertController(title: "Selecciona más Frutas", message: "Debes seleccionar por lo menos 10 frutas para poder continuar.", preferredStyle: UIAlertController.Style.alert)
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
            
            
            if cantidadMeals == 0 {
                boton2.shake()
                boton3.shake()
                boton4.shake()
                boton5.shake()
                
                let alert = UIAlertController(title: "Error cantidad de comidas ", message: "Selecciona la cantidad de comidas.", preferredStyle: UIAlertController.Style.alert)
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

        print("ALIMENTOS SELECCIONADOS")
        print(items)
    }

}


