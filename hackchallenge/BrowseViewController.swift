//
//  BrowseViewController.swift
//  homeworkapp
//
//  Created by Victor Chen on 4/21/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {
    
    var searchBar: UISearchBar!
    var classTableView: UITableView!
    var browseButton: UIButton!
    
    var originalCourses: [Class]!
    var displayedCourses: [Class]!
    
    let reuseIdentifier = "reuse"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Browse"
        let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        
        
//        originalCourses = [
//            Class(subject: "CS", number: 1998, name: "Intro to iOS Development"),
//            Class(subject: "MATH", number: 2210, name: "Linear Algebra"),
//            Class(subject: "PE", number: 1300, name: "Bowling")]
        
        let cs3410 = Class(subject: "CS", number: 3410, name: "Computer System Organization and Programming")
        let cs2300 = Class(subject: "CS", number: 2300, name: "Intermediate Web Design and Programming")
        let orie3120 = Class(subject: "ORIE", number: 3120, name: "Practical Tools for OR and Machine Learning")
        let math2930 = Class(subject: "MATH", number: 2930, name: "Differential Equations")
        let music1312 = Class(subject: "MUSIC", number: 1312, name: "History of Rock Music")
        let hadm1111 = Class(subject: "HADM", number: 1111, name: "Hotel Class")
        let ilr2100 = Class(subject: "ILR", number: 2100, name: "Labor Relations")
        let bio1000 = Class(subject: "BIO", number: 1111, name: "Bio 1")
        
//        displayedCourses = [
//            Class(subject: "CS", number: 1998, name: "Intro to iOS Development"),
//            Class(subject: "MATH", number: 2210, name: "Linear Algebra"),
//            Class(subject: "PE", number: 1300, name: "Bowling")]
        displayedCourses = [cs3410, cs2300, orie3120, math2930, music1312, hadm1111, ilr2100, bio1000]
        originalCourses = displayedCourses
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autocorrectionType = .no
        view.addSubview(searchBar)
        searchBar.placeholder = "Find a class"
        searchBar.delegate = self
        
        classTableView = UITableView()
        classTableView.translatesAutoresizingMaskIntoConstraints = false
        classTableView.register(ClassTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        classTableView.dataSource = self
        classTableView.delegate = self
        
        view.addSubview(classTableView)
        
    
        
        setupConstraints()
        //getCourses()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            classTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            classTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            classTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            //classTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            classTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        
        
    }
    
    func getCourses() {
        NetworkManager.getClasses()
    }
    
}

extension BrowseViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCourses.count
        //return originalCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ClassTableViewCell
        let course = displayedCourses[indexPath.row]
        //let course = originalCourses[indexPath.row]
        cell.configure(for: course)
        return cell
    }
    
    
}

extension BrowseViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        displayedCourses.removeAll()
        if searchBar.text == ""{
            for course in originalCourses {
                displayedCourses.append(course)
            }
        }
        else {
            for course in originalCourses {
                if course.subjectnumber.contains(searchText.uppercased()) {
                    displayedCourses.append(course)
                }
            }
        }
        classTableView.reloadData()
    }
}

extension BrowseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = displayedCourses[indexPath.row]
        let classViewController = ClassViewController(relatedClass: cell)
        classViewController.title = "Groups - " + cell.getTitle()
        navigationController?.pushViewController(classViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
