//
//  Class.swift
//  homeworkapp
//
//  Created by Victor Chen on 4/21/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import Foundation

struct ClassData: Codable {
    let success: Bool
    let data: [Class]
}

struct Class: Codable {
    
    let subject: String
    let number: Int
    let name: String
    
    func getImageName() -> String {
        switch subject {
        case "CS", "ECE", "INFO":
            return "cs"
        case "AEP", "BTRY", "MATH":
            return "math"
        case "AAS", "ARAB", "ASIAN", "ASRC", "BCS", "CHIN", "ITAL", "JAPAN", "KOREA", "SPAN":
            return "international"
        case "AEM", "ECON", "ORIE":
            return "business"
        case "AGSCI", "ALS", "BEE", "ESS":
            return "life"
        case let subject where subject.contains("BIO") || (subject.contains("PL") && !(subject.contains("JPL"))):
            return "life"
        case "AIRS", "BME", "CEE", "MAE", "MSE":
            return "eng"
        case let subject where subject.contains("ENG") && !(subject.contains("ENGL")):
            return "eng"
        case "ART", "ARTH":
            return "art"
        case "CHEM", "CHEME":
            return "chem"
        case "ASTRO", "PHYS":
            return "astro"
        case "PSYCH":
            return "psych"
        case let subject where subject.contains("ILR") || subject.contains("LAW"):
            return "law"
        case "HADM", "FDSC":
            return "food"
        case "MUSIC":
            return "music"
        default:
            return "general"
        }
    }
    
    func getTitle() -> String {
        return "\(self.subject) \(self.number)"
    }
}
