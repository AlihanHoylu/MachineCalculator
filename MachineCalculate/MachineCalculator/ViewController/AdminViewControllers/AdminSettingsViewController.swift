//
//  AdminSettingsViewController.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 12.01.2024.
//

import Foundation
import UIKit

class AdminSettingsViewController:UIViewController{
    //MARK: - Properties
    lazy var settingsTableView:UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    enum MenuOptions: String,CaseIterable{
        case requests = "Panel İstekleri"
        case showPanels = "Panelleri Görüntüle"
        case getData = "Verileri Yükle"
        case signOut = "Geri Dön"
        
        
        var imageName: String {
            switch self {
            case .requests:
                return "rectangle.stack.badge.plus"
            case .getData:
                return "square.and.arrow.down"
            case .signOut:
                return "arrowshape.backward"
            case .showPanels:
                return "rectangle.stack"
            }
        }
    }
    
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

//MARK: - Helpers
extension AdminSettingsViewController{
    
    
    private func selectOption(item:MenuOptions){
        switch item{
        case .getData:
            print("get")
        case .requests:
            let controller = UINavigationController(rootViewController: AdminRequestViewController())
            
            present(controller, animated: true)
        case .signOut:
            dismiss(animated: true)
        case .showPanels:
            print("Show Panels")
        }
    }
    
    
    private func style(){
        view.backgroundColor = .none
        gradientLayer()
        settingsTableView.register(SettingsAccountTableViewCell.self, forCellReuseIdentifier: SettingsAccountTableViewCell.reuseableCellId )
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .systemBackground
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.backgroundColor = UIColor(named: "gray5")
        settingsTableView.scrollsToTop = false
        title = "Yönetici Ayarları"
    }
    
    private func layout(){
        view.addSubview(settingsTableView)

        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - TableView
extension AdminSettingsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (MenuOptions.allCases.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsAccountTableViewCell.reuseableCellId, for: indexPath) as! SettingsAccountTableViewCell
            cell.configure(email: ContainerViewController.activeUser?.email as! String, rol: ContainerViewController.activeUser?.rol as! String, service: "\(AdminViewController.panels.count) Adet Panel Bağlı")
            tableView.rowHeight = 100
            cell.backgroundColor = UIColor(named: "gray2")
            cell.tintColor = .white
            cell.selectionStyle = .none
            return cell
        }else{
            tableView.rowHeight = 50
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = MenuOptions.allCases[indexPath.row-1].rawValue
            cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row-1].imageName)
            cell.tintColor = .black
            cell.backgroundColor = .systemGray3
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            let item = MenuOptions.allCases[indexPath.row - 1]
            selectOption(item: item)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
