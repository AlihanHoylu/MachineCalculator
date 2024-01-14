//
//  Protocols.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 8.01.2024.
//

import Foundation

protocol MainViewControllerDelegate:AnyObject{
    func didTapButton()
}

protocol MenuViewControllerDelegate:AnyObject{
    func didSelectMenuItem(menuItem:MenuViewController.MenuOptions)
}

protocol EditDataViewControllerDelegate:AnyObject{
    func editedData()
}

protocol AuthStatusCheckDelegate:AnyObject{
    func AuthStatusCheck()
}
