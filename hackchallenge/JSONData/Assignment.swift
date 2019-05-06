//
//  Assignment.swift
//  hackchallenge
//
//  Created by Eli Zhang on 4/28/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

struct MultiAssignmentData: Codable {
    let success: Bool
    let data: [Assignment]
}

struct AssignmentData: Codable {
    let success: Bool
    let data: Assignment
}

struct Assignment: Codable {
    let id: Int
    let name: String
    let class_id: Int
    let messages: [Message]
    
    func getImageName() -> String {
        var returnedString: String = ""
        NetworkManager.getClass(classId: class_id) { relatedClass in
            let name = relatedClass.name
            switch name {
            case "CS", "ECE", "INFO":
                returnedString = "cs"
            case "AEP", "BTRY", "MATH":
                returnedString = "math"
            case "AAS", "ARAB", "ASIAN", "ASRC", "BCS", "CHIN", "ITAL", "JAPAN", "KOREA", "SPAN":
                returnedString = "international"
            case "AEM", "ECON", "ORIE":
                returnedString = "business"
            case "AGSCI", "ALS", "BEE", "ESS":
                returnedString = "life"
            case let name where name.contains("BIO") || (name.contains("PL") && !(name.contains("JPL"))):
                returnedString = "life"
            case "AIRS", "BME", "CEE", "MAE", "MSE":
                returnedString = "eng"
            case let name where name.contains("ENG") && !(name.contains("ENGL")):
                returnedString = "eng"
            case "ART", "ARTH":
                returnedString = "art"
            case "CHEM", "CHEME":
                returnedString = "chem"
            case "ASTRO", "PHYS":
                returnedString = "astro"
            case "PSYCH":
                returnedString = "psych"
            case let name where name.contains("ILR") || name.contains("LAW"):
                returnedString = "law"
            case "HADM", "FDSC":
                returnedString = "food"
            case "MUSIC":
                returnedString = "music"
            default:
                returnedString = "general"
            }
        }
        return returnedString
    }
}
