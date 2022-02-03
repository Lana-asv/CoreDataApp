//
//  EditScreenAssembly.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//

import UIKit

final class EditScreenAssembly {
    static func build(info: PersonInfo?, addPersonAction: @escaping (PersonInfo) -> Void) -> UIViewController {
        let presenter = EditScreenPresenter(info: info)
        presenter.onAddPersonAction = addPersonAction
        let controller = EditViewController(presenter: presenter)
        return UINavigationController(rootViewController: controller)
    }
}
