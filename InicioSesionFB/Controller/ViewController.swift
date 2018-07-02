//
//  ViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 6/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import AVFoundation
import AVKit
import SVProgressHUD
import FacebookLogin
import FacebookCore



class ViewController: UIViewController  {

    @IBOutlet weak var videoView: UIView!
    var nombreFB = ""
    var correoFB = ""
    var urlFoto = NSURL()
    
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //video fondo
        videoFondo()
        
        
        
        
        if FBSDKAccessToken.current() != nil {
            print("YA LOGUEADO EN FB vista viewdidload")
            print("----------************----------")
        
            
        }else{
            print("NO LOGUEADO EN FB viewdid load")
        }
        
   
        
        
        
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.frame = CGRect(x: 15, y: 60, width: 237, height: 35)
        let imagenFB = UIImage(named: "loginFB") as UIImage?
        myLoginButton.setImage(imagenFB, for: .normal)
        myLoginButton.center = view.center;
 
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(apretarCustomFB), for: .touchUpInside)
        // Add the button to the view
        view.addSubview(myLoginButton)
        
    }
    
    @objc func apretarCustomFB() {
        let manager = LoginManager()

        manager.logIn(readPermissions: [.publicProfile], viewController: self) { (result) in
            switch result {
            case .success:
                
                self.fetchProfile()
                
                print("ENTRO FBBBB")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        // ...
                        return
                    }
                    // User is signed in'
                    print("YA LO GUARDO EN FIREBASE")
                }
                
              
          
                
                
            case .failed(let errorCtm):
                print(errorCtm)
            case .cancelled:
                print("User cancelled login.")
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("SALIO DE INICIO DE SESION DE FB")
    }
    
    
    func fetchProfile() {
        dispatchGroup.enter()
        
        print("---INICIA FETCH PROFILE-----")
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) -> Void in
            print(result)

            if error != nil {
                print("---ERROR EN FETCH PROFILE-----")

                print(error as Any)
                return
            }

            if let result = result as? [String: Any] {
                //nombre
                if let datoNombre = result["first_name"] as? String {
                    print("IMPRIME NOMBRE")
                    print(datoNombre)
                    self.nombreFB = datoNombre
                }
                //email
                //BORRAR PRUEBA BRUNO
                if self.nombreFB == "Bruno"{
                    
                }
                //
                if let email = result["email"] as? String {
                    print("IMPRIME EMAIL")
                    print(email)
                    
                    self.correoFB = email
                }
                //foto
                if let picture = result["picture"] as? Dictionary<String, Any> {
                    if let pictureData = picture["data"] as? Dictionary<String, Any> {
                        print("-------------**************--------------")
                        print("EL string DE LA FOTO ES")
                        print(pictureData)
                        if let pictureURL = NSURL(string: (pictureData["url"] as? String)! ) {
                      print("-------------**************--------------")
                            print("EL URL DE LA FOTO ES")
                            print(pictureURL)
                            self.urlFoto = pictureURL
                            self.dispatchGroup.leave()
                        }
                    }
                }
                //TERMINA SACAR DATOS DEL PERFIL
            }
            
        }
      
    }


    
    
    override func viewDidAppear(_ animated: Bool) {
        dispatchGroup.enter()

            let fechaCreacionFirebase = Auth.auth().currentUser?.metadata.creationDate
        dispatchGroup.leave()
        print("FECHA DE CREACION EN FIREBASE VISTAVIEWDIDAPPEAR DEL VIEWCONTROLLER ES")
        print(fechaCreacionFirebase)

        if (FBSDKAccessToken.current() != nil) {
            print("YA LOGUEADO EN FB - vista viewdidapear")
            //este fectch profile es para cuando se inicia y ya esta logueado y no apreto el boton de inicio con fb
          fetchProfile()

            
            dispatchGroup.notify(queue: .main, execute: {
                
                //mandar distintas vistas si usuario existe o no
                if fechaCreacionFirebase != nil {
                    print("YA ESTA REGISTRADO Y SU FECHA DE CREACION ES ")
                    print(fechaCreacionFirebase)
                    
                  self.performSegue(withIdentifier: "yaLogueado", sender: self)
                }else {
                    print("NO ESTA REGISTRADO Y SU FECHA DE CREACION ES ")
                    print(fechaCreacionFirebase)
                    self.performSegue(withIdentifier: "segueFB", sender: self)

                }

                
            })
           
         
        }else{
            print("NO LOGUEADO EN FB view did appear")
        }
        
        print("------termina fucion viewdidappear-----")

    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        
                if segue.identifier == "segueFB" {
                    print("entra al segue seguefb PRIMERA VEZ")
 
                 // se pasa el nombre
                    let PVVC = segue.destination as! PrimeraVezViewController
                    PVVC.nombreUsuario = self.nombreFB
                    PVVC.correoUsuario = self.correoFB
                    PVVC.urlFotoUsuario = self.urlFoto
            
                } else if segue.identifier == "yaLogueado" {
                    print("entra al segue yalogueado")
                    
                    // se pasa el nombre
                    
                    let TBVC = segue.destination as! TabBarViewController
                    TBVC.nombreUsuario = self.nombreFB
                    TBVC.correoUsuario = self.correoFB
                    TBVC.urlFotoUsuario = self.urlFoto
                    
                    
        }
            
        }
       
        

    
    func videoFondo(){
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "videoFondo1", ofType: "mov")!)
        
        let player = AVPlayer(url: path)
        
        let newLayer = AVPlayerLayer(player: player)
        
        newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        player.play()
        //para que repita
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.none

        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
    }
    @objc func videoDidPlayToEnd(_ notificacion: Notification){
        let player: AVPlayerItem = notificacion.object as! AVPlayerItem
        player.seek(to: kCMTimeZero)
        
        
    }
    
    
    
}

