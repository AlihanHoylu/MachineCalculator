//
//  AdminInfoRequestTableViewCell.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 13.01.2024.
//

import Foundation
import UIKit

class AdminInfoRequestTableViewCell:UITableViewCell{
    //MARK: - Properties
    static let reuseableCellId = "admincell"
    
    
    
    
    
    
    
    //MARK: - LifeCycles
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Helpers
extension AdminInfoRequestTableViewCell{
    public func configure(){
        
    }
    private func layout(){
        
    }
}
