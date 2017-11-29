//
//  RequestManager.swift
//  SocialTwist
//
//  Created by Marcel  on 10/17/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class RequestManager {
    
    typealias completition = (_ response: Any) -> Void
    typealias fail = (_ error: Any) -> Void
    
    // Singleton
    
    static let sharedInstance = RequestManager ()
    
    // MARK: - Credentials
    
    static func signIn(email: String, password: String, completition: @escaping completition, fail: @escaping fail) -> Void {
        
        let parameters = [
            
            "grant_type": "password",
            "username"  : email,
            "password"  : password,
            "client_id" : "TMZfVOHHMoBC0lBniwXpa6htljw0v5topwdBcimi"
        ]
        
        
        let url = Constants.BaseURL + "oauth/token/"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { response in

                guard response.result.isSuccess else {
                    print("API [oauth/token/] error")
                    
                    if let data = response.data {
                        
                        let statusCode = response.error.debugDescription
                        let errorDescription = String (data: data, encoding: .utf8)
                        
                        print("""
                            Status code : \(String(describing: statusCode))
                            Description : \(String(describing: errorDescription)))
                            """)
                        
//                        let jsonData = JSON (data)
//                        let errorString = jsonData.dictionary?.first?.value.rawString()
//                        fail (errorString?.letters ?? "Unknown error")
                    }
                    
                    return
                }
                
                if let response = response.result.value {
                    completition (response)
                }
                
//                switch response.result {
//
//                case .success:
//                    let jsonData = JSON (response.data!)
////                    let errorString = jsonData.dictionary?.first?.value.rawString()
////                    let errorString = jsonData["token_type"].rawString()
//
////                    print("Login first object \(errorString!)")
//                    print(response)
//                    completition(response)
//
//                case .failure(let error):
//
//                    print("ERROR \(error.localizedDescription)")
//
//                    if let data = response.data {
//                        let json = String (data: data, encoding: String.Encoding.utf8)
//                        print("ERROR \(json!)")
//
//                        fail(json!)
//                    }
//
//                }
        }
        
    }
    
    
    static func signUp(name: String, surname: String, email: String, password: String, birthday: String, sex: String, completition: @escaping completition, fail: @escaping fail) -> Void {
        
        let parameters = [
            
            "device_token"  : "nil",
            "username"      : name.lowercased() + surname.lowercased(),
            "last_name"     : surname,
            "is_ios"        : "1",
            "phone_number"  : "nil",
            "location"      : "nil",
            "first_name"    : name,
            "email"         : email,
            "birthday"      : birthday,
            "password"      : password
            
        ]
        
        let url = Constants.BaseURL + "oauth/register/"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("API [oauth/register/] error")
                    
                    if let data = response.data {
                        
                        let statusCode = response.error?.localizedDescription
                        let errorDescription = String(data: data, encoding: .utf8)
                        
                        print("""
                            Status code : \(String(describing: statusCode))
                            Description : \(String(describing: errorDescription)))
                            """)
                        
//                        let jsonData = JSON (data)
//                        let errorString = jsonData.dictionary?.first?.value.rawString()
//                        fail (errorString?.letters ?? "Unknown error")
                    }
                    
                    return
                }
                
                if let response = response.result.value {
                    completition (response)
                }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    static func getEvents(coordinates: CLLocationCoordinate2D,
                   radius: Int,
                   categories: [String],
                   offset: Int,
                   count: Int,
                   completion: @escaping completition,
                   fail: @escaping fail)  {
        
        let parameters = [
            "lat"           : String(coordinates.latitude),
            "lon"           : String(coordinates.longitude),
            "radius"        : String(radius),
            "categories"    : categories,
            "offset"        : offset,
            "limit"         : count
            ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Accept"        : "application/json",
            "Authorization" : "dwa"
        ]
        
        let url = Constants.BaseURL + "events/"
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("API [events/] error")
                    
                    if let data = response.data {
                        
                        let statusCode = response.error?.localizedDescription
                        let errorDescription = String(data: data, encoding: .utf8)
                        
                        print("""
                            Status code : \(String(describing: statusCode))
                            Description : \(String(describing: errorDescription)))
                            """)
                        
//                        let jsonData = JSON (data)
//                        let errorString = jsonData.dictionary?.first?.value.rawString()
//                        fail (errorString?.letters ?? "Unknown error")
                    }
                    
                    return
                }
                
                if let response = response.result.value {
                    print(response)
                    completion (response)
                }
        }
        
    }
    
    
    
    
    
    static func getDogsImages(completion: @escaping completition, fail: @escaping fail) {
        
        let url = Constants.TestURL + "api/breed/african/images"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("API [oauth/register/] error")
                    
                    if let data = response.data {
                        
                        let statusCode = response.error?.localizedDescription
                        let errorDescription = String(data: data, encoding: .utf8)
                        
                        print("""
                            Status code : \(String(describing: statusCode))
                            Description : \(String(describing: errorDescription)))
                            """)
                        
//                        let jsonData = JSON (data)
//                        let errorString = jsonData.dictionary?.first?.value.rawString()
//                        fail (errorString?.letters ?? "Unknown error")
                    }
                    
                    return
                }

                    do {
                        let dogs = try JSONDecoder().decode(Dog.self, from: response.data!)
                        completion(dogs.imageUrls)
                        
                    } catch {
                        print(error)
                    }
        }
    }
    
}

