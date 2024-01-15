//
//  PanelViewController.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 7.01.2024.
//

import UIKit



class PanelViewController: UIViewController {
    //MARK: - Properties
    
    static var admin:Admin?
    weak var delegate: MainViewControllerDelegate?
    private var viewModel = MainViewModel()
    private var bank :Float = 0
    private var newgram:Float = 0
    private var proceses:[myProcessor]?
    private let dataUs = DataUse()
    
    lazy var textFieldInput:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.addTarget(self, action: #selector(updateTextField), for: .editingChanged)
        return textField
    }()
    lazy var addButton:UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        uiButton.contentVerticalAlignment = .fill
        uiButton.contentHorizontalAlignment = .fill
        uiButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        uiButton.tintColor = .systemGray
        return uiButton
    }()
    lazy var leaveButton:UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        uiButton.contentVerticalAlignment = .fill
        uiButton.contentHorizontalAlignment = .fill
        uiButton.addTarget(self, action: #selector(minus), for: .touchUpInside)
        uiButton.tintColor = .systemGray
        return uiButton
    }()
    lazy var bankLabel:UILabel = {
        let uiLabel = UILabel()
        let font = UIFont.systemFont(ofSize: 35)
        uiLabel.font = font
        return uiLabel
    }()
    
    lazy var processTableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .none
        return tableView
    }()
    
    //MARK: - LifeCycles

    override func viewDidLoad() {
        
        super.viewDidLoad()
        EditDataViewController.delagate2 = self
        style()
        layout()
        setBank()
        getData()
        processTableView.delegate = self
        processTableView.dataSource = self
        print(dataUs.downloadData())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBank()
    }


}


//MARK: - @OBJC
extension PanelViewController{
    
    @objc func updateTextField(){
        viewModel.textInputAdd = textFieldInput.text ?? ""
        setNewGram()
    }
    
    @objc func setLabel(){
        bank = FloatExt.yuvarla(say: bank)
        if bank == -0{
            bank = 0
        }
        bankLabel.text = "\(bank)"
        print(bank)
    }
    
    @objc func didTapButton(){
        delegate?.didTapButton()
    }
    
    @objc func add(){
        if let text = textFieldInput.text{
            if let fVar = Float(text){
                bank = bank + fVar
                print(fVar)
                print("added")
                print("bank: \(bank)")
                dataUs.uploadData(bankGram: newgram)
                clearTextField()
                setBank()
            }else{
                print("eror float ")
            }
        }else{
            print("eror text ")
        }
        
    }
    @objc func minus(){
        if let text = textFieldInput.text{
            if let fVar = Float(text){
                bank = bank - fVar
                print(fVar)
                print("leaved")
                print("bank: \(bank)")
                dataUs.uploadData(bankGram: -fVar)
                clearTextField()
                setBank()
            }else{
                print("eror float ")
            }
        }else{
            print("eror text ")
        }
        
    }
    
}


//MARK: - Helpers
extension PanelViewController{
    
    private func setNewGram(){
        let text = viewModel.textInputAdd
        if let fVar = Float(text){
            newgram = FloatExt.yuvarla(say: fVar)
            setButtonStatus()
        }else{
            newgram = 0
            setButtonStatus()
        }
    }
    
    private func clearTextField(){
        textFieldInput.text = ""
        newgram = 0
        setButtonStatus()
    }
    
    private func setButtonStatus(){
        
        if newgram == 0 {
            addButton.isEnabled = false
            leaveButton.isEnabled = false
        }else{
            addButton.isEnabled = true
            leaveButton.isEnabled = true
        }
        
    }
    
    private func setBank(){
        getData()
        bank = 0
        if let proceses = proceses{
            for a in proceses {
                bank = bank + a.processor.bankGram
            }
        }
        setLabel()
        processTableView.reloadData()
    }
    
    private func getData(){
        proceses = dataUs.downloadData()
    }
    
    private func style(){
        addButton.isEnabled = false
        leaveButton.isEnabled = false
        gradientLayer()
        textFieldInput.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        leaveButton.translatesAutoresizingMaskIntoConstraints = false
        bankLabel.translatesAutoresizingMaskIntoConstraints = false
        processTableView.translatesAutoresizingMaskIntoConstraints = false
        title = "Panel Ana Ekranı"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
        }
    
    private func layout(){
        view.addSubview(textFieldInput)
        view.addSubview(addButton)
        view.addSubview(leaveButton)
        view.addSubview(bankLabel)
        view.addSubview(processTableView)
        
        NSLayoutConstraint.activate([
            //textFieldInput
            textFieldInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            textFieldInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            textFieldInput.heightAnchor.constraint(equalToConstant: 40),
            textFieldInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            //addButton
            addButton.widthAnchor.constraint(equalToConstant: 80),
            addButton.heightAnchor.constraint(equalToConstant: 80),
            addButton.topAnchor.constraint(equalTo: textFieldInput.bottomAnchor,constant: 20),
            addButton.leftAnchor.constraint(equalTo: textFieldInput.leftAnchor,constant: 40),
            //leaveButton
            leaveButton.widthAnchor.constraint(equalToConstant: 80),
            leaveButton.heightAnchor.constraint(equalToConstant: 80),
            leaveButton.topAnchor.constraint(equalTo: textFieldInput.bottomAnchor,constant: 20),
            leaveButton.rightAnchor.constraint(equalTo: textFieldInput.rightAnchor,constant: -40),
            //bankLabel
            bankLabel.bottomAnchor.constraint(equalTo: textFieldInput.topAnchor,constant: -30),
            bankLabel.centerXAnchor.constraint(equalTo: textFieldInput.centerXAnchor),
            //processTableView
            processTableView.leftAnchor.constraint(equalTo: textFieldInput.leftAnchor),
            processTableView.rightAnchor.constraint(equalTo: textFieldInput.rightAnchor),
            processTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 30),
            processTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
}

extension PanelViewController:EditDataViewControllerDelegate{
    func editedData() {
        getData()
        print("protocol")
        setBank()
        processTableView.reloadData()
    }
}

//MARK: - TableView
extension PanelViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proceses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let proceses = proceses{
            let index = proceses.count - 1 - indexPath.row
            cell.textLabel?.text = (proceses[index].processor.date?.formatted())! + "     \(proceses[index].processor.bankGram)"
            if proceses[index].processor.bankGram > 0{
                cell.backgroundColor = .systemGreen
            }else{
                cell.backgroundColor = .systemRed
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

