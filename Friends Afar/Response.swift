//
//  Response.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/12/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import Foundation

struct Response: Codable, Identifiable {
    
    // Variables
    var id = UUID()
    let response_text: String
    let device_id: String
    let feeling_text: String
    let sender_id: String
    
    // Enumerations
    enum CodingKeys: String, CodingKey {
        case response_text
        case device_id
        case feeling_text
        case sender_id
    }
}
