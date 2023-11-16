//
//  Receipt.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/16/23.
//

import Foundation

// MARK: - Receipt
struct Receipt: Codable {
    let createdDate, currencyCode: String?
    let id: Int
    let imgFileName: String
    let imgThumbnailURL, imgURL: String
    let lineItems: [LineItem]
    let ocrText: String
    let subtotal, tax, tip, total: Double
    let vendor: Vendor

    enum CodingKeys: String, CodingKey {
        case createdDate = "created_date"
        case currencyCode = "currency_code"
        case id
        case imgFileName = "img_file_name"
        case imgThumbnailURL = "img_thumbnail_url"
        case imgURL = "img_url"
        case lineItems = "line_items"
        case ocrText = "ocr_text"
        case subtotal, tax, tip, total, vendor
    }
}

// MARK: - Vendor
struct Vendor: Codable {
    let category: String?
    let name: String
}
