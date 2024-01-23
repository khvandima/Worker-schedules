//
//  FactoryModel.swift
//  Worker schedules
//
//  Created by KHVAN DMITRIY on 1/18/24.
//

import Foundation
import SwiftData

@Model
class Factory {
    @Attribute(.unique) var factoryName: String
    @Relationship(deleteRule: .nullify, inverse: \Worker.factory)
    var workers = [Worker]()
    
    init(factoryName: String) {
        self.factoryName = factoryName
    }
}
