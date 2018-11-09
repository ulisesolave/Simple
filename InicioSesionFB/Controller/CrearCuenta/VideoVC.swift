//
//  VideoVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 6/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import RealmSwift

class VideoVC: UIViewController {

    
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

//        do {
//            try FileManager.default.removeItem(at:Realm.Configuration.defaultConfiguration.fileURL!)
//            
//        } catch {
//            print("ERROR BORRAR BD REALM")
//            print(error)
//        }
        
        videoFondo()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "loginSegue", sender: self)
 }
    
    @IBAction func registrarsePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "objetivoSegue", sender: self)

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
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(VideoVC.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
    }
    
    @objc func videoDidPlayToEnd(_ notificacion: Notification){
        let player: AVPlayerItem = notificacion.object as! AVPlayerItem
        player.seek(to: CMTime.zero)
    }

}
