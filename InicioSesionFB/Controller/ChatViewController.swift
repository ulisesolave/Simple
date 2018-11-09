//
//  ChatViewController.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 22/06/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var nombreUsuario = ""
    var correoUsuario = ""
    var urlFotoUsuario = NSURL()
    
    
    var messageArray : [Mensaje] = [Mensaje]()
    

    
    @IBAction func sendPressed(_ sender: Any) {
        
        messageTextField.endEditing(true)
        
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        var chat = ""
        //nombre de chat con usuarios cambiar a correos'
        chat += nombreUsuario + "_Ulises"
        
        let messagesDB = Database.database().reference().child(chat)
  //      let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextField.text]
        let messageDictionary = ["Sender": nombreUsuario, "MessageBody": messageTextField.text] as [String : Any]

        
        messagesDB.childByAutoId().setValue(messageDictionary){
        (error, reference) in
            if (error != nil)  {
                print(error)
            } else {
                print("MENSAJE GUARDADO")
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
            
            
        }
        
    }
    
    func retrieveMessages(){
        var chat = ""
        //nombre de chat con usuarios cambiar a correos'
        chat += nombreUsuario + "_Ulises"
        print("JALA CHAT DE")
        print(chat)
        let messageDB = Database.database().reference().child(chat)
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!

            let mensaje = Mensaje()
            mensaje.messageBody = text
            mensaje.sender = sender
            
            self.messageArray.append(mensaje)
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextField.delegate = self
        
       //tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        
        
        messageTableView.register(UINib(nibName: "MensajesTableViewCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        retrieveMessages()
        
        messageTableView.separatorStyle = .none
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! MensajesTableViewCell
        
        cell.mensajeChat.text = messageArray[indexPath.row].messageBody
        cell.nombreChat.text = messageArray[indexPath.row].sender
        
//        if cell.nombreChat.text == Auth.auth().currentUser?.email as String! {
//            cell.fondoChat.backgroundColor = UIColor.flatLime()
//        } else {
//            cell.fondoChat.backgroundColor = UIColor.flatWhite()
//        }
        if cell.nombreChat.text == "Ulises" {
            cell.fondoChat.backgroundColor = UIColor.flatLime()
            cell.imagenChat.image = UIImage(named: "icono_persona")
            cell.imagenChat.layer.cornerRadius = cell.imagenChat.frame.size.width/2
            cell.imagenChat.clipsToBounds = true
        } else {
            cell.fondoChat.backgroundColor = UIColor.flatWhite()
            let url = URL(string: urlFotoUsuario.absoluteString!)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.imagenChat.image = UIImage(data: data!)
                    cell.imagenChat.layer.cornerRadius = cell.imagenChat.frame.size.width/2
                    cell.imagenChat.clipsToBounds = true
                }
            }
        }
        
        
        
        return cell
            
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func configureTableView(){
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
        print("ENTRA A CONFIGURE TABLEVIEW")
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.3){
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3){
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }

    
    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
