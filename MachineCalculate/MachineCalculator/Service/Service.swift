//
//  Service.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 12.01.2024.
//

import Foundation
import Firebase
import FirebaseFirestore

class Service{
    let data = DataUse()
    
    func sentAdminRequest(user:ActiveUser,requestMail:String,completion: @escaping (Error?) -> Void){
        getAdminRequest(userEmail: requestMail) { eror, snapshot in
            if let eror = eror{
                print(eror.localizedDescription)
            }else if let snapshot = snapshot{
                let oldRequests = AdminViewController.requests
                
                if oldRequests.count<11{
                    let date = Date()
                    let dateText = date.formatted()
                    var dataArray = [[String:Any]]()
                    let data:[String:Any] = [ "panelemail": user.email,
                                              "paneluid": user.id,
                                              "date": dateText
                    ]
                    
                    var requests:[String:[[String:Any]]]
                    for request in oldRequests{
                    
                        let oldData:[String:Any] = [ "panelemail": request.panelEmail,
                                                  "paneluid": request.panelUid,
                                                  "date": request.requestDate
                        ]
                        dataArray.append(oldData)
                    }
                    dataArray.append(data)
                    requests = ["request":dataArray]
                    
                    Firestore.firestore().collection("requests").document(requestMail).setData(requests) { eror in
                        if let eror = eror{
                            completion(eror)
                        }else{
                            completion(nil)
                        }
                    }
                }else{
                    print("Fazla istek")
                    completion(.some(Error.self as! Error))
                }
            }
        }
    }
    
    func sentAdminRequests(user:ActiveUser,completion: @escaping (Error?) -> Void){
                let oldRequests = AdminViewController.requests
                
                if oldRequests.count<10{
                    
                    var dataArray = [[String:Any]]()
                    
                    var requests:[String:[[String:Any]]]
                    
                    for request in oldRequests{
                    
                        let oldData:[String:Any] = [ "panelemail": request.panelEmail,
                                                  "paneluid": request.panelUid,
                                                  "date": request.requestDate
                        ]
                        dataArray.append(oldData)
                    }
                    
                    requests = ["request":dataArray]
                    
                    Firestore.firestore().collection("requests").document(user.email).setData(requests) { eror in
                        if let eror = eror{
                            completion(eror)
                        }else{
                            completion(nil)
                        }
                    }
                }else{
                    print("Fazla istek")
                }
    }
    
    func getAdminRequest(userEmail:String,completion: @escaping (Error?,DocumentSnapshot?) -> Void){
        AdminViewController.requests.removeAll()
        Firestore.firestore().collection("requests").document(userEmail).getDocument { snapshot, eror in
            if let eror = eror{
                completion(eror, nil)
                
            }else if let snapshot = snapshot{
                var requests = [Request]()
                if let document = snapshot.data(){
                    let datas = document["request"] as! [[String:Any]]
                    for data in datas{
                        let request = Request(panelEmail: data["panelemail"] as! String, panelUid: data["paneluid"] as! String, requestDate: data["date"] as! String)
                        requests.append(request)
                        AdminViewController.requests.append(request)
                    }
                }else{
                    AdminViewController.requests = requests
                }
                completion(nil, snapshot)
            }
        }
    }
    
    
    func setPanel(panels:[Panel],user:ActiveUser,completion: @escaping (Error?) -> Void){
        if AdminViewController.panels.count < 10{
            let data:[String:Any]
            var panelsData = [[String:Any]]()
            
            for panel in panels {
                let datapanel = [
                    "panelId":panel.id,
                    "panelEmail":panel.email
                ]
                panelsData.append(datapanel)
            }
            data = ["panels":panelsData]
            Firestore.firestore().collection("users").document(user.id).setData(data,merge: true) { eror in
                if let eror = eror{
                    completion(eror)
                }else{
                    completion(nil)
                }
            }
        }
    }
    
    
    
    func getPanels(user:ActiveUser,completion: @escaping (Error?) -> Void){
        Firestore.firestore().collection("users").document(user.id).getDocument { snapshot, eror in
            if let eror = eror {
                completion(eror)
            }else{
                var panels = [Panel]()
                if let document = snapshot?.data(){
                    if let datas = document["panels"] as? [[String:Any]]{
                        for data in datas{
                            panels.append(Panel(id: data["panelId"] as! String, email: data["panelEmail"] as! String))
                        }
                    }
                }
                AdminViewController.panels = panels
                completion(nil)
            }
        }
    }
    
    func getAdmin(user:ActiveUser,completion: @escaping (Error?) -> Void){
        Firestore.firestore().collection("users").document(user.id).getDocument { snapshot, eror in
            if let eror = eror {
                completion(eror)
            }else{
                if let document = snapshot?.data(){
                    if let datas = document["admin"] as? [String:Any]{
                        let admin = Admin(email: datas["adminEmail"] as! String, id: datas["adminId"] as! String, date: datas["admindate"] as! String)
                        PanelViewController.admin = admin
                    }
                }
                completion(nil)
            }
        }
    }
    
    func setAdmin(request:Request,user:ActiveUser,completion: @escaping (Error?) -> Void){
        let date = Date().formatted()
        Firestore.firestore().collection("users").document(request.panelUid).getDocument { snapshot, eror in
            if let eror = eror{
                print(eror.localizedDescription)
                completion(eror)
            }else{
                if let document = snapshot?.data(){
                    if let datas = document["admin"] as? [String:Any]{
                        let admin = Admin(email: datas["adminEmail"] as! String, id: datas["adminId"] as! String, date: datas["admindate"] as! String)
                        print("admine sahip bir panel")
                    }else{
                        let admin = Admin(email: user.email, id: user.id, date: date)
                        let data : [String:Any] = [
                            "adminEmail":admin.email,
                            "adminId":admin.id,
                            "admindate":admin.date
                        ]
                        Firestore.firestore().collection("users").document(request.panelUid).setData(["admin":data],merge: true) { eror in
                            if let eror = eror{
                                completion(eror)
                            }else{
                                completion(nil)
                            }
                        }
                    }
                }
            }
                
        }
    }
    
    func uploadData(user:ActiveUser,completion: @escaping (Error?) -> Void){
        let process = data.downloadData()
        var data = [String:Any]()
        var datas = [[String:Any]]()
        for proces in process{
            let dataProces:[String:Any] = [
                "bankGram": proces.processor.bankGram,
                "date": proces.processor.date?.formatted(),
                "id":proces.processor.id?.uuidString
            ]
            datas.append(dataProces)
        }
        data = ["data":datas]
        Firestore.firestore().collection("users").document(user.id).setData(data, merge: true) { eror in
            if let eror = eror{
                completion(eror)
            }else{
                completion(nil)
            }
        }
    }
    
    func downloadData(panels:[Panel],completion: @escaping (Error?) -> Void){
        if panels.count == 0 {
            completion(nil)
        }else{
            for panel in panels{
                var process = [ProcessorS]()
                Firestore.firestore().collection("users").document(panel.id).getDocument { snapshot, eror in
                    if let eror = eror {
                        completion(eror)
                    }else{
                        if let document = snapshot?.data(){
                            if let datas = document["data"] as? [[String:Any]]{
                                for data in datas{
                                    process.append(ProcessorS(bankGram: data["bankGram"] as! Float, id: data["id"] as! String, date: data["date"] as! String))
                                }
                                print(process)
                                print(panel.email)
                                AdminViewController.panelDatas[panel.email] = process
                                completion(nil)
                            }else{
                                print("eror")
                            }
                        }
                    }
                }
            }
        }
    }
    
//    func downloadOwnData(panel: Panel,completion: @escaping (Error?) -> Void){
//        var process = [proces]
//    }
    
    
}
