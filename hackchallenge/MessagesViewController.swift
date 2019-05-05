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

    var messages: [Message]!
    var assignmentInfo: Assignment!
    var timer: Timer!
    weak var delegate: ClassViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Messages - \(assignmentInfo.name)"
        
        let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateMessages), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    @objc func updateMessages() {
        NetworkManager.getMessagesFromAssignment(classId: assignmentInfo.class_id, assignmentId: assignmentInfo.id, completion: { messages in
            self.messages = messages
            DispatchQueue.main.async {
                print(self.messages)
                // Reload table data
                // Scroll to bottom
            }
        })
    }
    
    func addAssignmentInfo(assignment: Assignment) {
        self.assignmentInfo = assignment
    }
}
