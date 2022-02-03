//
//  CompanyItem.swift
//  CoreDataApp
//
//  Created by Sveta on 17.12.2021.
//

import Foundation

struct CompanyItem {
    let uid: UUID
    var name: String
    let date: Date
    
    init(name: String) {
        self.uid = UUID()
        self.name = name
        self.date = Date()
    }
}

extension CompanyItem {
    init(company: Company) {
        self.uid = company.uid
        self.name = company.name
        self.date = company.date
    }
}
