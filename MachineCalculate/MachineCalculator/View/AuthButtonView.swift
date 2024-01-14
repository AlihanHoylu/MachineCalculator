//
//  AuthButtonView.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 11.01.2024.
//

import Foundation
import UIKit

class AuthButtonView:UIButton{
    init(title:String){
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        let stick = UIView()
        stick.backgroundColor = .systemGray
        addSubview(stick)
        stick.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stick.topAnchor.constraint(equalTo: bottomAnchor),
            stick.leftAnchor.constraint(equalTo: leftAnchor),
            stick.rightAnchor.constraint(equalTo: rightAnchor),
            stick.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
