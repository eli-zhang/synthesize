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
    var searchBar: UISearchBar!
    
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
        //let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
        let group1 = Group(relatedClass: classForView, name: "Problem set 1")
        let group2 = Group(relatedClass: classForView, name: "Problem set 2")
        
        displayedGroups = [group1, group2]
        originalGroups = displayedGroups
        
        groupsTableView = UITableView()
        groupsTableView.translatesAutoresizingMaskIntoConstraints = false
        groupsTableView.register(GroupTableViewCell.self, forCellReuseIdentifier: reuse)
        groupsTableView.dataSource = self
        groupsTableView.delegate = self
        view.addSubview(groupsTableView)
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autocorrectionType = .no
        view.addSubview(searchBar)
        searchBar.placeholder = "Find a group"
        searchBar.delegate = self
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            groupsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            groupsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            groupsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            groupsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            ])
    }
    
}

extension ClassViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath) as! GroupTableViewCell
        let group = displayedGroups[indexPath.row]
        cell.configure(for: group)
        return cell
    }
    
}

extension ClassViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = displayedGroups[indexPath.row]
        let groupViewController = GroupViewController()
        groupViewController.title = "Groups - " + cell.relatedClass.getTitle()
        navigationController?.pushViewController(groupViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ClassViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        displayedGroups.removeAll()
        if searchBar.text == ""{
            for group in originalGroups {
                displayedGroups.append(group)
            }
        }
        else {
            for group in originalGroups {
                //if course.subjectnumber.contains(searchText.uppercased()) {
                if group.name.lowercased().contains(searchText.lowercased()) {
                    displayedGroups.append(group)
                }
            }
        }
        groupsTableView.reloadData()
    }
}
