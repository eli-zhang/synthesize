//
//  GroupViewController.swift
//  hackchallenge
//
//  Created by Michael Behrens on 4/26/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController!.navigationBar.barTintColor = Colors.mainColor
        self.navigationController!.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]

        // Do any additional setup after loading the view.
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
