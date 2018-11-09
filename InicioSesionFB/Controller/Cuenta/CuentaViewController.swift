//
//  CuentaViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 20/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift


class CuentaViewController: UIViewController {
    var window: UIWindow?

    var nombreUsuario = ""
    var correoUsuario = ""
    var foto = UIImage()
    
    var dieta: Results<Dieta>?
    var peso: Results<Peso>?

    @IBOutlet weak var pInicial: UILabel!
    @IBOutlet weak var pActual: UILabel!
    @IBOutlet weak var pMeta: UILabel!
    @IBOutlet weak var fInicio: UILabel!
    @IBOutlet weak var fFin: UILabel!
    @IBOutlet weak var calTarget: UILabel!
    
    
    @IBOutlet weak var nombreCuenta: UILabel!
    @IBOutlet weak var fotoPerfil: UIImageView!
    
    
    var rehacerDieta = false
    var contRehacerDieta = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ENTRA VDL CUENTAVC")
       
        fotoPerfil.layer.cornerRadius = fotoPerfil.frame.size.width/2
        fotoPerfil.clipsToBounds = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false

    }
    
    override func viewDidAppear(_ animated: Bool) {

        
        let realm = try! Realm()
        
        let id = realm.objects(Sesion.self).first?.userID
        let persona = realm.objects(Persona.self).filter("userID == %@", id).first
        let nombre = persona?.nombre
        let fotoP = persona?.foto
        nombreCuenta.text = nombre
        
        
        if fotoP == nil {
            fotoPerfil.image = UIImage(named: "hombre-1.png")
        } else{
            fotoPerfil.image = UIImage(data: fotoP as! Data)
        }
        
        
        dieta = realm.objects(Dieta.self).filter("ANY parentPersona.userID == %@", id!)
        peso = persona!.pesos.sorted(byKeyPath: "fechaRegistro", ascending: false)

        
        
        pInicial.text = String(dieta!.first!.pesoInicial)
        if peso?.first?.pesoKg != nil {
        pActual.text = String(peso!.first!.pesoKg)
        } else {
        pActual.text = "NO HAY CTM"
        }
        pMeta.text = String(dieta!.first!.pesoMeta)
        calTarget.text = String(Int(round(dieta!.first!.calTarget)))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: dieta!.first!.fechaRegistro!)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        
        fInicio.text = myStringafd
      
        let myString2 = formatter.string(from: dieta!.first!.fechaFin!)
        let yourDate2 = formatter.date(from: myString2)
        formatter.dateFormat = "dd-MMM-yyyy"
        let myStringafd2 = formatter.string(from: yourDate2!)
        
        fFin.text = myStringafd2
        
        
        contRehacerDieta = (dieta!.first?.contRehacerDieta)!
        
        
    }
    
    @IBAction func editarPerfil(_ sender: UIButton) {
        performSegue(withIdentifier: "editarPerfilSegue", sender: self)


    }
    
    
    @IBAction func rehacerDietaPressed(_ sender: UIButton) {
        

        if contRehacerDieta < 1 {
        let alert = UIAlertController(title: "Rehacer Dieta", message: "¿Estás seguro que quieres volver a hacer tu dieta? Solo podrás hacerlo una vez al mes.", preferredStyle: .actionSheet)
    
        alert.addAction(UIAlertAction(title: "Rehacer", style: .destructive , handler:{ (UIAlertAction)in
            print("User click REHACER button")
            self.performSegue(withIdentifier: "rehacerSegue", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler:{ (UIAlertAction)in
            print("User click CANCELAR button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
            
        } else {
            
       print("AVISO VERSION PAGA")
        }
    }
    

    
    @IBAction func share(_ sender: UIButton) {
        
        let direccion = "Descarga P ctm: https://itunes.com/pe/app//cabify/id476087442?mt=8"
        let activityController = UIActivityViewController(activityItems: [direccion], applicationActivities: nil)
        activityController.completionWithItemsHandler = { (nil, completed, _, error)
            in
            if completed {
                print("COMPARTIR COMPLETO")
            } else {
                print("CANCELO COMPARTIR")
            }
        }
        present(activityController, animated: true){
            
        }

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "rehacerSegue") {
        let vC = segue.destination as! ObjetivoVC
        vC.dietaRehecha = true
            self.tabBarController?.tabBar.isHidden = true

        }
    }
        
    

}
