//
//  CompanyViewController.swift
//  CoreDataApp
//
//  Created by Sveta on 17.12.2021.
//

import UIKit
import CoreData

final class CompanyViewController: UIViewController {
    private let presenter: ICompanyPresenter
    private var editMode: Bool = false
    
    init(presenter: ICompanyPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    let context = PersistenceManager.shared.contex
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = 50
        tableView.register(CompanyTableViewCell.self, forCellReuseIdentifier: CompanyTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var companyList = [Company]()

    override func loadView() {
        self.view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Company"
        self.configureNavigationBar()
        self.presenter.viewDidLoad(viewController: self)
        
        tableView.allowsMultipleSelectionDuringEditing = true
    
    }
}

extension CompanyViewController {
    private func configureNavigationBar() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addBarButton
        
        let editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        self.navigationItem.leftBarButtonItem = editBarButton
    }
    
    @objc func addTapped() {
        let alert = UIAlertController(title: "Новая компания",
                                      message: "Введите название компании",
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            guard let textField = alert.textFields?.first, let text = textField.text, !text.isEmpty else { return }
            self?.presenter.createNewCompany(with: text)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func editTapped() {
        self.editMode.toggle()
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        self.navigationItem.leftBarButtonItem = doneBarButton
    }
    
    @objc func doneTapped() {
        self.editMode.toggle()
        let editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        self.navigationItem.leftBarButtonItem = editBarButton
    }
    
    func updateView() {
        self.tableView.reloadData()
    }
}

extension CompanyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.companiesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.identifier, for: indexPath) as! CompanyTableViewCell
        if let company = self.presenter.getCompany(at: indexPath.row) {
            cell.configure(with: company)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if (self.editMode) {
            self.editCompany(at: indexPath.row)
            return
        }
        
        self.presenter.openStaffController(at: indexPath.row)
    }
    
    private func editCompany(at index: Int) {
        guard var company = self.presenter.getCompany(at: index) else {
            return
        }
        
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.text = company.name
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else { return }
            company.name = newName
            self?.presenter.updateCompany(company)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.presenter.removeCompany(at: indexPath.row)
    }
}
