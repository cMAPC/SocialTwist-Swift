//
//  RequestManager.swift
//  SocialTwist
//
//  Created by Marcel  on 10/17/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
                        
                        let jsonData = JSON (data)
                        let errorString = jsonData.dictionary?.first?.value.rawString()
                        fail (errorString?.letters ?? "Unknown error")
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
                        
                        let jsonData = JSON (data)
                        let errorString = jsonData.dictionary?.first?.value.rawString()
                        fail (errorString?.letters ?? "Unknown error")
                    }
                    
                    return
                }
                
                if let response = response.result.value {
                    completition (response)
                }
                
                
                
                
                
                /*
                switch response.result {
                    
                case .success:
                    completition (response)
                    
                case .failure (let error):
                    print("Error \(error.localizedDescription)")
                    
                    if let data = response.data {
                        let json = String (data: data, encoding: String.Encoding.utf8)
                        print("ERROR \(json!)")
                        
                        
                        
//                        if let data = json(using: .utf8) {
//                            do {
//                                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                                print(dictionary?.values.first as! String)
//                            } catch {
//                                print(error.localizedDescription)
//                            }

//                        var dictionary = [String: Any]()
                        let jsonData = JSON (data)
                        let dictonary = jsonData.dictionary!
                        let errorString = jsonData.dictionary?.first?.value.rawString()
//                        let errorString = dictonary.values.first?.description
                        
                        
                        print("Error string \(errorString?.letters)")
//                        for (key,subJson):(String, JSON) in jsonData {
//                            let errorString = subJson.debugDescription.f
//                        }
                        
//                        print("This is sparta \(dictonary.values.first!)")
                        fail (errorString?.letters)
                        
//                        let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//
//                        print(dict??.values.first)
//
//
//                        do {
//                            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
//                            print(dictionary.values.first!)
//                        } catch {
//                            print(error.localizedDescription)
//                        }
                        
                        
                    }
                    
                }
                 */
        }
    }
    
}
