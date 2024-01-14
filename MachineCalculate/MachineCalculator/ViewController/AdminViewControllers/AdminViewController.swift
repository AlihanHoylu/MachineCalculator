//
//  AdminViewController.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 13.01.2024.
//

import Foundation
import UIKit

class AdminViewController:UIViewController{
    //MARK: - Properties
    weak var delegate: MainViewControllerDelegate?
    let service = Service()
    static var panels = [Panel]()
    
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView()
        
        return collectionView
    }()
    
    
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        super.viewDidLoad()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        service.getAdminRequest(userEmail: ContainerViewController.activeUser!.email) { eror, snapshot in
            if let eror = eror{
                print(eror.localizedDescription)
            }else{
                print(ContainerViewController.requests.count)
                print(ContainerViewController.requests)
            }
        }
        service.getPanels(user: ContainerViewController.activeUser!) { eror in
            if let eror = eror{
                print(eror.localizedDescription)
            }else{
                print(AdminViewController.panels.count)
            }
        }
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
    }
    private func layout(){
        
    }
    
}

//MARK: - CollectionView
extension AdminViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
