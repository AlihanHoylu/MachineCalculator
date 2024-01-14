//
//  TableViewController.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 8.01.2024.
//

import UIKit

class ProcesesTableViewController: UITableViewController {
    let dataUs = DataUse()
    var data = [myProcessor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        getDatas()
        style()
        layout()
        EditDataViewController.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let index = data.count - 1 - indexPath.row
        cell.textLabel?.text = (data[index].processor.date?.formatted())! + "      " + "\(data[index].processor.bankGram)"
        if data[index].processor.bankGram > 0{
            cell.backgroundColor = .systemGreen
        }else{
            cell.backgroundColor = .systemRed
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("a")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = data.count - 1 - indexPath.row
        EditDataViewController.proces = data[index]
        let vc = EditDataViewController()
        
        let root = UINavigationController(rootViewController: vc)
        root.navigationBar.backgroundColor = .white
        self.present(root, animated: true)
    }
}

//MARK: - Helpers
extension ProcesesTableViewController{
    
    private func getDatas(){
        data = dataUs.downloadData()
        tableView.reloadData()
    }
    
    private func style(){
        title = "İşlemler"
    }
    private func layout(){
        
    }
}

extension ProcesesTableViewController:EditDataViewControllerDelegate{
    func editedData() {
        print("protocol")
        dismiss(animated: true)
        getDatas()
    }
}
