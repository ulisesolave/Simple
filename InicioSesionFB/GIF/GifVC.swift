//
//  GifVC.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 18/08/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import UIKit


class GifVC: UIView{

    @IBOutlet weak var gifView: UIImageView!
  
    static let instance = GifVC()
    
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: UIScreen.main.bounds)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
        return transparentView
    }()
    
    lazy var gifImage: UIImageView = {
        let gifImage = UIImageView(frame: CGRect(x:0, y:0, width:150, height:150))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.loadGif(name: "gifPrueba")
        return gifImage
}()


    
    func showLoader(){
        self.transparentView.addSubview(gifImage)
        self.addSubview(transparentView)
        self.transparentView.bringSubviewToFront(self.gifImage)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
    }

    func hideLoader(){
        self.transparentView.removeFromSuperview()
    }
    
    
    
    
}
