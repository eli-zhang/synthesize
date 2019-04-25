//
//  NetworkManager.swift
//  hackchallenge
//
//  Created by Michael Behrens on 4/25/19.
//  Copyright © 2019 Michael Behrens. All rights reserved.
//

import Foundation
import Alamofire

let endpoint = "https://mindylou.github.io/classes.json"

class NetworkManager {
    static func getClasses() {
        Alamofire.request(endpoint, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print(json)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
