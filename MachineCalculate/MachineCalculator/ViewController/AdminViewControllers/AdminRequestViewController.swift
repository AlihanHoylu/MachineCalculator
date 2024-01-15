//
//  AdminRequestViewController.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 12.01.2024.
//

import Foundation
import UIKit

class AdminRequestViewController:UIViewController{
    //MARK: - Properties
    let service = Service()
    lazy var requestTableView:UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    var selectedIndex = -1
    

    
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

//MARK: - @OBJC
extension AdminRequestViewController{
    @objc private func accept(){
        addPanel()
    }
    
    @objc private func denied(){
        deleteRequest()
    }
    
}

//MARK: - Helpers
extension AdminRequestViewController{
    
    
    private func addPanel(){
        let request = ContainerViewController.requests[selectedIndex-1]
        
        let panel = Panel(id: request.panelUid, email: request.panelEmail)
        let panels = AdminViewController.panels
        let cont:Bool = {
            for oldpanel in panels{
            if panel.email == oldpanel.email{
                return false
            }
        }
        return true
        }()
        if cont == true{
            AdminViewController.panels.append(panel)
        }else{
            print("zaten var")
        }
        service.setPanel(panels: AdminViewController.panels, user: ContainerViewController.activeUser!) { eror in
            if let eror = eror{
                print("eror")
            }else{
                self.deleteRequest()
                self.addAdminForPanel()
            }
        }
    }
    
    private func addAdminForPanel(){
        let request = ContainerViewController.requests[selectedIndex-1]
        service.setAdmin(request: request, user: ContainerViewController.activeUser!) { eror in
            if let eror = eror{
                print(eror.localizedDescription)
            }else{
                print("başarılı")
            }
        }
    }
    
    private func deleteRequest(){
        ContainerViewController.requests.remove(at: selectedIndex-1)
        service.sentAdminRequests(user: ContainerViewController.activeUser!) { eror in
            if let eror = eror{
                print(eror.localizedDescription)
            }else{
                self.requestTableView.reloadData()
                
            }
        }
        requestTableView.reloadData()
    }
    
    
    private func style(){
        gradientLayer()
        navigationController?.navigationBar.backgroundColor = .white
        title = "Yönetici Bağlantı İstekleri"

        requestTableView.register(RequestTableViewCell.self, forCellReuseIdentifier: RequestTableViewCell.reuseableIdentifer)
        requestTableView.register(SettingsAccountTableViewCell.self, forCellReuseIdentifier: SettingsAccountTableViewCell.reuseableCellId)
        requestTableView.estimatedRowHeight = 200
        requestTableView.backgroundColor = UIColor(named: "gray5")
        requestTableView.delegate = self
        requestTableView.dataSource = self
        requestTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        view.addSubview(requestTableView)

        NSLayoutConstraint.activate([
            requestTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            requestTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            requestTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            requestTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - TableView
extension AdminRequestViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContainerViewController.requests.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showRequests = ContainerViewController.requests
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsAccountTableViewCell.reuseableCellId, for: indexPath) as! SettingsAccountTableViewCell
            cell.configure(email: ContainerViewController.activeUser?.email as! String, rol: "Bağlantı istekleri \(ContainerViewController.requests.count)/10" , service: "\(AdminViewController.panels.count) adet panel bağlı")
            tableView.rowHeight = 100
            cell.backgroundColor = UIColor(named: "gray2")
            cell.tintColor = .white
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: RequestTableViewCell.reuseableIdentifer, for: indexPath) as! RequestTableViewCell
            cell.configure(panelEmail: showRequests[indexPath.row-1].panelEmail, requestDate: "İstek Tarihi:\(showRequests[indexPath.row-1].requestDate)")
            if selectedIndex == indexPath.row{
                cell.acceptRequestButton.isHidden = false
                cell.deleteRequestButton.isHidden = false
            }else{
                cell.acceptRequestButton.isHidden = true
                cell.deleteRequestButton.isHidden = true
            }
            cell.acceptRequestButton.addTarget(self, action: #selector(accept), for: .touchUpInside)
            cell.deleteRequestButton.addTarget(self, action: #selector(denied), for: .touchUpInside)
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        //tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 100
        }else{
            if selectedIndex == indexPath.row{
                return 130
            }else{
                return 70
            }
        }
        
    }
    
    
}


