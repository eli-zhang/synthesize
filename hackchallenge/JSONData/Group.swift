//
//  Group.swift
//  homeworkapp
//
//  Created by Michael Behrens on 4/23/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import Foundation

class Group {
    var relatedClass: Class
    var name: String
    
    init(relatedClass: Class, name: String) {
        self.relatedClass = relatedClass
        self.name = name
    }
}
