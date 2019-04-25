//
//  ClassTableViewCell.swift
//  homeworkapp
//
//  Created by Victor Chen on 4/21/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import UIKit

class ClassTableViewCell: UITableViewCell {
    
    var cellLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellLabel = UILabel()
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cellLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    func configure(for course: Class) {
        cellLabel.text = course.subjectnumber
    }
}
