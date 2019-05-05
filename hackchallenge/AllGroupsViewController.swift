//
//  AllGroupsViewController.swift
//  hackchallenge
//
//  Created by Michael Behrens on 4/25/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    var searchBar: UISearchBar!
    var groupsTableView: UITableView!
    
    var initialRecentGroups: [Group]!
    var displayedGroups: [Group]!
    
    let reuseIdentifier = "reuse"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Groups"
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = Colors.mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        
        // Do any additional setup after loading the view.
        
        displayedGroups = []
        initialRecentGroups = displayedGroups
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autocorrectionType = .no
        view.addSubview(searchBar)
        searchBar.placeholder = "Search my groups"
        searchBar.delegate = self
        
        groupsTableView = UITableView()
        groupsTableView.translatesAutoresizingMaskIntoConstraints = false
        groupsTableView.register(GroupTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        groupsTableView.dataSource = self
        groupsTableView.delegate = self
        view.addSubview(groupsTableView)
        
        
        setupConstraints()
        getGroups()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            groupsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            groupsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            groupsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            groupsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
    }
    
    func getGroups() {
        let cs3410 = Class(id: 0, subject: "CS", number: 3410, name: "Computer System Organization and Programming")
        let cs2300 = Class(id: 1, subject: "CS", number: 2300, name: "Intermediate Web Design and Programming")
        let orie3120 = Class(id: 2, subject: "ORIE", number: 3120, name: "Practical Tools for OR and Machine Learning")
        let math2930 = Class(id: 3, subject: "MATH", number: 2930, name: "Differential Equations")
        let music1312 = Class(id: 4, subject: "MUSIC", number: 1312, name: "History of Rock Music")
        let hadm1111 = Class(id: 5, subject: "HADM", number: 1111, name: "Hotel Class")
        let ilr2100 = Class(id: 6, subject: "ILR", number: 2100, name: "Labor Relations")
        let bio1000 = Class(id: 7, subject: "BIO", number: 1111, name: "Bio 1")
        let group1 = Group(relatedClass: cs3410, name: "Project 1")
        let group2 = Group(relatedClass: cs2300, name: "Project 4")
        let group3 = Group(relatedClass: orie3120, name: "Prelim 2")
        let group4 = Group(relatedClass: orie3120, name: "Problem Set 4")
        let group5 = Group(relatedClass: math2930, name: "Problem Set 8")
        let group6 = Group(relatedClass: music1312, name: "Final Essay")
        let group7 = Group(relatedClass: cs3410, name: "Project 5")
        let group8 = Group(relatedClass: cs3410, name: "Prelim 2")
        let group9 = Group(relatedClass: cs2300, name: "Lab 10")
        let group10 = Group(relatedClass: hadm1111, name: "Assignment 1")
        let group11 = Group(relatedClass: ilr2100, name: "Prelim 1")
        let group12 = Group(relatedClass: bio1000, name: "Prelim1")
        
        initialRecentGroups = [group1, group2, group3, group4, group5, group6, group7, group8, group9, group10, group11, group12]
        displayedGroups = initialRecentGroups
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension AllGroupsViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        displayedGroups.removeAll()
        if searchBar.text == "" {
            for group in initialRecentGroups {
                displayedGroups.append(group)
            }
        }
        else {
            for group in initialRecentGroups {
                if group.name.contains(searchText.uppercased()) {
                    displayedGroups.append(group)
                }
            }
        }
    }
}

extension AllGroupsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GroupTableViewCell
        let group = displayedGroups[indexPath.row]
        cell.configure(for: group)
        return cell
    }
}

extension AllGroupsViewController: UITableViewDelegate{
    
}
