//
//  PanelSettingsViewController.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 12.01.2024.
//

import Foundation
import UIKit

class PanelSettingsViewController:UIViewController{
    //MARK: - Properties
    let service = Service()
    lazy var settingsTableView:UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    enum MenuOptions: String,CaseIterable{
        case request = "Panel İsteği Gönder"
        case showAdmin = "Yöneticini Görüntüle"
        case getData = "Verileri Yükle"
        case signOut = "Geri Dön"
        
        
        var imageName: String {
            switch self {
            case .request:
                return "paperplane"
            case .getData:
                return "square.and.arrow.up"
            case .signOut:
                return "arrowshape.backward"
            case .showAdmin:
                return "person.bust"
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
extension PanelSettingsViewController{
    
    
    private func selectOption(item:MenuOptions){
        switch item{
        case .getData:
            service.uploadData(user: ContainerViewController.activeUser!) { eror in
                if let eror = eror{
                    print("eror")
                }
            }
            
            

            
        case .request:
            let controller = UINavigationController(rootViewController: SentPanelRequestViewController())
            
            present(controller, animated: true)
        case .signOut:
            dismiss(animated: true)
        case .showAdmin:
            print(PanelViewController.admin?.email)
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
        title = "Panel Ayarları"
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
extension PanelSettingsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (MenuOptions.allCases.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsAccountTableViewCell.reuseableCellId, for: indexPath) as! SettingsAccountTableViewCell
            let servic:String = {
                if let admin = PanelViewController.admin{
                    return "Yöneticiye bağlı"
                }else{
                    return "Yöneticiye bağlı değil"
                }
            }()
            cell.configure(email: ContainerViewController.activeUser?.email as! String, rol: ContainerViewController.activeUser?.rol as! String, service: servic)
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
