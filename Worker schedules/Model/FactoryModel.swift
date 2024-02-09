//
//  FactoryModel.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/18/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Factory {
    @Attribute(.unique) var factoryName: String
    @Relationship(deleteRule: .nullify, inverse: \Worker.factory)
    var workers = [Worker]()
    var color: String
    var isAuto = false
    var dayOnly = false
    
    init(factoryName: String, color: String) {
        self.factoryName = factoryName
        self.color = color
    }
    
    var hexColor: Color {
            Color(hex: self.color) ?? .gray
        }
}
