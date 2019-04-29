//
//  RecentGroupCollectionViewCell.swift
//  homeworkapp
//
//  Created by Michael Behrens on 4/23/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

class RecentGroupCollectionViewCell: UICollectionViewCell {
    
    var classImageView: UIImageView!
    var classNameLabel: UILabel!
    var groupNameLabel: UILabel!
    let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = mainColor
        contentView.layer.cornerRadius = 10
        
        classImageView = UIImageView()
        classImageView.translatesAutoresizingMaskIntoConstraints = false
        classImageView.contentMode = .scaleAspectFit
        classImageView.clipsToBounds = true
        classImageView.layer.cornerRadius = 10
        contentView.addSubview(classImageView)
        
        classNameLabel = UILabel()
        classNameLabel.translatesAutoresizingMaskIntoConstraints = false
        classNameLabel.textColor = .white
        classNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        contentView.addSubview(classNameLabel)
        
        groupNameLabel = UILabel()
        groupNameLabel.translatesAutoresizingMaskIntoConstraints = false
        groupNameLabel.textColor = .white
        groupNameLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(groupNameLabel)
        
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            classImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            classImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            classImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            classImageView.bottomAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            classNameLabel.topAnchor.constraint(equalTo: classImageView.bottomAnchor),
            classNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            classNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            classNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25)
            ])
        
        NSLayoutConstraint.activate([
            groupNameLabel.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor),
            groupNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            groupNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            groupNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    func configure(for group: Group) {
        let image = group.relatedClass.getImageName()
        classImageView.image = UIImage(named: image)
        classNameLabel.text = group.relatedClass.subject + " " + String(group.relatedClass.number)
        groupNameLabel.text = group.name
    }
    
    func configure(for course: Class) {
        let image = course.getImageName()
        classImageView.image = UIImage(named: image)
        classNameLabel.text = course.getTitle()
        groupNameLabel.text = nil
    }
}
