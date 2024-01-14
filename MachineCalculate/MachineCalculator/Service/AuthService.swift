//
//  AuthService.swift
//  MachineCalculator
//
//  Created by Alihan Hoylu on 11.01.2024.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthService{
    
    
    func createUser(newUser:User,completion: @escaping (AuthDataResult?,Error?) -> Void){
        Auth.auth().createUser(withEmail: newUser.email, password: newUser.password) { result, eror in
            if let eror = eror{
                completion(nil,eror)
                

            }else{
                guard let userid = result?.user.uid else {return}
                let data = [
                    "name":newUser.email,
                    "rol":newUser.rol,
                ] as [String: Any]
                Firestore.firestore().collection("users").document(userid).setData(data) { eror in
                    if let eror = eror{
                        completion(nil,eror)
                        
                    }else{
                        completion(result,nil)
                    }
                }
            }
            }
        }
    
    
    func signUser(user:UserSign,completion: @escaping (AuthDataResult?,Error?) -> Void){
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, eror in
            if let eror = eror{
                completion(nil, eror)
            }else if let result = result{
                completion(result, nil)
            }
        }
    }
    
    func getActiveUser(completion: @escaping (DocumentSnapshot?,Error?)->Void){

        if let userid = Auth.auth().currentUser?.uid{
            getActiveUserRol(id: userid) { snapshot, eror in
                if let eror = eror{
                    completion(nil,eror)
                }else if let snapshot = snapshot{
                    let document = snapshot.data()! as [String:Any]
                    print(document)
                    
                    ContainerViewController.activeUser = ActiveUser(email: document["name"] as! String, service: "Not yet", rol: document["rol"] as! String, id: userid)
                    print(snapshot.description)
                    completion(snapshot,nil)
                }
            }
        }
        }
    }
    
private func getActiveUserRol(id:String,completion: @escaping (DocumentSnapshot?,Error?)->Void){
    Firestore.firestore().collection("users").document(id).getDocument { snapshot, eror in
        if let eror = eror{
            completion(nil,eror)
        }else{
            completion(snapshot,nil)
        }
    }
}
        



