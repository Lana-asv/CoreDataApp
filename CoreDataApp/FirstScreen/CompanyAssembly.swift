//
//  CompanyAssembly.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//

import UIKit

final class CompanyAssembly {
    func build() -> UIViewController {
        let router = Router()
        let persistanceManager = PersistenceManager()
        let presenter = CompanyPresenter(persistenceManager: persistanceManager)
        presenter.onOpenStaffController = { index in
            guard let company = persistanceManager.getCompany(at: index) else {
                return
            }

            let targetController = StaffAssembly.build(persistanceManager: persistanceManager, company: company)
            router.setTargetController(controller: targetController)
            router.next()
        }
        
        let controller = CompanyViewController(presenter: presenter)
        router.setRootController(controller: controller)
        return controller
    }
}
