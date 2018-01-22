//
//  String.swift
//  SocialTwist
//
//  Created by Marcel  on 10/23/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation

extension String {
    
    var isPasswordValid: Bool {
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return passwordPredicate.evaluate(with: self)
    }
    
    var isEmailValid: Bool {
        let pattern = "^(?=.*[A-z])(?=.*[@.])"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return emailPredicate.evaluate(with: self)
    }
    
    func toStringDate(fromDateFormat: String, toDateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromDateFormat
        let oldFormatDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = toDateFormat
        let newFormatDate: String  = dateFormatter.string(from: oldFormatDate!)
        
        return newFormatDate
    }
    
    func timestampStringDate(_withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
//        let timestamp = Double(self)
    
//        let date: Date?
//        if let timestamp = Double(self) {
//            date = Date(timeIntervalSince1970: timestamp)
//            return dateFormatter.string(from: date)
//        }
//
        guard let timestamp = Double(self) else {
            return "timestampStringDate error"
        }
        
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
    
    var letters: String {
        
        let pattern = "[A-Z .,+-]"
        
        guard let regex = try? NSRegularExpression (pattern: pattern, options: .caseInsensitive) else {
            print("Regex Error")
            return ""
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange (self.startIndex..., in: self))
        let matchedString = matches.map { String(self[Range($0.range, in: self)!]) }.joined()
        
        return matchedString
        
        /*
        do {
            let regex = try NSRegularExpression (pattern: pattern, options: .caseInsensitive)
            let matches = regex.matches(in: self, options: [], range: NSRange (self.startIndex..., in: self))
            
            matchedString = matches.flatMap {
                
                String(self[Range($0.range, in: self)!])
                
                }.joined()
            
            print(matchedString)
            
        } catch let error {
            
            print(error.localizedDescription)
        }
        
        return matchedString
        */
        
    }
}
