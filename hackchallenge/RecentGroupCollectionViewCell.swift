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
    var blueBackground: UIView!
    let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
    let accentColor: UIColor = UIColor(red: 42/255, green: 85/255, blue: 121/255, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = mainColor
        contentView.layer.cornerRadius = 10
        
        blueBackground = UIView()
        blueBackground.translatesAutoresizingMaskIntoConstraints = false
        blueBackground.backgroundColor = accentColor
        contentView.addSubview(blueBackground)
        
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
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            classImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            classImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            classImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            classImageView.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -5)
            ])
        
        NSLayoutConstraint.activate([
            blueBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            blueBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blueBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blueBackground.bottomAnchor.constraint(equalTo: classImageView.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            classNameLabel.topAnchor.constraint(equalTo: classImageView.bottomAnchor, constant: 5),
            classNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            classNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            ])
        
        NSLayoutConstraint.activate([
            groupNameLabel.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor),
            groupNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            groupNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            groupNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            ])
    }
    
    func configure(for group: Group) {
        if let image = group.relatedClass.imageName {
            classImageView.image = UIImage(named: image)
        }
        classNameLabel.text = group.relatedClass.subject + " " + String(group.relatedClass.number)
        groupNameLabel.text = group.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
