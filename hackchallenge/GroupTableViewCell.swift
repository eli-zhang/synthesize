//
//  GroupTableViewCell.swift
//  hackchallenge
//
//  Created by Michael Behrens on 4/27/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    var cellLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellLabel = UILabel()
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.textColor = Colors.mainColor
        cellLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        contentView.addSubview(cellLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 140),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
    
    func configure(for group: Assignment) {
        cellLabel.text = group.name
    }
    
    func configure(for group: Group) {
        cellLabel.text = group.name
    }
}
