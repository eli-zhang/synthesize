//
//  AllGroupsViewController.swift
//  hackchallenge
//
//  Created by Michael Behrens on 4/25/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    var initialRecentGroups: [Group]!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Groups"
        let mainColor: UIColor = UIColor(red: 193/255, green: 94/255, blue: 178/255, alpha: 1.0)
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        
        // Do any additional setup after loading the view.
        
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
