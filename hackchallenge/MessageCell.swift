//
//  MessageCell.swift
//  hackchallenge
//
//  Created by Victor Chen on 5/5/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//
import UIKit

class MessageCell: UICollectionViewCell {
    var messageTextView: UITextView!
    var messageBubbleView: UIView!
    var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        nameLabel.alpha = 0.0
        
        messageTextView = UITextView(frame: .zero)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.font = UIFont.systemFont(ofSize: 18)
        messageTextView.isEditable = false
        messageTextView.backgroundColor = .clear
        
        messageBubbleView = UIView()
        messageBubbleView.layer.cornerRadius = 15
        messageBubbleView.layer.masksToBounds = true
        contentView.addSubview(messageBubbleView)
        contentView.addSubview(messageTextView)
        contentView.addSubview(nameLabel)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: messageBubbleView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: messageBubbleView.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalTo: messageBubbleView.widthAnchor, constant: -10)])
        super.updateConstraints()
    }
    
    func configure(for message: Message) {
        messageTextView.text = message.message
        nameLabel.text = "user: \(message.name)"
        if message.username == UserDefaults.standard.string(forKey: "username") {
            nameLabel.textColor = .white
            messageBubbleView.backgroundColor = Colors.mainColor
            messageTextView.textColor = .white
        } else {
            nameLabel.textColor = Colors.mainColor
            messageBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            messageTextView.textColor = .black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
