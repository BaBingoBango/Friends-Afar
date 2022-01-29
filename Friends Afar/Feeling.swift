//
//  Feeling.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/10/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import Foundation

struct Feeling: Codable {
    
    // Variables
    let feeling_text: String
    let device_id: String
    let is_healthcare: String
    
    // Enumerations
    enum CodingKeys: String, CodingKey {
        case feeling_text// = "Feeling Text"
        case device_id// = "Device ID"
        case is_healthcare// = "Is Healthcare?"
    }
}
