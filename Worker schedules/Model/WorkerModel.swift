//
//  WorkerModel.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/18/24.
//

import Foundation
import SwiftData

@Model
class Worker {
    var name: String
    var phone: String
    var adress: String
    var factory: Factory?
    
    init(name: String, phone: String, adress: String) {
        self.name = name
        self.phone = phone
        self.adress = adress
    }
    
}

