//
//  LineItem.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/22/23.
//

import Foundation

// MARK: - LineItem
struct LineItem: Codable, Identifiable {
    let description: String
    let id, order: Int
    var price: Double?
    var quantity: Int
    var total: Double
}

