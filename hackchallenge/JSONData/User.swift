//
//  User.swift
//  hackchallenge
//
//  Created by Eli Zhang on 4/28/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

struct UserData: Codable {
    let success: Bool
    let data: User
}

struct MultiUserData: Codable {
    let success: Bool
    let data: [User]
}

struct User: Codable {
    let id: Int
    let username: String
    let name: String
    let classes: [Class]
    let assignments: [BasicAssignment]
}
