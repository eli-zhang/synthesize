//
//  NetworkManager.swift
//  hackchallenge
//
//  Created by Michael Behrens on 4/25/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import Foundation
import Alamofire

let url = "http://35.237.82.135"

class NetworkManager {
    static func createUser(username: String, name: String, completion: @escaping () -> Void) {
        let endpoint = url + "/api/user/"
        let parameters: Parameters = ["username": username,
                                      "name": name]
        Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let userdata = try? decoder.decode(UserData.self, from: data) {
                    if userdata.success {
                        completion()
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func getUser(id: Int, completion: @escaping (User) -> Void) {
        let endpoint = url + "/api/user/\(id)"
        Alamofire.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let userData = try? decoder.decode(UserData.self, from: data) {
                    if userData.success {
                        completion(userData.data)
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func modifyUser(id: Int, username: String, name: String, completion: @escaping (User) -> Void) {
        let endpoint = url + "/api/user/"
        let parameters: Parameters = ["username": username,
                                      "name": name]
        Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let userdata = try? decoder.decode(UserData.self, from: data) {
                    if userdata.success {
                        completion(userdata.data)
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func deleteAllUsers(completion: @escaping () -> Void) {
        let endpoint = url + "api/users/"
        Alamofire.request(endpoint, method: .delete).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let userData = try? decoder.decode(UserData.self, from: data) {
                    if userData.success {
                        completion()
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func getUsers(completion: @escaping ([User]) -> Void) {
        let endpoint = url + "/api/users/"
        Alamofire.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let multiUserData = try? decoder.decode(MultiUserData.self, from: data) {
                    if multiUserData.success {
                        completion(multiUserData.data)
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func getClasses(completion: @escaping ([Class]) -> Void) {
        let endpoint = url + "/api/classes/"
        Alamofire.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let classData = try? decoder.decode(ClassData.self, from: data) {
                    if classData.success {
                        completion(classData.data)
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func createAssignment(classId: Int, name: String, completion: @escaping (Assignment) -> Void) {
        let endpoint = url + "/api/class/\(classId)/assignment/"
        let parameters: Parameters = ["name": name]
        Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let assignmentData = try? decoder.decode(AssignmentData.self, from: data) {
                    if assignmentData.success {
                        completion(assignmentData.data)
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func getAssignmentsFromClass(classId: Int, completion: @escaping ([Assignment]) -> Void) {
        let endpoint = url + "/api/class/\(classId)/assignments/"
        Alamofire.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let multiAssignmentData = try? decoder.decode(MultiAssignmentData.self, from: data) {
                    if multiAssignmentData.success {
                        completion(multiAssignmentData.data)
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func addMessageToAssignment(classId: Int, assignmentId: Int, message: String, username: String, user: String, time: String, completion: @escaping (Message) -> Void) {
        let endpoint = url + "/api/class/\(classId)/assignment/\(assignmentId)/"
        let parameters: Parameters = ["message": message,
                                      "username": username,
                                      "user": user,
                                      "time": time]
        Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let messageData = try? decoder.decode(MessageData.self, from: data) {
                    if messageData.success {
                        completion(messageData.data)
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func getMessagesFromAssignment(classId: Int, assignmentId: Int, completion: @escaping ([Message]) -> Void) {
        let endpoint = url + "/api/class/\(classId)/assignment/\(assignmentId)/"
        Alamofire.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let multiMessageData = try? decoder.decode(MultiMessageData.self, from: data) {
                    if multiMessageData.success {
                        completion(multiMessageData.data)
                    }
                }
            case let .failure(error):
                if let data = response.data {
                    let decoder = JSONDecoder()
                    if let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) {
                        print(errorMessage.error)
                    }
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
