//
//  AdminViewController.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 13.01.2024.
//

import Foundation
import UIKit
import JGProgressHUD

class AdminViewController:UIViewController{
    //MARK: - Properties
    weak var delegate: MainViewControllerDelegate?
    let service = Service()
    static var panels = [Panel]()
    static var panelDatas = [String:[ProcessorS]]()
    static var requests = [Request]()
    
    
    lazy var panelsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Int(view.frame.width)/2-7, height: Int(view.frame.height)/3)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        panels.forEach(<#T##body: (Panel) throws -> Void##(Panel) throws -> Void#>)
        
        
        var dataDesc = true ? "equal to 7" : "not equal to 7"
        
        
        return collectionView
    }()
    
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        
        
        
        panelsCollectionView.dataSource = self
        panelsCollectionView.delegate = self
        super.viewDidLoad()
        panelsCollectionView.register(PanelsCollectionViewCell.self, forCellWithReuseIdentifier: PanelsCollectionViewCell.reuseableCellId)
        style()
        layout()
    }
}
//MARK: - @OBJC
extension AdminViewController{
    @objc func didTapButton(){
        delegate?.didTapButton()
    }
}

//MARK: - Helpers
extension AdminViewController{
    private func style(){
        gradientLayer()
        title = "Yönetici Ana Ekranı"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
        panelsCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        
        view.addSubview(panelsCollectionView)
        
        NSLayoutConstraint.activate([
            panelsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            panelsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 2),
            panelsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -2),
            panelsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

//MARK: - CollectionView
extension AdminViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AdminViewController.panels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        PanelsCollectionViewCell.panel = AdminViewController.panels[indexPath.row]
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: PanelsCollectionViewCell.reuseableCellId, for: indexPath) as! PanelsCollectionViewCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: PanelsCollectionViewCell.reuseableCellId, for: indexPath) as! PanelsCollectionViewCell
        cell.emailLabel.text = AdminViewController.panels[indexPath.row].email
        cell.dateLabel.text = "2222/22/22 22:22"
        cell.panelProcesTableView.reloadData()
        cell.backgroundColor = .buttonEnabled
        return cell
    }
}
