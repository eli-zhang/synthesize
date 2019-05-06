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
    
    var messageInputContainerView: UIView!
    var inputTextField: UITextField!
    var sendButton: UIButton!
    
    var assignmentInfo: Assignment!
    var timer: Timer!
    weak var delegate: ClassViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        title = "Messages - \(assignmentInfo.name)"
        
        tabBarController?.tabBar.isHidden = true
        
        let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        messageInputContainerView = UIView()
        messageInputContainerView.translatesAutoresizingMaskIntoConstraints = false
        messageInputContainerView.backgroundColor = .white
        view.addSubview(messageInputContainerView)
        
        messagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        messagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        messagesCollectionView.backgroundColor = .white
        messagesCollectionView.dataSource = self
        messagesCollectionView.delegate = self
        messagesCollectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(messagesCollectionView)
        
        setupConstraints()
        setupInputComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: ViewController.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: ViewController.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardFrame.height
        }
    }
    
    func setupInputComponents(){
        inputTextField = UITextField()
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.placeholder = "Enter message..."
        messageInputContainerView.addSubview(inputTextField)
        
        sendButton = UIButton(type: .system)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", for: .normal)
        let sendColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha:  1)
        sendButton.setTitleColor(sendColor, for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        sendButton.showsTouchWhenHighlighted = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(sendButtonTapped))
        sendButton.addGestureRecognizer(tap)
        
        messageInputContainerView.addSubview(sendButton)
        
        setupConstraints2()
    }
    
    @objc func sendButtonTapped(){
        NetworkManager.addMessageToAssignment(classId: assignmentInfo.class_id, assignmentId: assignmentInfo.id, message: inputTextField.text ?? "", username: "yo", user: "me", time: getTime(),
                completion: { message in
                    self.updateMessages()
                })
        inputTextField.text = ""
    }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    func setupConstraints2(){
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
            sendButton.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            sendButton.rightAnchor.constraint(equalTo: messageInputContainerView.rightAnchor, constant: -10),
            
            inputTextField.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor),
            inputTextField.leftAnchor.constraint(equalTo: messageInputContainerView.leftAnchor, constant: 15),
            inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -5),
            ])
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            messageInputContainerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            messageInputContainerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageInputContainerView.heightAnchor.constraint(equalToConstant: 48),
            
            messagesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messagesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            messagesCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            messagesCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateMessages), userInfo: nil, repeats: true)
        updateMessages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    @objc func updateMessages() {
        NetworkManager.getMessagesFromAssignment(classId: assignmentInfo.class_id, assignmentId: assignmentInfo.id, completion: { messages in
            self.messages = messages
            DispatchQueue.main.async {
                self.messagesCollectionView.reloadData()
            }
        })
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
        
        if let messageText = messages?[indexPath.item].message {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame =  NSString(string: messageText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            cell.messageTextView.frame = CGRect(x: 8+20, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
            cell.messageBubbleView.frame = CGRect(x: 0+20 , y: 0, width: estimatedFrame.width  + 16 + 8, height: estimatedFrame.height + 20)
        }
        
        return cell
    }
}

extension MessagesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let messageText = messages?[indexPath.item].message {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame =  NSString(string: messageText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
        }
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
