//
//  RequestTableViewCell.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 12.01.2024.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let reuseableIdentifer = "RequestTableViewCell"
    
    lazy var requestPanelEmailLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .black
        return label
    }()
    
    lazy var requestPanelDateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    lazy var deleteRequestButton:UIButton = {
        let button = UIButton()
        button.setTitle("Red Et", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tintColor = UIColor(named: "RequstLabelColor")
        button.backgroundColor = .systemRed
        return button
    }()
    lazy var acceptRequestButton:UIButton = {
        let button = UIButton()
        button.setTitle("Kabul Et", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tintColor = UIColor(named: "RequstLabelColor")
        button.backgroundColor = .systemGreen
        return button
    }()
    
    
    
    //MARK: - LifeCycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK: - Helpers
extension RequestTableViewCell{
    public func configure(panelEmail:String,requestDate:String){
        requestPanelEmailLabel.text = panelEmail
        requestPanelDateLabel.text = requestDate
        
        requestPanelDateLabel.translatesAutoresizingMaskIntoConstraints = false
        requestPanelEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        acceptRequestButton.translatesAutoresizingMaskIntoConstraints = false
        deleteRequestButton.translatesAutoresizingMaskIntoConstraints = false
        acceptRequestButton.layer.cornerRadius = 9
        deleteRequestButton.layer.cornerRadius = 9
        
        backgroundColor = .systemGray3
    }
    
    
    private func layout(){
        addSubview(requestPanelDateLabel)
        addSubview(requestPanelEmailLabel)
        addSubview(acceptRequestButton)
        addSubview(deleteRequestButton)
        
        NSLayoutConstraint.activate([
            //requestPanelEmailLabel
            requestPanelEmailLabel.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            requestPanelEmailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            requestPanelEmailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5),
            //requestPanelDateLabel
            requestPanelDateLabel.topAnchor.constraint(equalTo: requestPanelEmailLabel.bottomAnchor, constant: 9),
            requestPanelDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5),
            requestPanelDateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            //acceptRequestButton
            acceptRequestButton.topAnchor.constraint(equalTo: requestPanelDateLabel.bottomAnchor, constant: 9),
            acceptRequestButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
            acceptRequestButton.widthAnchor.constraint(equalToConstant: 150),
            acceptRequestButton.heightAnchor.constraint(equalToConstant: 45),
            //deleteRequestButton
            deleteRequestButton.topAnchor.constraint(equalTo: requestPanelDateLabel.bottomAnchor, constant: 9),
            deleteRequestButton.leftAnchor.constraint(equalTo: acceptRequestButton.rightAnchor, constant: 15),
            deleteRequestButton.heightAnchor.constraint(equalToConstant: 45),
            deleteRequestButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
