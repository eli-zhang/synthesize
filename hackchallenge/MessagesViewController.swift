//
//  MessagesViewController.swift
//  hackchallenge
//
//  Created by Eli Zhang on 5/1/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

protocol AssignmentInfo {
    func addAssignmentInfo(assignment: Assignment)
}

class MessagesViewController: UIViewController, AssignmentInfo {

    var messagesCollectionView: UICollectionView!
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    let reuseIdentifier = "reuse"
    
    var messages: [Message]!
    var assignmentInfo: Assignment!
    var timer: Timer!
    weak var delegate: ClassViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Messages - \(assignmentInfo.name)"
        
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = Colors.mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        messagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        messagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        messagesCollectionView.backgroundColor = .white
        messagesCollectionView.dataSource = self
        messagesCollectionView.delegate = self
        messagesCollectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(messagesCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            messagesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messagesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messagesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            messagesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateMessages), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    @objc func updateMessages() {
        NetworkManager.getMessagesFromAssignment(classId: assignmentInfo.class_id, assignmentId: assignmentInfo.id, completion: { messages in
            self.messages = messages})
        DispatchQueue.main.async {
            print(self.messages)
            // Reload table data
            self.messagesCollectionView.reloadData()
            // Scroll to bottom???
        }
    }
    
    func addAssignmentInfo(assignment: Assignment) {
        self.assignmentInfo = assignment
    }
}

extension MessagesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.configure(for: messages[indexPath.item])
        return cell
    }
}

extension MessagesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
