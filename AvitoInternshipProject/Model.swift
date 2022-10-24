//
//  Model.swift
//  AvitoInternshipProject
//
//  Created by Mila B on 19.10.2022.
//

import Foundation

public final class MyModel {
    let modelObj: Model
    let expirationDate: Date
    
    init(Model: Model, expirationDate: Date) {
        self.modelObj = Model
        self.expirationDate = expirationDate
    }
}

public struct Model: Codable {
    let company: Company
}

struct Company: Codable {
    let name: String?
    let employees: [Employee]?
}

struct Employee: Codable {
    let name: String?
    let phone_number: String?
    let skills: [String]?
}

