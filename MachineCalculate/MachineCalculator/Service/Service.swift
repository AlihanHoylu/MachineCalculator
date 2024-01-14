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
    
    func sentAdminRequest(user:ActiveUser,requestMail:String,completion: @escaping (Error?) -> Void){
        getAdminRequest(userEmail: requestMail) { eror, snapshot in
            if let eror = eror{
                print(eror.localizedDescription)
            }else if let snapshot = snapshot{
                let oldRequests = ContainerViewController.requests
                
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
                        }
                    }
                }else{
                    print("Fazla istek")
                }
            }
        }
    }
    
    func sentAdminRequests(user:ActiveUser,completion: @escaping (Error?) -> Void){
                let oldRequests = ContainerViewController.requests
                
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
                        }
                    }
                }else{
                    print("Fazla istek")
                }
            
        
    }
    
    func getAdminRequest(userEmail:String,completion: @escaping (Error?,DocumentSnapshot?) -> Void){
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
                        ContainerViewController.requests.append(request)
                    }
                }else{
                    ContainerViewController.requests = requests
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
                completion(eror)
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
                    let datas = document["panels"] as! [[String:Any]]
                    for data in datas{
                        panels.append(Panel(id: data["panelId"] as! String, email: data["panelEmail"] as! String))
                    }
                }
                AdminViewController.panels = panels
            }
        }
    }
}
