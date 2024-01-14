//
//  MennuViewController.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 8.01.2024.
//

import UIKit

class MenuViewController: UIViewController {

    //MARK: - Properties
    weak var delegate : MenuViewControllerDelegate?
    lazy var menuTableView:UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = greyColor
        
        return table
    }()

    let greyColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    enum MenuOptions: String,CaseIterable{
        case home = "Ana Ekran"
        case record = "İşlemler"
        case signOut = "Çıkış"
        case settings = "Ayarlar"
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .record:
                return "rectangle.stack"
            case .signOut:
                return "nosign"
            case .settings:
                return "gearshape"
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        view.backgroundColor = greyColor
        style()
        layout()
    }

}


//MARK: - Helpers
extension MenuViewController{
    private func style(){
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        view.addSubview(menuTableView)
        
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            menuTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

//MARK: - TableView

extension MenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = greyColor
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelectMenuItem(menuItem: item)
    }
}
