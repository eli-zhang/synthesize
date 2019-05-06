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


struct BasicAssignment: Codable {
    let id: Int
    let name: String
    let class_id: Int
    
    func getInfo(completion: @escaping (String, Class) -> Void) {
        NetworkManager.getClass(classId: class_id) { relatedClass in
            let subject = relatedClass.subject
            switch subject {
            case "CS", "ECE", "INFO":
                completion("cs", relatedClass)
            case "AEP", "BTRY", "MATH":
                completion("math", relatedClass)
            case "AAS", "ARAB", "ASIAN", "ASRC", "BCS", "CHIN", "ITAL", "JAPAN", "KOREA", "SPAN":
                completion("international", relatedClass)
            case "AEM", "ECON", "ORIE":
                completion("business", relatedClass)
            case "AGSCI", "ALS", "BEE", "ESS":
                completion("life", relatedClass)
            case let name where name.contains("BIO") || (name.contains("PL") && !(name.contains("JPL"))):
                completion("life", relatedClass)
            case "AIRS", "BME", "CEE", "MAE", "MSE":
                completion("eng", relatedClass)
            case let name where name.contains("ENG") && !(name.contains("ENGL")):
                completion("eng", relatedClass)
            case "ART", "ARTH":
                completion("art", relatedClass)
            case "CHEM", "CHEME":
                completion("chem", relatedClass)
            case "ASTRO", "PHYS":
                completion("astro", relatedClass)
            case "PSYCH":
                completion("psych", relatedClass)
            case let name where name.contains("ILR") || name.contains("LAW"):
                completion("law", relatedClass)
            case "HADM", "FDSC":
                completion("food", relatedClass)
            case "MUSIC":
                completion("music", relatedClass)
            default:
                completion("general", relatedClass)
            }
        }
    }
}

struct Assignment: Codable {
    let id: Int
    let name: String
    let class_id: Int
    let messages: [Message]
}
