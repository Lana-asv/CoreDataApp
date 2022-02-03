//
//  StaffViewController.swift
//  CoreDataApp
//
//  Created by Sveta on 17.12.2021.
//

import UIKit

class StaffViewController: UIViewController {
    
    private let presenter: IStaffPresenter
    
    init(presenter: IStaffPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = 75
        tableView.register(StaffTableViewCell.self, forCellReuseIdentifier: StaffTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    

    override func loadView() {
        self.view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Staff"
        self.configurateNavigationBar()
        self.presenter.viewDidLoad(viewController: self)
    }
    
    func updateView() {
        self.tableView.reloadData()
    }
}

extension StaffViewController {
    private func configurateNavigationBar() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addStaffTapped))
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc func addStaffTapped() {
        self.presenter.createNewPeson()
    }
}

extension StaffViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.staffCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StaffTableViewCell.identifier, for: indexPath) as! StaffTableViewCell
        if let person = self.presenter.getPerson(at: indexPath.row) {
            cell.configure(with: person)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.updatePerson(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.presenter.removePerson(at: indexPath.row)
    }
}
