//
//  Class.swift
//  homeworkapp
//
//  Created by Victor Chen on 4/21/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import Foundation

class Class {
    var subject: String
    var number: Int
    var name: String
    var subjectnumber: String
    var imageName: String?
    
    init(subject: String, number: Int, name: String) {
        self.subject = subject
        self.number = number
        self.name = name
        self.subjectnumber = "\(subject) \(number)"
        if (subject=="CS" || subject=="ECE" || subject=="INFO") {
            self.imageName = "cs"
        }
        else if (subject=="AEP" || subject=="BTRY" || subject=="MATH") {
            self.imageName = "math"
        }
        else if (subject=="AAS" || subject=="ARAB" || subject=="ASIAN" || subject=="ASRC" || subject=="BCS" || subject=="CHIN" || subject=="ITAL" || subject=="JAPAN" || subject=="KOREA" || subject=="SPAN") {
            self.imageName = "international"
        }
        else if (subject=="AEM" || subject=="ECON" || subject=="ORIE") {
            self.imageName = "business"
        }
        else if (subject=="AGSCI" || subject=="ALS" || subject=="BEE" || subject=="ESS" || subject.contains("BIO") || (subject.contains("PL") && !(subject.contains("JPL")))) {
            self.imageName = "life"
        }
        else if (subject=="AIRS" || subject=="BME" || subject=="CEE" || subject=="MAE" || subject=="MSE" || (subject.contains("ENG") && !(subject.contains("ENGL")))) {
            self.imageName = "eng"
        }
        else if (subject=="ART" || subject=="ARTH") {
            self.imageName = "art"
        }
        else if (subject=="CHEM" || subject=="CHEME") {
            self.imageName = "chem"
        }
        else if (subject=="ASTRO" || subject=="PHYS") {
            self.imageName = "astro"
        }
        else if (subject=="PSYCH") {
            self.imageName = "psych"
        }
        else if (subject.contains("ILR") || subject.contains("LAW")) {
            self.imageName = "law"
        }
        else if (subject=="HADM" || subject=="FDSC") {
            self.imageName = "food"
        }
        else if (subject=="MUSIC") {
            self.imageName = "music"
        }
        else {
            self.imageName = "general"
        }
    }
    
    init(subject: String, number: Int, name: String, imageName: String) {
        self.subject = subject
        self.number = number
        self.name = name
        self.subjectnumber = "\(subject)\(number)"
        self.imageName = imageName
    }
    
    func getTitle() -> String {
        return subject + " " + String(number)
    }
}
