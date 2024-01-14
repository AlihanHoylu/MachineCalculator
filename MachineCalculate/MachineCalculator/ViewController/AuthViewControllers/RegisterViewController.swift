//
//  RegisterViewController.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 11.01.2024.
//

import Foundation
import UIKit

class RegisterViewController:UIViewController{
    //MARK: - Properties
    lazy var emailTextField = AuthTextFieldView(placeHolder: "Email")
    lazy var passwordTextField = AuthTextFieldView(placeHolder: "Şifre")
    lazy var againPasswordTextField = AuthTextFieldView(placeHolder: "Tekrar Şifre")
    lazy var registerButton = AuthButtonView(title: "Kayıt Ol")
    lazy var image = UIImageView(image: UIImage(named: "Calcule")!)
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Yönetici", "Panel"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    var stackView = UIStackView()
    var viewModel = RegisterViewModel()
    var rol:String = ""
    let service = AuthService()
    var serviceActive = false
    static var delegate: AuthStatusCheckDelegate?
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        statusCheck()
        style()
        layout()
    }
}
//MARK: - @OBJC
extension RegisterViewController{
    @objc private func updateViewModel(){
        viewModel.againPassword = againPasswordTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.email = emailTextField.text ?? ""
        
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            viewModel.role = "admin"
        case 1:
            viewModel.role = "panel"
        default:
            break
        }
        statusCheck()
    }
    
    @objc private func registerButtonClicked(){
        serviceActive = true
        statusCheck()
        if viewModel.againPassword == viewModel.password{
            let newUser = User(email: viewModel.email, password: viewModel.password, rol: viewModel.role)
            service.createUser(newUser: newUser) { result, eror in
                if eror != nil{
                    print(eror!.localizedDescription)
                    self.serviceActive = false
                    self.statusCheck()
                }else if result != nil{
                    self.serviceActive = false
                    self.navigationController?.popViewController(animated: true)
                    RegisterViewController.delegate?.AuthStatusCheck()
                }
            }
            clearTextFields()
            statusCheck()
        }
    }
}



//MARK: - Helpers
extension RegisterViewController{
    private func clearTextFields(){
        emailTextField.text = ""
        passwordTextField.text = ""
        againPasswordTextField.text = ""
    }
    
    private func statusCheck(){
        if viewModel.email == "" || viewModel.password == "" || viewModel.againPassword == "" || viewModel.againPassword != viewModel.password || serviceActive == true {
            registerButton.isEnabled = false
            registerButton.backgroundColor = UIColor(named: "buttonEnabled")
        }else{
            registerButton.isEnabled = true
            registerButton.backgroundColor = .none
        }
        
        if serviceActive == true{
            emailTextField.isEnabled = false
            passwordTextField.isEnabled = false
            againPasswordTextField.isEnabled = false
        }else if serviceActive == false{
            emailTextField.isEnabled = true
            passwordTextField.isEnabled = true
            againPasswordTextField.isEnabled = true
        }
    }
    
    private func style(){
        gradientLayer()
        stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,againPasswordTextField,segmentedControl,registerButton])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .none
        stackView.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.addTarget(self, action: #selector(updateViewModel), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updateViewModel), for: .editingChanged)
        againPasswordTextField.addTarget(self, action: #selector(updateViewModel), for: .editingChanged)
        registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        emailTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
        againPasswordTextField.isSecureTextEntry = true
        segmentedControl.addTarget(self, action: #selector(updateViewModel), for: .valueChanged)
    }
    private func layout(){
        view.addSubview(stackView)
        view.addSubview(image)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 35),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 220),
            image.heightAnchor.constraint(equalToConstant: 220),
            image.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -50)
        ])
    }
}
