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
    
    
    lazy var viewBand:UIView = {
        let viw = UIView()
        viw.addSubview(adminImaegeView)
        viw.backgroundColor = UIColor(named: "gray5")
        adminImaegeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adminImaegeView.widthAnchor.constraint(equalToConstant: 100),
            adminImaegeView.heightAnchor.constraint(equalToConstant: 100),
            adminImaegeView.centerXAnchor.constraint(equalTo: viw.centerXAnchor),
            adminImaegeView.centerYAnchor.constraint(equalTo: viw.centerYAnchor)
        ])
        return viw
    }()
    
    lazy var adminImaegeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "rectangle.stack.badge.person.crop")
        imageView.layer.cornerRadius = 50
        imageView.tintColor = .black
        return imageView
    }()
    lazy var emailLabel:UILabel = {
        let label = UILabel()
        label.text = PanelViewController.admin?.email
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textColor = .white
        return label
    }()
    lazy var dateLabel:UILabel = {
        let label = UILabel()
        label.text = PanelViewController.admin?.date
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .white
        return label
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
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        viewBand.translatesAutoresizingMaskIntoConstraints = false
        gradientLayer()
        
        self.title = "Yönetici"
        navigationController?.navigationBar.backgroundColor = .white

        
    }
    private func layout(){
        
        view.addSubview(viewBand)
        view.addSubview(dateLabel)
        view.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            //adminImaegeView
            viewBand.heightAnchor.constraint(equalToConstant: 100),
            viewBand.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewBand.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewBand.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            //emailLabel
            emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            emailLabel.topAnchor.constraint(equalTo: viewBand.bottomAnchor, constant: 10),
            //dateLabel
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            dateLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10)
            //
        ])
        
    }
    
    
}
