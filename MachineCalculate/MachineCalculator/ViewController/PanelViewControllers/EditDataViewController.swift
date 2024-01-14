//
//  EditDataViewController.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 8.01.2024.
//

import Foundation
import UIKit

class EditDataViewController:UIViewController{
    
    
    
    
    //MARK: - Properties
    var viewModel = EditDataViewModel()
    static var proces:myProcessor?
    let dataUs = DataUse()
    static var delegate: EditDataViewControllerDelegate?
    static var delagate2:EditDataViewControllerDelegate?
    var newGram:Float = 0.0


    
    
    
    lazy var textFieldInput:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.addTarget(self, action: #selector(updateText), for: .editingChanged)
        return textField
    }()
    lazy var editButton:UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        uiButton.contentVerticalAlignment = .fill
        uiButton.contentHorizontalAlignment = .fill
        uiButton.addTarget(self, action: #selector(editData), for: .touchUpInside)
        uiButton.tintColor = .green
        return uiButton
    }()
    lazy var deleteButton:UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "trash.circle.fill"), for: .normal)
        uiButton.contentVerticalAlignment = .fill
        uiButton.contentHorizontalAlignment = .fill
        uiButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        uiButton.tintColor = .red
        return uiButton
    }()
    lazy var nowGram:UILabel = {
        let uiLabel = UILabel()
        let font = UIFont.systemFont(ofSize: 35)
        uiLabel.font = font
        uiLabel.text = "11"
        return uiLabel
    }()
    
    
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButtonStatus()
        style()
        layout()
        setLabel()
    }
    
}

//MARK: - @OBJC
extension EditDataViewController{
    
    @objc func deleteData(){
        dataUs.deleteData(process: EditDataViewController.proces!)
        edited()
    }
    @objc func editData(){
        if newGram != 0.0{
            dataUs.updateData(process: EditDataViewController.proces!, newGram: newGram)
            print(newGram)
            edited()
        }
    }
    @objc func updateText(){
        viewModel.textInputEdit = textFieldInput.text ?? ""
        setNewGram()
    }
}




//MARK: - Helpers
extension EditDataViewController{
    
    private func setNewGram(){
        let text = viewModel.textInputEdit
        if let fVar = Float(text){
            newGram = fVar
            editButtonStatus()
        }else{
            print("eror float")
            newGram = 0
            editButtonStatus()
        }
    }
    
    private func editButtonStatus(){
        if newGram == 0 || "\(newGram)" == nowGram.text {
            editButton.isEnabled = false
        }else{
            editButton.isEnabled = true
        }
            
    }
    
    private func edited(){
        EditDataViewController.delegate?.editedData()
        EditDataViewController.delagate2?.editedData()
    }
    
    private func setLabel(){
        nowGram.text = "\(EditDataViewController.proces!.processor.bankGram)"
    }
    
    private func style(){
        textFieldInput.text = "\(EditDataViewController.proces?.processor.bankGram ?? 0 )"
        textFieldInput.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        nowGram.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        title = "Düzenleme"
        
    }
    private func layout(){
        view.addSubview(textFieldInput)
        view.addSubview(editButton)
        view.addSubview(deleteButton)
        view.addSubview(nowGram)
        
        NSLayoutConstraint.activate([
            //textFieldInput
            textFieldInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            textFieldInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            textFieldInput.heightAnchor.constraint(equalToConstant: 40),
            textFieldInput.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //addButton
            editButton.widthAnchor.constraint(equalToConstant: 80),
            editButton.heightAnchor.constraint(equalToConstant: 80),
            editButton.topAnchor.constraint(equalTo: textFieldInput.bottomAnchor,constant: 20),
            editButton.leftAnchor.constraint(equalTo: textFieldInput.leftAnchor,constant: 40),
            //leaveButton
            deleteButton.widthAnchor.constraint(equalToConstant: 80),
            deleteButton.heightAnchor.constraint(equalToConstant: 80),
            deleteButton.topAnchor.constraint(equalTo: textFieldInput.bottomAnchor,constant: 20),
            deleteButton.rightAnchor.constraint(equalTo: textFieldInput.rightAnchor,constant: -40),
            //bankLabel
            nowGram.bottomAnchor.constraint(equalTo: textFieldInput.topAnchor,constant: -30),
            nowGram.centerXAnchor.constraint(equalTo: textFieldInput.centerXAnchor),
            
        ])
        
    }
    
}
