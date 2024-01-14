//
//  extFloat.swift
//  MachineCalculate
//
//  Created by Alihan Hoylu on 9.01.2024.
//

import Foundation

class FloatExt{
    static func yuvarla(say:Float) -> Float{
        var a = say
        a = say*10000
        a.round(.toNearestOrAwayFromZero)
        return a/10000
    }
}
