//
//  ContainerViewController.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 8.01.2024.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class ContainerViewController:UIViewController{
    //MARK: - Properties
    static var activeUser: ActiveUser? = nil
    static var requests = [Request]()
    let serviceUs = AuthService()
    let service = Service()
    let PanelMain = PanelViewController()
    let AdminMain = AdminViewController()
    let menu = MenuViewController()
    let auth = AuthViewController()
    private var menuState:MenuState = .closed
    var navVc:UINavigationController?
    static var delegate: AuthStatusCheckDelegate?
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc()
    }
}


//MARK: - Helpers

extension ContainerViewController{
    
    private func checkActiveUser(){
        serviceUs.getActiveUser { snap, eror in
            if let eror = eror{
                self.signOut()
                
            }
        }
    }
    
    private func signOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            
        }
    }
    
    private func configureNavigationController(rootViewController:UIViewController)->UINavigationController{
        let controller = UINavigationController(rootViewController: rootViewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        return controller
    }
    
    private func addChildVc() {
        addChild(menu)
        view.addSubview(menu.view)
        menu.didMove(toParent: self)
        menu.delegate = self
        
        if ContainerViewController.activeUser?.rol == "panel"{
            self.PanelMain.delegate = self
            let navVC = UINavigationController(rootViewController: self.PanelMain)
            self.addChild(navVC)
            self.view.addSubview(navVC.view)
            navVC.didMove(toParent: self)
            self.navVc = navVC
        }
        
        if ContainerViewController.activeUser?.rol == "admin"{
            self.AdminMain.delegate = self
            let navVC = UINavigationController(rootViewController: self.AdminMain)
            self.addChild(navVC)
            self.view.addSubview(navVC.view)
            navVC.didMove(toParent: self)
            self.navVc = navVC
        }
    }
    
    
    enum MenuState{
        case opened
        case closed
    }
}

extension ContainerViewController:MainViewControllerDelegate{
    func didTapButton() {
        toogleMenu(complition: nil)
    }
    func toogleMenu(complition: (() -> Void)? ){
        switch menuState{
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.navVc?.view.frame.origin.x = self.PanelMain.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done{
                    self?.menuState = .opened
                }
            }
            
        case.opened:
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.navVc?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done{
                    self?.menuState = .closed
                    complition?()
                }
            }
        }
    }
}

extension ContainerViewController:MenuViewControllerDelegate{
    func didSelectMenuItem(menuItem: MenuViewController.MenuOptions) {
        toogleMenu { [weak self] in
            switch menuItem {
            case .home:
                break
            case .record:
                if ContainerViewController.activeUser?.rol == "admin"{
                    
                }
                if ContainerViewController.activeUser?.rol == "panel"{
                    let vc = ProcesesTableViewController()
                    self?.present(UINavigationController(rootViewController: vc), animated: true)
                }
            case .signOut:
                self?.signOut()
                ContainerViewController.delegate?.AuthStatusCheck()
            case .settings:
                if ContainerViewController.activeUser?.rol == "admin"{
                    let controller = AdminSettingsViewController()
                    let root = self?.configureNavigationController(rootViewController: controller)
                    root?.modalPresentationStyle = .fullScreen
                    self?.present(root!, animated: true)
                }
                if ContainerViewController.activeUser?.rol == "panel"{
                    let controller = PanelSettingsViewController()
                    let root = self?.configureNavigationController(rootViewController: controller)
                    root?.modalPresentationStyle = .fullScreen
                    self?.present(root!, animated: true)
                }
            }
        }
    }
}
