//
//  StaffPresenter.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//

import Foundation

protocol IStaffPresenter {
    func viewDidLoad(viewController: StaffViewController)
    func staffCount() -> Int
    func createNewPeson()
    func updatePerson(at index: Int)
    func removePerson(at index: Int)
    func getPerson(at index: Int) -> PersonModel?
}

final class StaffPresenter {
    
    private weak var viewController: StaffViewController?
    private let persistenceManager: IPersonStorage
    private let company: CompanyItem
    
    var onOpenEditPersonController: (( PersonInfo?, @escaping (PersonInfo) -> Void ) -> (Void))?
    
    init(persistenceManager: IPersonStorage, company: CompanyItem) {
        self.persistenceManager = persistenceManager
        self.company = company
    }
}

extension StaffPresenter: IStaffPresenter {
    func viewDidLoad(viewController: StaffViewController) {
        self.viewController = viewController
    }
    
    func staffCount() -> Int {
        return persistenceManager.getStaffCount(with: company.uid)
    }

    func createNewPeson() {
        let completion: (PersonInfo) -> Void = { [weak self] personInfo in
            self?.createNewPeson(personInfo)
        }
        
        self.onOpenEditPersonController?(nil, completion)
    }
    
    private func createNewPeson(_ personInfo: PersonInfo) {
        let person = PersonModel(companyUID: company.uid, name: personInfo.name, age: personInfo.age, experience: personInfo.experience)
        self.persistenceManager.createPerson(person)
        self.viewController?.updateView()
    }
        
    func updatePerson(at index: Int) {
        guard let person = self.persistenceManager.getPerson(at: index, companyUID: company.uid) else {
            return
        }

        let completion: (PersonInfo) -> Void = { [weak self] personInfo in
            self?.updatePerson(person, info: personInfo)
        }

        let info = PersonInfo(name: person.name, age: person.age, experience: person.experience)
        self.onOpenEditPersonController?(info, completion)
    }
    
    private func updatePerson(_ person: PersonModel, info: PersonInfo) {
        let update = person.createPerson(with: info)
        self.persistenceManager.updatePerson(update)
        self.viewController?.updateView()
    }
    
    func removePerson(at index: Int) {
        self.persistenceManager.removePerson(at: index, companyUID: company.uid)
        self.viewController?.updateView()
    }
    
    func getPerson(at index: Int) -> PersonModel? {
        return self.persistenceManager.getPerson(at: index, companyUID: company.uid)
    }
}
