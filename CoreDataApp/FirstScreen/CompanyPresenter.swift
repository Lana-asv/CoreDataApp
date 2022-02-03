//
//  CompanyPresenter.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//

import Foundation

protocol ICompanyPresenter {
    func viewDidLoad(viewController: CompanyViewController)
    func companiesCount() -> Int
    func createNewCompany(with companyName: String)
    func updateCompany(_ company: CompanyItem)
    func removeCompany(at index: Int)
    func getCompany(at index: Int) -> CompanyItem?
    func openStaffController(at index: Int)
}

final class CompanyPresenter {
    private weak var viewController: CompanyViewController?
    private let persistenceManager: ICompanyStorage
    
    var onOpenStaffController: ((Int) -> (Void))?
    
    init(persistenceManager: ICompanyStorage) {
        self.persistenceManager = persistenceManager
    }
}

extension CompanyPresenter {
    func viewDidLoad(viewController: CompanyViewController) {
        self.viewController = viewController
    }
}

extension CompanyPresenter: ICompanyPresenter {
    func companiesCount() -> Int {
        return persistenceManager.getCompaniesCount()
    }
    
    func createNewCompany(with name: String) {
        let company = CompanyItem(name: name)
        self.persistenceManager.createCompany(company)
        self.viewController?.updateView()
    }
    
    func updateCompany(_ company: CompanyItem) {
        self.persistenceManager.updateCompany(company)
        self.viewController?.updateView()
    }
    
    func removeCompany(at index: Int) {
        self.persistenceManager.removeCompany(at: index)
        self.viewController?.updateView()
    }
    
    func getCompany(at index: Int) -> CompanyItem? {
        return self.persistenceManager.getCompany(at: index)
    }
    
    func openStaffController(at index: Int) {
        self.onOpenStaffController?(index)
    }
}
