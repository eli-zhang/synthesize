//
//  MessageCell.swift
//  hackchallenge
//
//  Created by Victor Chen on 5/5/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    var messageTextView: UITextView
    
    override init(frame: CGRect) {
        messageTextView = UITextView(frame: .zero)
        super.init(frame: .zero)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.font = UIFont.systemFont(ofSize: 16)
        messageTextView.isEditable = false
        messageTextView.backgroundColor = .lightGray
        messageTextView.textColor = .black
        contentView.addSubview(messageTextView)
        
        setupConstraints()
    }
    
    func configure(for message: Message) {
        messageTextView.text = message.message
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
                messageTextView.topAnchor.constraint(equalTo: contentView.topAnchor),
                messageTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                messageTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                messageTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
