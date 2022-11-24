//
//  HomeModel.swift
//  testProject
//
//  Created by YongJin on 2022/11/24.
//

import Foundation

// MARK: - Initializing
struct Initializing: Codable {
    let banners: [Banner]?
    let goods: [Good]?
}

struct Pagination: Codable {
    let goods: [Good]?
}

// MARK: - Banner
struct Banner: Codable {
    let id: Int
    let image: String
}

// MARK: - Good
struct Good: Codable {
    let id: Int
    let name: String
    let image: String
    let isNew: Bool
    let sellCount, actualPrice, price: Int

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case isNew = "is_new"
        case sellCount = "sell_count"
        case actualPrice = "actual_price"
        case price
    }
}

struct HomeModel {
    
    var lastId: Int = 0
    var wishItemArr: [Good] = []
}
