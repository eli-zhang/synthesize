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
    var messagesLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellLabel = UILabel()
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.textColor = Colors.mainColor
        cellLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        contentView.addSubview(cellLabel)
        
        messagesLabel = UILabel()
        messagesLabel.translatesAutoresizingMaskIntoConstraints = false
        messagesLabel.textColor = Colors.mainColor
        messagesLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        contentView.addSubview(messagesLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            messagesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            messagesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            messagesLabel.topAnchor.constraint(equalTo: cellLabel.bottomAnchor, constant: 10),
            messagesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
    }
    
    func configure(for group: Assignment) {
        cellLabel.text = group.name
        messagesLabel.text = "Total Messages: \(group.messages.count)"
    }
}
