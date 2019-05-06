//
//  ViewController.swift
//  homeworkapp
//
//  Created by Michael Behrens on 4/23/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    var browseButton: UIButton!
    var recentLabel: UILabel!
    var recentGroupsCollectionView: UICollectionView!
    var recentClassesCollectionView: UICollectionView!
    var reuse: String = "GroupReuse"
    var reuseClass: String = "ClassReuse"
    var recentAssignments: [BasicAssignment]!
    var recentClassesLabel: UILabel!
    var recentClasses: [Class]!
    var tabController: UITabBarController!
    var signOutButton: UIButton!
    let browseViewController = BrowseViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Home"
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = Colors.mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        
        recentLabel = UILabel()
        recentLabel.translatesAutoresizingMaskIntoConstraints = false
        recentLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        recentLabel.textColor = Colors.mainColor
        recentLabel.text = "Recent Groups"
        view.addSubview(recentLabel)
        
        recentClassesLabel = UILabel()
        recentClassesLabel.translatesAutoresizingMaskIntoConstraints = false
        recentClassesLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        recentClassesLabel.textColor = Colors.mainColor
        recentClassesLabel.text = "Recent Classes"
        view.addSubview(recentClassesLabel)
        
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
        
        let recentClassesLayout = UICollectionViewFlowLayout()
        recentClassesLayout.scrollDirection = .horizontal
        recentClassesLayout.minimumLineSpacing = 10
        recentClassesLayout.minimumInteritemSpacing = 10
        
        recentClassesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recentClassesLayout)
        recentClassesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recentClassesCollectionView.backgroundColor = .white
        recentClassesCollectionView.dataSource = self
        recentClassesCollectionView.delegate = self
        recentClassesCollectionView.register(RecentGroupCollectionViewCell.self, forCellWithReuseIdentifier: reuseClass)
        recentClassesCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(recentClassesCollectionView)
        
        signOutButton = UIButton()
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.setTitle("Sign out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        signOutButton.backgroundColor = Colors.mainColor
        signOutButton.layer.cornerRadius = 25
        signOutButton.layer.shadowColor = Colors.shadowColor
        signOutButton.layer.shadowOffset = CGSize(width: 5, height: 7)
        signOutButton.layer.shadowOpacity = 0.8
        signOutButton.layer.masksToBounds = false
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        view.addSubview(signOutButton)
        
        recentAssignments = []
        recentClasses = []
        setupConstraints()
        getRecentClassesAndGroups()
        checkSignIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        getRecentClassesAndGroups()
    }
    
    func getRecentClassesAndGroups() {
        NetworkManager.getUser(id: UserDefaults.standard.integer(forKey: "id"), completion: { user in
            self.recentClasses = user.classes
            self.recentAssignments = user.assignments
            DispatchQueue.main.async {
                self.recentGroupsCollectionView.reloadData()
                self.recentClassesCollectionView.reloadData()
            }
        })
    }
    
    @objc func signOut() {
        GIDSignIn.sharedInstance().signOut()
        let signInController = SignInViewController()
        present(signInController, animated: true, completion: nil)
    }
    
    func checkSignIn() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            DispatchQueue.main.async {
                GIDSignIn.sharedInstance()?.signInSilently()
                self.getRecentClassesAndGroups()
            }
        }
        else {
            let signInController = SignInViewController()
            present(signInController, animated: true, completion: nil)
        }
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            signOutButton.widthAnchor.constraint(equalToConstant: 250)
            ])
        NSLayoutConstraint.activate([
            recentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            recentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentLabel.heightAnchor.constraint(equalToConstant: 35)
            ])
        
        NSLayoutConstraint.activate([
            recentGroupsCollectionView.topAnchor.constraint(equalTo: recentLabel.bottomAnchor, constant: 15),
            recentGroupsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            recentGroupsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            //            recentGroupsCollectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
            recentGroupsCollectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 10)
            ])
        
        NSLayoutConstraint.activate([
            recentClassesLabel.topAnchor.constraint(equalTo: recentGroupsCollectionView.bottomAnchor, constant: 15),
            recentClassesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            recentClassesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recentClassesLabel.heightAnchor.constraint(equalToConstant: 35)
            ])
        
        NSLayoutConstraint.activate([
            recentClassesCollectionView.topAnchor.constraint(equalTo: recentClassesLabel.bottomAnchor, constant: 15),
            recentClassesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            recentClassesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            recentClassesCollectionView.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -20)
            ])
    }
    
    @objc func presentBrowseViewController() {
        navigationController?.pushViewController(browseViewController, animated: true)
    }
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recentGroupsCollectionView {
            return recentAssignments.count
        }
        else {
            return recentClasses.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.recentGroupsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! RecentGroupCollectionViewCell
            let assignment = recentAssignments[indexPath.item]
            cell.configure(for: assignment)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseClass, for: indexPath) as! RecentGroupCollectionViewCell
            let course = recentClasses[indexPath.item]
            cell.configure(for: course)
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.recentGroupsCollectionView {
            let assignment = recentAssignments[indexPath.item]
            let messageViewController = MessagesViewController()
            messageViewController.addAssignmentInfo(assignment: assignment)
            navigationController?.pushViewController(messageViewController, animated: true)
        }
        else {
            let cell = recentClasses[indexPath.item]
            let classViewController = ClassViewController(relatedClass: cell)
            classViewController.title = "Groups - " + cell.getTitle()
            navigationController?.pushViewController(classViewController, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 20
        let height = recentGroupsCollectionView.frame.height / 2 - 5
        return CGSize(width: width, height: height)
    }
}
