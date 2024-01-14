//
//  Data.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 7.01.2024.
//

import Foundation
import CoreData
import UIKit

class DataUse{
    
    func uploadData(bankGram:Float){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let calcule = NSEntityDescription.insertNewObject(forEntityName: "Bank", into: context)
        
        calcule.setValue(UUID(), forKey: "id")
        calcule.setValue(FloatExt.yuvarla(say: bankGram), forKey: "bankGram")
        calcule.setValue(Date(), forKey: "date")
        do{
            try context.save()
            print("added")
        }catch{
            print("eror")
        }
    }
    
    func downloadDataFloat() -> [Float]{
        var grams : [Float] = [Float]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchr = NSFetchRequest<NSFetchRequestResult>(entityName: "Bank")
        fetchr.returnsObjectsAsFaults = false
        
        do{
            let fet = try context.fetch(fetchr)
            for a in fet as! [NSManagedObject] {
                grams.append(a.value(forKey: "bankGram") as! Float)
              }
        }catch{
            print("eror")
        }
        return grams
    }
    
    func downloadData() -> [myProcessor]{
        var grams : [myProcessor] = [myProcessor]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchr = NSFetchRequest<NSFetchRequestResult>(entityName: "Bank")
        fetchr.returnsObjectsAsFaults = false
        
        do{
            let fet = try context.fetch(fetchr)
            for a in fet as! [NSManagedObject] {
                let item = myProcessor(processor: Processor(bankGram: a.value(forKey: "bankGram") as! Float, id: a.value(forKey: "id") as? UUID, date: a.value(forKey: "date") as? Date), obje: a)
                grams.append(item)
              }
        }catch{
            print("eror")
        }
        return grams
    }
    
    func deleteData(process:myProcessor){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do{
            context.delete(process.obje)
            try context.save()
        }catch{
            print("eror")
        }
        
        
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchr = NSFetchRequest<NSFetchRequestResult>(entityName: "Bank")
//        fetchr.returnsObjectsAsFaults = false
//        
//        do{
//            let fet = try context.fetch(fetchr)
//            for a in fet as! [NSManagedObject] {
//                if a.value(forKey: "id")! as! UUID == process.id!{
//                    do{
//                        print("delte")
//                        context.delete(a)
//                        try context.save()
//                    }catch{
//                        print("eror")
//                    }
//                }else{
//                    print("yok")
//                }
//              }
//        }catch{
//            print("eror")
//        }
    }
    
    func updateData(process:myProcessor, newGram:Float){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do{
            process.obje.setValue(newGram, forKey: "bankGram")
            try context.save()
        }catch{
            print("eror")
        }
    }
    
    
    
}
