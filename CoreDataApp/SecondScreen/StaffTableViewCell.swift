//
//  StaffTableViewCell.swift
//  CoreDataApp
//
//  Created by Sveta on 17.12.2021.
//

import UIKit

class StaffTableViewCell: UITableViewCell {
    static let identifier = "StaffTableViewCell"
    
    let nameLabel = UILabel()
    let ageLabel = UILabel()
    let experienceLabel = UILabel()
    private let stack = UIStackView()
    
    private enum Metrics {
        static let nameLabelFontSize: CGFloat = 17.0
        static let ageLabelFontSize: CGFloat = 16.0
        static let experienceLabelFontSize: CGFloat = 14.0
        static let stackSpacing: CGFloat = 3.0
        static let leadingConstr: CGFloat = 10.0
        static let trailingConstr: CGFloat = -10.0
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(stack)

        self.initialSetup()
        self.stackSetup()
        self.stackSetupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialSetup() {
        self.nameLabel.font = UIFont.systemFont(ofSize: Metrics.nameLabelFontSize, weight: .semibold)
        self.nameLabel.textAlignment = .left
        self.ageLabel.font = UIFont.systemFont(ofSize: Metrics.ageLabelFontSize)
        self.experienceLabel.font = UIFont.systemFont(ofSize: Metrics.experienceLabelFontSize)
    }
    
    private func stackSetup() {
        self.stack.axis = .vertical
        self.stack.spacing = Metrics.stackSpacing
        self.stack.alignment = .leading
        
        self.stack.addArrangedSubview(nameLabel)
        self.stack.addArrangedSubview(ageLabel)
        self.stack.addArrangedSubview(experienceLabel)
    }

    private func stackSetupLayout() {
        self.stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConstr),
            self.stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConstr)
        ])
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.ageLabel.text = nil
        self.experienceLabel.text = nil
    }
}

extension StaffTableViewCell {
    func configure(with person: PersonModel) {
        self.nameLabel.text = person.name
        self.ageLabel.text = person.age
        self.experienceLabel.text = person.experience
    }
}
