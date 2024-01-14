//
//  ExtVİewController.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 7.01.2024.
//

import UIKit

extension UIViewController{
    func gradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations=[0,1]
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.white.cgColor]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
}
