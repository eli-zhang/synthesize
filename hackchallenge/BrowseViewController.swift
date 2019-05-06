//
//  BrowseViewController.swift
//  homeworkapp
//
//  Created by Victor Chen on 4/21/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BrowseViewController: UIViewController {
    
    var searchBar: UISearchBar!
    var classTableView: UITableView!
    var browseButton: UIButton!
    
    var originalCourses: [Class]!
    var displayedCourses: [Class]!
    
    let refreshControl = UIRefreshControl()
    let loadingIndicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: Colors.mainColor)
    let reuseIdentifier = "reuse"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        title = "Browse"
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = Colors.mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        self.hideKeyboardWhenTappedAround()
        
        displayedCourses = []
        originalCourses = displayedCourses
        
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autocorrectionType = .no
        view.addSubview(searchBar)
        searchBar.placeholder = "Find a class"
        searchBar.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
        classTableView = UITableView()
        classTableView.translatesAutoresizingMaskIntoConstraints = false
        classTableView.register(ClassTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        classTableView.dataSource = self
        classTableView.delegate = self
        classTableView.alwaysBounceVertical = true
        classTableView.refreshControl = refreshControl
        view.addSubview(classTableView)
        
        loadingIndicator.alpha = 0.0
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        
        setupConstraints()
        getCourses()
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
            
            loadingIndicator.centerXAnchor.constraint(equalTo: classTableView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: classTableView.centerYAnchor),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 60),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    @objc func refreshTable() {
        DispatchQueue.main.async {
            NetworkManager.getClasses(completion: { classes in
                self.originalCourses = classes
                self.displayedCourses = classes
                DispatchQueue.main.async {self.classTableView.reloadData()}})
            self.refreshControl.endRefreshing()
        }
    }
    
    func getCourses() {
        classTableView.separatorStyle = .none
        loadingIndicator.startAnimating()
        UIView.animate(withDuration: 0.4) {
            self.loadingIndicator.alpha = 1.0
        }
        NetworkManager.getClasses(completion: { classes in
            self.originalCourses = classes
            self.displayedCourses = classes
            UIView.animate(withDuration: 0.4, animations: {
                self.loadingIndicator.alpha = 0.0
            }) { complete in
                self.loadingIndicator.stopAnimating()
                self.classTableView.separatorStyle = .singleLine
            }
            DispatchQueue.main.async {self.classTableView.reloadData()}})
    }
}

extension BrowseViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ClassTableViewCell
        let course = displayedCourses[indexPath.row]
        cell.configure(for: course)
        return cell
    }
    
    
}

extension BrowseViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        displayedCourses.removeAll()
        if searchBar.text == "" {
            for course in originalCourses {
                displayedCourses.append(course)
            }
        }
        else {
            for course in originalCourses {
                if course.getTitle().contains(searchText.uppercased()) {
                    displayedCourses.append(course)
                }
            }
        }
        classTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchBar.endEditing(true)
    }
}

extension BrowseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let relatedClass = displayedCourses[indexPath.row]
        let classViewController = ClassViewController(relatedClass: relatedClass)
        navigationController?.pushViewController(classViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
