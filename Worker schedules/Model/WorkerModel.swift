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
    var adress: Location
    var factory: Factory?
    var isDay: Bool
    var isTaping: Bool
    
    init(name: String, phone: String, adress: Location, isDay: Bool = true, isTaping: Bool = false) {
        self.name = name
        self.phone = phone
        self.adress = adress
        self.isDay = isDay
        self.isTaping = isTaping
    }
}

struct Location: Codable, Equatable, Identifiable, Hashable {
    let id: UUID
    var name: String = ""
    var latitude: Double
    var longitude: Double
}
