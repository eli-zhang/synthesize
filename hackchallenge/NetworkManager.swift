//
//  NetworkManager.swift
//  hackchallenge
//
//  Created by Michael Behrens on 4/25/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import Foundation
import Alamofire

let url = "http://localhost:5000"

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
    
    static func getUser(id: Int, completion: @escaping (User) -> Void, failure: @escaping () -> Void) {
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
                failure()
            }
        }
    }
    
    static func modifyUser(id: Int, username: String, name: String, completion: @escaping (User) -> Void, failure: @escaping () -> Void) {
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
    
    static func deleteAllUsers(completion: @escaping () -> Void, failure: @escaping () -> Void) {
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
                failure()
            }
        }
    }
    
    static func getUsers(completion: @escaping ([User]) -> Void, failure: @escaping () -> Void ) {
        let endpoint = url + "/api/users/"
        Alamofire.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let multiUserInfo = try? decoder.decode(MultiUserData.self, from: data) {
                    if multiUserInfo.success {
                        completion(multiUserInfo.data)
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
                failure()
            }
        }
    }
    
    static func getClasses(completion: @escaping ([ClassInfo]) -> Void, failure: @escaping () -> Void ) {
        let endpoint = url + "/api/classes/"
        Alamofire.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                if let classInfo = try? decoder.decode(ClassData.self, from: data) {
                    if classInfo.success {
                        completion(classInfo.data)
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
                failure()
            }
        }
    }
    
    static func createAssignment(name: String, completion: @escaping () -> Void) {
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
}
