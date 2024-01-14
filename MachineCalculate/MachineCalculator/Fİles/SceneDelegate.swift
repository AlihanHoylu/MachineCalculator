//
//  SceneDelegate.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 7.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let rootViewController = AuthViewController()
        let naviCont = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = naviCont
        window?.makeKeyAndVisible()
    }
    
    static func configureNavigationController(rootViewController:UIViewController)->UINavigationController{
        let controller = UINavigationController(rootViewController: rootViewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        return controller
    }

}

