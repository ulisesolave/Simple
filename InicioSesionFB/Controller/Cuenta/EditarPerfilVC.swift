//
//  EditarPerfilVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 21/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
import FBSDKLoginKit


class EditarPerfilVC: UIViewController{

    var fotoPerfil: UIImage!
    var nombreUsuario = ""
    var correoUsuario = ""
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var fotoPerfilView: UIImageView!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var correo: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        fotoPerfilView.layer.cornerRadius = fotoPerfilView.frame.size.width/2
        fotoPerfilView.clipsToBounds = true
        
        
        if fotoPerfil == nil {
            fotoPerfilView.image = UIImage(named: "hombre-1.png")
        } else{
            fotoPerfilView.image = fotoPerfil
        }
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        print("vda editarperfilvc")


    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nombre.resignFirstResponder()
        correo.resignFirstResponder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("vwa editarperfilvc")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true

        let realm = try! Realm()
        
        let id = realm.objects(Sesion.self).first?.userID
        let persona = realm.objects(Persona.self).filter("userID == %@", id).first
        
        let n = persona?.nombre
        let fotoP = persona?.foto
        let c = persona?.correo
        
        nombre.text = n
        correo.text = c
        
        
        if fotoP == nil {
            fotoPerfilView.image = UIImage(named: "hombre-1.png")
        } else{
            fotoPerfilView.image = UIImage(data: fotoP as! Data)
        }
        
    }
    
    
    @IBAction func volverPressed(_ sender: UIButton) {
       
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func seleccionarFotoPressed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func guardarPressed(_ sender: UIButton) {
        let realm = try! Realm()

        
        let id = realm.objects(Sesion.self).first?.userID
        let persona = realm.objects(Persona.self).filter("userID == %@", id).first
        
        
//        let userID = Auth.auth().currentUser!.uid
        //lo mandare antes el primero creo
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
        // Data in memory
        let data = fotoPerfilView.image!.pngData()
//        // Create a reference to the file you want to upload
//        var ref = storageRef.child(userID)
//        ref = ref.child("fotoPerfil.png")
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = ref.putData(data!, metadata: nil) { (metadata, error) in
//            guard let metadata = metadata else {
//                // Uh-oh, an error occurred!
//                print("ERROR1")
//                return
//            }
//            // Metadata contains file metadata such as size, content-type.
//            let size = metadata.size
//            // You can also access to download URL after upload.
//            ref.downloadURL { (url, error) in
//                guard let downloadURL = url else {
//                    print("ERROR2")
//                    // Uh-oh, an error occurred!
//                    return
//                }
//            }
//
//        }
        
        if nombre.text != nil {
            do {
                try realm.write {
                    persona?.nombre = nombre.text!
//                    persona?.foto = data as! NSData
                }
            } catch {
                print("ERROR REALM")
                print(error)
            }
        }
        
        if correo.text != nil {
            do {
                try realm.write {
                      persona?.correo = correo.text!
//                    persona?.foto = data as! NSData
                }
            } catch {
                print("ERROR REALM")
                print(error)
            }
        }
       
        
        navigationController?.popViewController(animated: true)
       // dismiss(animated: true, completion: nil)

    }
    
    @IBAction func cerrarSesion(_ sender: UIButton) {
        print("BOTON CERRAR SESION")
        let sesionFB = FBSDKAccessToken.current()
        
        if sesionFB != nil {
            print("ESTA LOGUEADO EN FB Y SALDRA")
            
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        } else {
            print("NO ESTA LOGUEADO EN FB Y SALDRA")
            
        }
        
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logoutSegue", sender: self
            )
            print("VOLVI A PANTALLA INICIAL")
        } catch {
            print("ERROR EN SALIR LOGOUT DE FIREBASE")
        }
        
    }
    
}


extension EditarPerfilVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            fotoPerfilView.image = image
        }
        
        let realm = try! Realm()

        let id = realm.objects(Sesion.self).first?.userID
        let persona = realm.objects(Persona.self).filter("userID == %@", id).first
        
        let data = fotoPerfilView.image!.pngData()

        do {
            try realm.write {
                persona?.foto = data as! NSData
            }
        } catch {
            print("ERROR REALM")
            print(error)
        }
        dismiss(animated: false, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
