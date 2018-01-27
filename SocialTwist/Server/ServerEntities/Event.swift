//
//  EventEntity.swift
//  SocialTwist
//
//  Created by Marcel  on 11/22/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

import Foundation

struct Event {
    var imageURL: String
    var creatorImageURL: String
    var creatorName: String
    var description: String
    var place: String
    var attenders: Int
    var startTime: String
    var type: String
    
    
    
}

extension Event {
    
    init() {
        imageURL = ""
        creatorImageURL = ""
        creatorName = ""
        description = ""
        place = ""
        attenders = 0
        startTime = ""
        type = ""
    }
}

/*
extension Event: Decodable {
    enum CodingKeys: String, CodingKey {
        case imageURL = "message"
        case creatorImageURL = "message"
        case creatorName = "status"
        case description = "status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageURL = try container.decode([String].self, forKey: .imageURL)
        creatorImageURL = try container.decode([String].self, forKey: .creatorImageURL)
        creatorName = try container.decode(String.self, forKey: .creatorName)
        description = try container.decode(String.self, forKey: .description)
    }
}
*/



// Trash

struct Dog {
    let imageUrls: [String]
    let status: String
}

extension Dog: Decodable {

    enum CodingKeys: String, CodingKey {
        case imageUrls = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageUrls = try container.decode([String].self, forKey: .imageUrls)
        status = try container.decode(String.self, forKey: .status)
    }
}

