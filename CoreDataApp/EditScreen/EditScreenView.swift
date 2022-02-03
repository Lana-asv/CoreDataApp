//
//  EditScreenView.swift
//  CoreDataApp
//
//  Created by Sveta on 20.12.2021.
//

import UIKit

struct PersonInfo {
    let name: String
    let age: String
    let experience: String?
}

final class EditScreenView: UIView {

    private let nameTextField = UITextField()
    private let ageTextField = UITextField()
    private let experienceTextField = UITextField()
    
    private enum Metrics {
        static let nameTextFieldFontSize: CGFloat = 15.0
        static let nameTextFieldTopConstr: CGFloat = 40.0
        static let nameTextFieldHeight: CGFloat = 40.0
        static let leadingConstr: CGFloat = 10.0
        static let trailingConstr: CGFloat = -10.0
        static let ageTextFieldTopConstr: CGFloat = 10.0
        static let ageTextFieldHeight: CGFloat = 40.0
        static let ageTextFieldFontSize: CGFloat = 15.0
        static let experienceTextFieldFontSize: CGFloat = 15.0
        static let experienceTextFieldTopConstr: CGFloat = 10.0
        static let experienceTextFieldHeight: CGFloat = 40.0
    }
    
    var model: PersonInfo? {
        get {
            guard let name = self.nameTextField.text,
                  let age = self.ageTextField.text else {
                return nil
            }
            return PersonInfo(name: name, age: age, experience: self.experienceTextField.text)
        }
        
        set {
            self.nameTextField.text = newValue?.name
            self.ageTextField.text = newValue?.age
            self.experienceTextField.text = newValue?.experience
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    
        self.addSubview(nameTextField)
        self.addSubview(ageTextField)
        self.addSubview(experienceTextField)
        
        self.nameTextFieldAppearence()
        self.ageTextFieldAppearance()
        self.experienceTextFieldAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EditScreenView {
    private func nameTextFieldAppearence() {
        self.nameTextField.placeholder = "Введите имя (обязательное поле)"
        self.nameTextField.backgroundColor = .secondarySystemBackground
        self.nameTextField.font = UIFont.systemFont(ofSize: Metrics.nameTextFieldFontSize)
        
        self.nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.nameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.nameTextFieldTopConstr),
            self.nameTextField.heightAnchor.constraint(equalToConstant: Metrics.nameTextFieldHeight),
            self.nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConstr),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConstr)
        ])
    }
    
    private func ageTextFieldAppearance() {
        self.ageTextField.placeholder = "Введите возраст сотрудника (обязательное поле)"
        self.ageTextField.backgroundColor = .secondarySystemBackground
        self.ageTextField.font = UIFont.systemFont(ofSize: Metrics.ageTextFieldFontSize)
        
        self.ageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.ageTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: Metrics.ageTextFieldTopConstr),
            self.ageTextField.heightAnchor.constraint(equalToConstant: Metrics.ageTextFieldHeight),
            self.ageTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConstr),
            self.ageTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConstr)
        ])
    }
    
    private func experienceTextFieldAppearance() {
        self.experienceTextField.placeholder = "Введите стаж сотрудника (обязательное поле)"
        self.experienceTextField.backgroundColor = .secondarySystemBackground
        self.experienceTextField.font = UIFont.systemFont(ofSize: Metrics.experienceTextFieldFontSize)
        
        self.experienceTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.experienceTextField.topAnchor.constraint(equalTo: self.ageTextField.bottomAnchor, constant: Metrics.experienceTextFieldTopConstr),
            self.experienceTextField.heightAnchor.constraint(equalToConstant: Metrics.experienceTextFieldHeight),
            self.experienceTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConstr),
            self.experienceTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConstr)
        ])
    }
}
