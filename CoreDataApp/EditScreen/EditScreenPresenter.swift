//
//  EditScreenPresenter.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//

import Foundation

final class EditScreenPresenter {
    private weak var viewController: EditViewController?
    
    var onAddPersonAction: ((PersonInfo) -> Void)?
    let info: PersonInfo?
    
    init(info: PersonInfo?) {
        self.info = info
    }
}

extension EditScreenPresenter {
    func viewDidLoad(viewController: EditViewController) {
        self.viewController = viewController
    }
    
    func savePerson(with personInfo: PersonInfo) {
        self.onAddPersonAction?(personInfo)
        self.viewController?.navigationController?.dismiss(animated: true, completion: nil)
    }

    func close() {
        self.viewController?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
