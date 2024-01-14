//
//  AuthViewController.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 10.01.2024.
//

import Foundation
import UIKit
import FirebaseAuth

class AuthViewController:UIViewController{
    //MARK: - Properties
    let service = AuthService()
    
    var authstack:UIStackView = UIStackView()
    var viewModel = AuthViewModel()
    
    lazy var loginButton = AuthButtonView(title: "Giriş Yap")
    lazy var registerButton = AuthButtonView(title: "Kayıt Ol")
    lazy var emailTextField = AuthTextFieldView(placeHolder: "Email")
    lazy var passwordTextField = AuthTextFieldView(placeHolder: "Şifre")
    lazy var image = UIImageView(image: UIImage(named: "Calcule")!)
    
    var serviceActive = false
    
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        ContainerViewController.delegate = self
        RegisterViewController.delegate = self
        AuthStatusCheck()
        style()
        layout()
        statusCheck()
    }
}
//MARK: - @OBJC
extension AuthViewController{
    
    @objc private func loginButtonClicked(){
        let userSign = UserSign(email: viewModel.email, password: viewModel.password)
        serviceActive = true
        clearTextFields()
        service.signUser(user: userSign) { result, eror in
            if eror != nil{
                print("eror")
                self.serviceActive = false
            }else if result != nil {
                self.AuthStatusCheckView()
                self.serviceActive = false
            }
            self.statusCheck()
        }
    }
    @objc private func registerButtonClicked(){
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(RegisterViewController(), animated: true)
        

    }
    @objc private func updateViewModel(){
        viewModel.email = emailTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        statusCheck()
    }
    
}




//MARK: - Helpers
extension AuthViewController{
    
    private func clearTextFields(){
        emailTextField.text = ""
        passwordTextField.text = ""
        statusCheck()
    }
    
    private func statusCheck(){
        if viewModel.email == "" || viewModel.password == "" || serviceActive == true{
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(named: "buttonEnabled")
        }else{
            loginButton.isEnabled = true
            loginButton.backgroundColor = .none
        }
        if serviceActive == true{
            emailTextField.isEnabled = false
            passwordTextField.isEnabled = false
        }else{
            emailTextField.isEnabled = true
            passwordTextField.isEnabled = true
        }
    }
    
    private func AuthStatusCheckView() {
        if Auth.auth().currentUser?.uid != nil {
            service.getActiveUser { snapshot, eror in
                if eror != nil {
                    print("eror")
                }else if snapshot != nil{
                    if let activeUser = ContainerViewController.activeUser{
                        DispatchQueue.main.async {
                            let controller = UINavigationController(rootViewController: ContainerViewController())
                            controller.modalPresentationStyle = .fullScreen
                            controller.isNavigationBarHidden = true
                            self.present(controller, animated: true)
                        }
                    }
                }
            }
        }
        if Auth.auth().currentUser?.uid == nil {
            dismiss(animated: true)
        }
    }
    
    private func style(){
        gradientLayer()
        
        authstack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton,registerButton])
        authstack.spacing = 5
        authstack.axis = .vertical
        authstack.distribution = .fillEqually
        authstack.backgroundColor = .none
        authstack.translatesAutoresizingMaskIntoConstraints = false

        
        image.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(updateViewModel), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updateViewModel), for: .editingChanged)

    }
    private func layout(){
        view.addSubview(authstack)
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            authstack.widthAnchor.constraint(equalToConstant: 35),
            authstack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            authstack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            authstack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 220),
            image.heightAnchor.constraint(equalToConstant: 220),
            image.bottomAnchor.constraint(equalTo: authstack.topAnchor, constant: -50)
            
        
        ])
    }
    
}

extension AuthViewController:AuthStatusCheckDelegate{
    func AuthStatusCheck() {
        AuthStatusCheckView()
        print("protocol")
    }
}
