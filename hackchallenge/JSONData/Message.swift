//
//  Message.swift
//  hackchallenge
//
//  Created by Eli Zhang on 4/28/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

struct MultiMessageData: Codable {
    let success: Bool
    let data: [Message]
}

struct MessageData: Codable {
    let success: Bool
    let data: Message
}

struct Message: Codable {
    let id: Int
    let message: String
    let username: String
    let name: String
    let time: String
}
