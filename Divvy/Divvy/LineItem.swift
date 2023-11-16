//
//  LineItem.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/16/23.
//

import Foundation

// MARK: - LineItem
struct LineItem: Codable, Identifiable {
    let description: String
    let id, order: Int
    let price: Double?
    let quantity: Int
    let total: Double
}
