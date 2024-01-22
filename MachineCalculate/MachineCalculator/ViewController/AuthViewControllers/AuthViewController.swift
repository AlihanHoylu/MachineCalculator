//
//  AuthViewController.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 10.01.2024.
//

import Foundation
import UIKit
import FirebaseAuth
import JGProgressHUD

class AuthViewController:UIViewController{
    //MARK: - Properties
    
    
    
    let service = AuthService()
    let serviceData = Service()
    
    var authstack:UIStackView = UIStackView()
    var viewModel = AuthViewModel()
    
    lazy var loginButton = AuthButtonView(title: "Giriş Yap")
    lazy var registerButton = AuthButtonView(title: "Kayıt Ol")
    lazy var emailTextField = AuthTextFieldView(placeHolder: "Email")
    lazy var passwordTextField = AuthTextFieldView(placeHolder: "Şifre")
    lazy var image = UIImageView(image: UIImage(named: "Calcule")!)
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        //hud.show(in: self.view)
        //signOut()
        super.viewDidLoad()
        ContainerViewController.delegate = self
        RegisterViewController.delegate = self
        style()
        layout()
        statusCheck()
        AuthStatusCheckView()
    }
}
//MARK: - @OBJC
extension AuthViewController{
    
    
    @objc private func loginButtonClicked(){
        let hude = JGProgressHUD(style: .dark)
        hude.interactionType = .blockAllTouches
        hude.textLabel.text = "Yükleniyor"
        hude.show(in: self.view)
        
        let userSign = UserSign(email: viewModel.email, password: viewModel.password)
        clearTextFields()
        service.signUser(user: userSign) { result, eror in
            if let eror = eror{
                print("eror")
                self.hud(type: "error", subtitle: eror.localizedDescription)
                hude.dismiss()

            }else if result != nil {
                self.hud(type: "succes", subtitle: "Giriş Başarılı")
                self.AuthStatusCheckView()
                hude.dismiss()
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
    
    private func signOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            
        }
    }
    
    private func clearTextFields(){
        emailTextField.text = ""
        passwordTextField.text = ""
        statusCheck()
    }
    
    private func statusCheck(){
        if viewModel.email == "" || viewModel.password == "" {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(named: "buttonEnabled")
        }else{
            loginButton.isEnabled = true
            loginButton.backgroundColor = .none
        }
    }
    
    private func AuthStatusCheckView() {
        
        let hude = JGProgressHUD(style: .dark)
        hude.interactionType = .blockAllTouches
        hude.textLabel.text = "Yükleniyor"
        hude.show(in: self.view)
        
        if Auth.auth().currentUser?.uid != nil {
            service.getActiveUser { snapshot, eror in
                if eror != nil {
                    print("eror")
                }else if snapshot != nil{
                    if let activeUser = ContainerViewController.activeUser{
                        if activeUser.rol == "admin"{
                            self.serviceData.getAdminRequest(userEmail: activeUser.email) { eror, snapshot in
                                if let eror = eror{
                                    print("istek getirmede hata")
                                    hude.dismiss()
                                    self.hud(type: "error", subtitle: eror.localizedDescription)
                                }else{
                                    self.serviceData.getPanels(user: ContainerViewController.activeUser!) { eror in
                                        if let eror = eror{
                                            print("panel getirmede hata")
                                            hude.dismiss()
                                            self.hud(type: "error", subtitle: eror.localizedDescription)
                                        }else{
                                            self.serviceData.downloadData(panels: AdminViewController.panels) { eror in
                                                if let eror = eror{
                                                    print("data indirmede hata")
                                                    hude.dismiss()
                                                    self.hud(type: "error", subtitle: eror.localizedDescription)
                                                }else{
                                                    DispatchQueue.main.async {
                                                        hude.dismiss()
                                                        self.hud(type: "sucses", subtitle: "Başarılı Yükleme")

                                                        let controller = UINavigationController(rootViewController: ContainerViewController())
                                                        controller.modalPresentationStyle = .fullScreen
                                                        controller.isNavigationBarHidden = true
                                                        self.present(controller, animated: true)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }else if activeUser.rol == "panel"{
                            self.service.getActiveUser { snapshot, eror in
                                if let eror = eror{
                                    print("eror")
                                    hude.dismiss()
                                    self.hud(type: "error", subtitle: eror.localizedDescription)
                                }else if snapshot != nil{
                                    if let activeUser = ContainerViewController.activeUser{
                                        if activeUser.rol == "panel"{
                                            self.serviceData.getAdmin(user: ContainerViewController.activeUser!) { eror in
                                                if let eror = eror{
                                                    print("eror")
                                                    hude.dismiss()
                                                    self.hud(type: "error", subtitle: eror.localizedDescription)
                                                }else{
                                                    hude.dismiss()
                                                    self.hud(type: "sucses", subtitle: "Giriş Başarılı")

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
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if Auth.auth().currentUser?.uid == nil {
            hude.dismiss()
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
        passwordTextField.isSecureTextEntry = true
        
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
