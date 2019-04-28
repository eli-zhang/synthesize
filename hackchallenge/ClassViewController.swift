//
//  ClassViewController.swift
//  homeworkapp
//
//  Created by Michael Behrens on 4/23/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController {
    
    var viewTitle: String!
    
    var groupsTableView: UITableView!
    var classForView: Class!
    var originalGroups: [Group]!
    var displayedGroups: [Group]!
    
    let reuse = "groupReuse"
    
    init(relatedClass: Class) {
        classForView = relatedClass
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
        
        
    }
    
}
