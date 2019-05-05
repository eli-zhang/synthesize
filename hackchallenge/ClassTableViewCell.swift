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
    var cellImageView: UIImageView!
    var courseNameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cellLabel = UILabel()
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.textColor = Colors.mainColor
        cellLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        contentView.addSubview(cellLabel)
        
        cellImageView = UIImageView()
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleAspectFit
        cellImageView.clipsToBounds = true
        contentView.addSubview(cellImageView)
        
        courseNameLabel = UILabel()
        courseNameLabel.translatesAutoresizingMaskIntoConstraints = false
        courseNameLabel.textColor = Colors.mainColor
        courseNameLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(courseNameLabel)
        
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
        
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        NSLayoutConstraint.activate([
            courseNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 140),
            courseNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            courseNameLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            courseNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    func configure(for course: Class) {
        cellLabel.text = course.getTitle()
        cellImageView.image = UIImage(named: course.getImageName())
        courseNameLabel.text = course.name
    }
}
