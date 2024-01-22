//
//  ShowAdminViewController.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 17.01.2024.
//

import Foundation
import UIKit

class ShowAdminViewController:UIViewController{
    //MARK: - Properties
    
    lazy var adminImaegeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "rectangle.stack.badge.person.crop")
        imageView.tintColor = .white
        imageView
        return imageView
    }()
    
    
    
    //MARK: - Helpers

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

//MARK: - Helpers
extension ShowAdminViewController{
    
    
    private func style(){
        
        
    }
    private func layout(){
        
        
    }
    
    
}
