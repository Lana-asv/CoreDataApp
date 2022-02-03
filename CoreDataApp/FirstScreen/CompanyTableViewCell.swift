//
//  CompanyTableViewCell.swift
//  CoreDataApp
//
//  Created by Sveta on 17.12.2021.
//

import UIKit

final class CompanyTableViewCell: UITableViewCell {
    static let identifier = "CompanyTableViewCell"
    
    private let nameLabel = UILabel()
    
    private enum Metrics {
        static let leadingConstr: CGFloat = 10.0
        static let trailingConstr: CGFloat = -10.0
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(nameLabel)

        self.initialSetup()
        self.nameLabelSetupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialSetup() {
        self.nameLabel.textAlignment = .left
    }

    private func nameLabelSetupLayout() {
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConstr),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConstr)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
    }
}

extension CompanyTableViewCell {
    func configure(with company: CompanyItem) {
        self.nameLabel.text = company.name
    }
}
