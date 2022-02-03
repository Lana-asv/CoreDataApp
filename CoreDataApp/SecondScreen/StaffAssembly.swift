//
//  StaffAssembly.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//

import Foundation
import UIKit

final class StaffAssembly {
    static func build(persistanceManager: PersistenceManager, company: CompanyItem) -> UIViewController {
        let router = Router()

        let presenter = StaffPresenter(persistenceManager: persistanceManager, company: company)
        presenter.onOpenEditPersonController = { info, action in
            let targetController = EditScreenAssembly.build(info: info, addPersonAction: action)
            router.setTargetController(controller: targetController)
            router.presentNext()
        }

        let controller = StaffViewController(presenter: presenter)
        router.setRootController(controller: controller)
        return controller
    }
}
