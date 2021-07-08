//
//  HomeModel.swift
//  Demo
//
//  Created by djiang on 13/04/21.
//  Copyright © 2021 ORG. All rights reserved.
//

import Foundation

struct HomeResponse: Codable {
    let count: Int?
    let items: [HomeItem]?

    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
}

struct HomeItem: Codable {
    let id: String?
    let createdAt: String?
    let name: String?
    let price: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case name
        case price
    }
}
