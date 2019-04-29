//
//  ClassInfo.swift
//  hackchallenge
//
//  Created by Eli Zhang on 4/28/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

struct ClassData: Codable {
    let success: Bool
    let data: [ClassInfo]
}

struct ClassInfo: Codable {
    let subject: String
    let number: Int
    let name: String
    
    func getTitle() -> String {
        return subject + " " + String(number)
    }
}
