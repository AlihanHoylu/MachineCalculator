//
//  PanelsCollectionViewCell.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 15.01.2024.
//

import UIKit

class PanelsCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let reuseableCellId = "panellcollectioncell"
    var process:[ProcessorS]?
    static var panel:Panel?
    
    lazy var emailLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var panelProcesTableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    
    
    
    //MARK: - LifeCycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        process = AdminViewController.panelDatas[PanelsCollectionViewCell.panel!.email]
        panelProcesTableView.dataSource = self
        panelProcesTableView.delegate = self
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Helpers
extension PanelsCollectionViewCell{
    
    private func style(){
        panelProcesTableView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        panelProcesTableView.backgroundColor = .none
        layer.cornerRadius = 10
        
    }
    private func layout(){
        addSubview(panelProcesTableView)
        addSubview(dateLabel)
        addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            //emailLabel
            emailLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            emailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            emailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -1),
            //dateLabel
            dateLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 7),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -1),
            //panelProcesTableView
            panelProcesTableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            panelProcesTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            panelProcesTableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            panelProcesTableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
        ])
        
    }
}

//MARK: - TableView
extension PanelsCollectionViewCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return process?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if process![indexPath.row].bankGram < 0 {
            cell.backgroundColor = .systemRed
        }else{
            cell.backgroundColor = .systemGreen
        }
        
        cell.textLabel?.text = "\(process![indexPath.row].bankGram)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
    
}
