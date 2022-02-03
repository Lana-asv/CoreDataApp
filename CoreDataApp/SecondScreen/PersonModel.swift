//
//  PersonModel.swift
//  CoreDataApp
//
//  Created by Sveta on 17.12.2021.
//

import Foundation

struct PersonModel {
    let uid: UUID
    let name: String
    let age: String
    let experience: String?
    let date: Date
    let companyUID: UUID
    
    init(companyUID: UUID, name: String, age: String, experience: String?) {
        self.companyUID = companyUID
        self.uid = UUID()
        self.date = Date()
        self.name = name
        self.age = age
        self.experience = experience
    }
    
    init(companyUID: UUID, uid: UUID, date: Date, name: String, age: String, experience: String?) {
        self.companyUID = companyUID
        self.uid = uid
        self.date = date
        self.name = name
        self.age = age
        self.experience = experience
    }
    
    func createPerson(with info: PersonInfo) -> PersonModel {
        return PersonModel(companyUID: self.companyUID, uid: self.uid, date: self.date, name: info.name, age: info.age, experience: info.experience)
    }
}


extension PersonModel {
    init(person: Person) {
        self.uid = person.uid
        self.name = person.name
        self.age = person.age
        self.experience = person.experince
        self.date = person.date
        self.companyUID = person.company.uid
    }
}

