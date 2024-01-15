//
//  SettingsAccountTableViewCell.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 12.01.2024.
//

import UIKit

class SettingsAccountTableViewCell: UITableViewCell {
    //MARK: - Properties

    static let reuseableCellId = "accountcell"

    var email:String = ""
    var rol:String = ""
    var service:String = ""
    
    lazy var labelEmail:UILabel = {
        let label = UILabel()
        label.text = email
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    lazy var labelRole:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    lazy var labelService:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    lazy var imageRol:UIImageView = {
        let uIImageView = UIImageView()
        return uIImageView
    }()
    
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
extension SettingsAccountTableViewCell{
    public func configure(email:String,rol:String,service:String){
        self.service = service
        self.rol = rol
        self.email = email
        imageRol.translatesAutoresizingMaskIntoConstraints = false
        switch self.rol{
        case "admin":
            imageRol.image = UIImage(systemName: "rectangle.stack.badge.person.crop")
        case "panel":
            imageRol.image = UIImage(systemName: "rectangle")
        default:
            imageRol.image = UIImage(systemName: "rectangle.stack.badge.person.crop")
        }
        
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.text = self.email
        
        labelService.translatesAutoresizingMaskIntoConstraints = false
        switch self.rol{
        case "admin":
            labelService.text = service
        case "panel":
            labelService.text = service
        default:
            labelService.text = self.rol
        }
        
        labelRole.translatesAutoresizingMaskIntoConstraints = false
        switch self.rol{
        case "admin":
            labelRole.text = "Yönetici"
        case "panel":
            labelRole.text = "Panel"
        default:
            labelRole.text = self.service
        }
    }
    
    private func layout(){
        addSubview(imageRol)
        addSubview(labelEmail)
        addSubview(labelRole)
        addSubview(labelService)
        NSLayoutConstraint.activate([
            //imageRol
            imageRol.leftAnchor.constraint(equalTo: leftAnchor,constant: 5),
            imageRol.widthAnchor.constraint(equalToConstant: 75),
            imageRol.heightAnchor.constraint(equalToConstant: 75),
            imageRol.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 3),
            //labelEmail
            labelEmail.leftAnchor.constraint(equalTo: leftAnchor, constant: 85),
            labelEmail.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            labelEmail.widthAnchor.constraint(equalToConstant: 15),
            labelEmail.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            //labelService
            labelService.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 2),
            labelService.leftAnchor.constraint(equalTo: leftAnchor, constant: 85),
            labelService.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            labelService.widthAnchor.constraint(equalToConstant: 15),
            //labelRole
            labelRole.topAnchor.constraint(equalTo: labelService.bottomAnchor, constant: 2),
            labelRole.leftAnchor.constraint(equalTo: leftAnchor, constant: 85),
            labelRole.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            labelRole.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
}
