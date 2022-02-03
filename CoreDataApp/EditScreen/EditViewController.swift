//
//  EditViewController.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//

import UIKit

final class EditViewController: UIViewController {
    private var editView: EditScreenView?
    private let presenter: EditScreenPresenter
    
    init(presenter: EditScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar()
        let editView = EditScreenView()
        self.editView = editView
        
        self.view.addSubview(editView)

        editView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editView.topAnchor.constraint(equalTo: self.view.topAnchor),
            editView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            editView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            editView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        self.presenter.viewDidLoad(viewController: self)
        editView.model = self.presenter.info
    }
}

extension EditViewController {
    private func configureNavBar() {
        self.title = "Данные сотрудника"
        let rightBarItem = UIBarButtonItem(title: "Готово" , style: .done, target: self, action: #selector(saveTapped))
        let leftBarItem = UIBarButtonItem(title: "Отменить" , style: .plain, target: self, action: #selector(closeTapped))
        self.navigationController?.navigationBar.barTintColor = .secondarySystemBackground
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItem = rightBarItem
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc private func saveTapped() {
        guard let model = self.editView?.model else {
            return
        }
        
        self.presenter.savePerson(with: model)
    }
    
    @objc private func closeTapped() {
        self.presenter.close()
    }
}

