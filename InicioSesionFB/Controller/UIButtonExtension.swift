//
//  UIButtonExtension.swift
//  InicioSesionFB
//
//  Created by Ulises Olave mendoza on 16/07/18.
//  Copyright © 2018 Ulises Olave mendoza. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate(){
    let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.97
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    
        
    }
}
