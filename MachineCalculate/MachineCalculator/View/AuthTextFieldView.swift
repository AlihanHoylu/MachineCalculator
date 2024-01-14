//
//  AuthTextFieldView.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 11.01.2024.
//

import Foundation
import UIKit

class AuthTextFieldView:UITextField{
    init(placeHolder:String){
        super.init(frame: .zero)
        backgroundColor = .white
        borderStyle = .none
        placeholder = placeHolder
        self.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
