//
//  Processor.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 8.01.2024.
//

import Foundation
import CoreData

struct Processor{
    var bankGram: Float = 0
    var id: UUID?
    var date: Date?
}

struct myProcessor{
    var processor:Processor
    var obje:NSManagedObject
}
