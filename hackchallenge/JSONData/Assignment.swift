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
}
