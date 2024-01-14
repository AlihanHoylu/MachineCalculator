//
//  SentPanelRequestViewController.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 12.01.2024.
//

import Foundation
import UIKit

class SentPanelRequestViewController:UIViewController{
    //MARK: - Properties
    var viewModel = SentPanelRequestViewModel(emailTextFieldText: "")
    let service = Service()
    var serviceActiv = false
    lazy var textFieldInputMail:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Yönetici Email..."
        textField.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        textField.font = UIFont.systemFont(ofSize: 20)
        let stick = UIView()
        stick.backgroundColor = .black
        textField.addSubview(stick)
        stick.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stick.topAnchor.constraint(equalTo: textField.bottomAnchor),
            stick.leftAnchor.constraint(equalTo: textField.leftAnchor),
            stick.rightAnchor.constraint(equalTo: textField.rightAnchor),
            stick.heightAnchor.constraint(equalToConstant: 1)
        ])
        return textField
    }()
    lazy var sentButton:UIButton = {
        let buton = UIButton()
        buton.setTitle("Bağlantı İsteği Gönder", for: .normal)
        buton.titleLabel?.tintColor = .black
        buton.backgroundColor = .systemTeal
        let stick = UIView()
        stick.backgroundColor = .black
        buton.addSubview(stick)
        stick.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stick.topAnchor.constraint(equalTo: buton.bottomAnchor),
            stick.leftAnchor.constraint(equalTo: buton.leftAnchor),
            stick.rightAnchor.constraint(equalTo: buton.rightAnchor),
            stick.heightAnchor.constraint(equalToConstant: 1)
        ])
        return buton
    }()

    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        statusCheck()
    }
}
//MARK: - @OBJC
extension SentPanelRequestViewController{
    @objc private func updateViewModel(){
        viewModel.emailTextFieldText = textFieldInputMail.text ?? ""
        statusCheck()
    }
    
    @objc private func sentButtonClicked(){
        let mail = viewModel.emailTextFieldText
        clearTextFields()
        serviceActiv = true
        service.sentAdminRequest(user: ContainerViewController.activeUser!, requestMail: mail) { eror in
            if let eror = eror{
                print(eror.localizedDescription)
                self.serviceActiv = false
                self.statusCheck()
            }
        }
        self.serviceActiv = false
        self.statusCheck()
    }
    
    
}
//MARK: - Helpers
extension SentPanelRequestViewController{
    
    private func clearTextFields(){
        textFieldInputMail.text = ""
        updateViewModel()
        statusCheck()
    }
    
    private func statusCheck(){
        if viewModel.emailTextFieldText == "" || serviceActiv == true{
            sentButton.isEnabled = false
            sentButton.backgroundColor = UIColor(white: 0.3, alpha: 1)
        }else{
            sentButton.isEnabled = true
            sentButton.backgroundColor = .systemTeal
        }
    }
    
    private func style(){
        gradientLayer()
        navigationController?.navigationBar.backgroundColor = .white
        title = "Yönetici Bağlantı İsteği Gönder"
        
        textFieldInputMail.translatesAutoresizingMaskIntoConstraints = false
        sentButton.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldInputMail.addTarget(self, action: #selector(updateViewModel), for: .editingChanged)
        sentButton.addTarget(self, action: #selector(sentButtonClicked), for: .touchUpInside)
    }
    private func layout(){
        view.addSubview(textFieldInputMail)
        view.addSubview(sentButton)
        
        NSLayoutConstraint.activate([
            //textFieldInputMail
            textFieldInputMail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            textFieldInputMail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            textFieldInputMail.heightAnchor.constraint(equalToConstant: 40),
            textFieldInputMail.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -135),
            //sentButton
            sentButton.topAnchor.constraint(equalTo: textFieldInputMail.bottomAnchor,constant: 15),
            sentButton.heightAnchor.constraint(equalToConstant: 40),
            sentButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40),
            sentButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40)
        ])
    }
}
