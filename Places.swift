//
//  Place.swift
//  TestVertagelab
//
//  Created by Anna Luchechko on 21.01.2021.
//

import UIKit

struct Places: Codable {
    let places: [Place]
    
    struct Place: Codable {
        let id: Int
        let name: String
        let lat, lng: Double
    }
}
