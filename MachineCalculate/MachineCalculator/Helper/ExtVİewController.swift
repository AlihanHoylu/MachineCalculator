//
//  ExtVİewController.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 7.01.2024.
//

import UIKit
import JGProgressHUD

extension UIViewController{
    func gradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations=[0,1]
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.white.cgColor]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
    
    func hud(type:String,subtitle:String){
        let hud = JGProgressHUD(style: .dark)
        if type == "sucses"{
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.detailTextLabel.text = subtitle
            hud.interactionType = .blockAllTouches
            hud.textLabel.text = "Başarılı"
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3.0)
        }
        if type == "error"{
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.detailTextLabel.text = subtitle
            hud.interactionType = .blockAllTouches
            hud.textLabel.text = "Hata"
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 3.0)
        }
    }
}
