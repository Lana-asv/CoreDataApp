//
//  PersistenceManager.swift
//  CoreDataApp
//
//  Created by Sveta on 17.12.2021.
//

import Foundation
import CoreData

protocol ICompanyStorage {
    func getCompaniesCount() -> Int
    func getCompany(at index: Int) -> CompanyItem?

    func createCompany(_ item: CompanyItem)
    func updateCompany(_ item: CompanyItem)
    func removeCompany(at index: Int)
}

protocol IPersonStorage {
    func getStaffCount(with companyUID: UUID) -> Int
    func getPerson(at index: Int, companyUID: UUID) -> PersonModel?

    func createPerson(_ item: PersonModel)
    func updatePerson(_ item: PersonModel)
    func removePerson(at index: Int, companyUID: UUID)
}


final class PersistenceManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension PersistenceManager: ICompanyStorage {
    
    func createCompany(_ item: CompanyItem) {
        let newCompany = Company(context: context)
        newCompany.name = item.name
        newCompany.uid = item.uid
        newCompany.date = item.date
        do {
            try context.save()
        } catch let error as NSError {
            fatalError("could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getCompaniesCount() -> Int {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.includesSubentities = false
        guard let count = try? context.count(for: fetchRequest) else {
            return 0
        }
        
        return count
    }
    
    func getCompany(at index: Int) -> CompanyItem? {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        fetchRequest.fetchOffset = index
        fetchRequest.fetchLimit = 1
        
        guard let company = try? context.fetch(fetchRequest).first else {
            return nil
        }
        
        return CompanyItem(company: company)
    }

    func updateCompany(_ item: CompanyItem) {
        let fetchRequest = companyFetchRequest(item.uid)
        if let itemToUpdate = try? context.fetch(fetchRequest).first {
            itemToUpdate.name = item.name
        }
        try? context.save()
    }

    func removeCompany(at index: Int) {
        guard let company = self.getCompany(at: index) else {
            return
        }
        
        removeCompany(company: company)
    }

    private func removeCompany(company: CompanyItem) {
        let fetchRequest = companyFetchRequest(company.uid)
        if let itemToDelete = try? context.fetch(fetchRequest).first {
            let itemsToDelete = getStaff(with: itemToDelete.uid)
            itemsToDelete?.forEach({ context.delete($0) })
            context.delete(itemToDelete)
        }
        
        try? context.save()
    }
    
    private func companyFetchRequest(_ uid: UUID) -> NSFetchRequest<Company> {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Company.uid)) = '\(uid)'")
        return fetchRequest
    }
}

extension PersistenceManager: IPersonStorage {
    
    func createPerson(_ item: PersonModel) {
        guard let company = getCompany(with: item.companyUID) else {
            return
        }

        let newPerson = Person(context: context)
        newPerson.uid = item.uid
        newPerson.date = item.date
        newPerson.name = item.name
        newPerson.age = item.age
        newPerson.experince = item.experience
        newPerson.company = company
        try? context.save()
    }
    
    private func getCompany(with uid: UUID) -> Company? {
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Company.uid)) = '\(uid)'")
        return try? context.fetch(fetchRequest).first
    }
    
    func getStaffCount(with companyUID: UUID) -> Int {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ANY company.uid = '\(companyUID)'")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        fetchRequest.includesSubentities = false
        guard let count = try? context.count(for: fetchRequest) else {
            return 0
        }
        
        return count
    }
    
    private func getStaff(with companyUID: UUID) -> [Person]? {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ANY company.uid = '\(companyUID)'")
        fetchRequest.includesSubentities = false
        return try? context.fetch(fetchRequest)
    }

    func getPerson(at index: Int, companyUID: UUID) -> PersonModel? {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ANY company.uid = '\(companyUID)'")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        fetchRequest.fetchOffset = index
        fetchRequest.fetchLimit = 1
        
        guard let person = try? context.fetch(fetchRequest).first else {
            return nil
        }
        
        return PersonModel(person: person)
    }

    func updatePerson(_ item: PersonModel) {
        let fetchRequest = personFetchRequest(item.uid)
        if let itemToUpdate = try? context.fetch(fetchRequest).first {
            itemToUpdate.name = item.name
            itemToUpdate.age = item.age
            itemToUpdate.experince = item.experience

        }
        try? context.save()
    }

    func removePerson(at index: Int, companyUID: UUID) {
        guard let person = self.getPerson(at: index, companyUID: companyUID) else {
            return
        }
        
        removePerson(person: person)
    }

    private func removePerson(person: PersonModel) {
        let fetchRequest = personFetchRequest(person.uid)
        if let itemToDelete = try? context.fetch(fetchRequest).first {
            context.delete(itemToDelete)
        }
        try? context.save()
    }
    
    private func personFetchRequest(_ uid: UUID) -> NSFetchRequest<Person> {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Person.uid)) = '\(uid)'")
        return fetchRequest
    }
}
