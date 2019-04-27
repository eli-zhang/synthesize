//
//  ViewController.swift
//  homeworkapp
//
//  Created by Michael Behrens on 4/23/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var browseButton: UIButton!
    var recentLabel: UILabel!
    var recentGroupsCollectionView: UICollectionView!
    var reuse: String = "GroupReuse"
    var initialRecentGroups: [Group]!
    var recommendedLabel: UILabel!
    var tabController: UITabBarController!
    let browseViewController = BrowseViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Home"
        let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        
//        browseButton = UIButton()
//        browseButton.translatesAutoresizingMaskIntoConstraints = false
//        browseButton.setTitle("Browse", for: .normal)
//        browseButton.setTitleColor(.white, for: .normal)
//        browseButton.backgroundColor = mainColor
//        browseButton.contentVerticalAlignment = .center
//        browseButton.layer.cornerRadius = 25
//        browseButton.clipsToBounds = true
//        browseButton.addTarget(self, action: #selector(presentBrowseViewController), for: .touchUpInside)
        //view.addSubview(browseButton)
        
        recentLabel = UILabel()
        recentLabel.translatesAutoresizingMaskIntoConstraints = false
        recentLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        recentLabel.textColor = mainColor
        recentLabel.text = "Recent"
        view.addSubview(recentLabel)
        
        recommendedLabel = UILabel()
        recommendedLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendedLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        recommendedLabel.textColor = mainColor
        recommendedLabel.text = "Recommended"
        view.addSubview(recommendedLabel)
        
        let recentGroupsLayout = UICollectionViewFlowLayout()
        recentGroupsLayout.scrollDirection = .horizontal
        recentGroupsLayout.minimumLineSpacing = 10
        recentGroupsLayout.minimumInteritemSpacing = 10
        
        recentGroupsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recentGroupsLayout)
        recentGroupsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recentGroupsCollectionView.backgroundColor = .white
        recentGroupsCollectionView.dataSource = self
        recentGroupsCollectionView.delegate = self
        recentGroupsCollectionView.register(RecentGroupCollectionViewCell.self, forCellWithReuseIdentifier: reuse)
        recentGroupsCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(recentGroupsCollectionView)
        
//        tabController = UITabBarController()
//        //tabController.delegate = self
//        tabController.tabBar.barStyle = .default
//        let classViewController = ClassViewController()
//        tabController.viewControllers = [classViewController, browseViewController]
//        view.addSubview(tabController.view)
        
        
        
        let cs3410 = Class(subject: "CS", number: 3410, name: "Computer System Organization and Programming")
        let cs2300 = Class(subject: "CS", number: 2300, name: "Intermediate Web Design and Programming")
        let orie3120 = Class(subject: "ORIE", number: 3120, name: "Practical Tools for OR and Machine Learning")
        let math2930 = Class(subject: "MATH", number: 2930, name: "Differential Equations")
        let music1312 = Class(subject: "MUSIC", number: 1312, name: "History of Rock Music")
        let hadm1111 = Class(subject: "HADM", number: 1111, name: "Hotel Class")
        let ilr2100 = Class(subject: "ILR", number: 2100, name: "Labor Relations")
        let bio1000 = Class(subject: "BIO", number: 1111, name: "Bio 1")
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
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            browseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
//            browseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            browseButton.widthAnchor.constraint(equalToConstant: 200),
//            browseButton.heightAnchor.constraint(equalToConstant: 50)
//            ])
        
        NSLayoutConstraint.activate([
            recentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            recentGroupsCollectionView.topAnchor.constraint(equalTo: recentLabel.bottomAnchor, constant: 20),
            recentGroupsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recentGroupsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recentGroupsCollectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            recommendedLabel.topAnchor.constraint(equalTo: recentGroupsCollectionView.bottomAnchor, constant: 25),
            recommendedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recommendedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendedLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    @objc func presentBrowseViewController() {
        navigationController?.pushViewController(browseViewController, animated: true)
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return initialRecentGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! RecentGroupCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        let group = initialRecentGroups[indexPath.item]
        cell.configure(for: group)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = initialRecentGroups[indexPath.item]
        let groupViewController = GroupViewController()
        groupViewController.title = cell.relatedClass.getTitle() + " - " + cell.name
        navigationController?.pushViewController(groupViewController, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width / 2 - 5)
        return CGSize(width: length, height: length / 2)
    }
}
