//
//  HomeModel.swift
//  Demo
//
//  Created by djiang on 13/04/21.
//  Copyright © 2021 ORG. All rights reserved.
//

import Foundation

struct HomeResponse: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [HomeItem]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct HomeItem: Codable {
    let name: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case name = "total_count"
        case title = "incomplete_results"
    }
}
