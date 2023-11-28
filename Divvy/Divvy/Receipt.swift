//
//  Receipt.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/22/23.
//

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI
import FirebaseFirestore

// MARK: - Receipt
struct Receipt: Codable {
    let createdDate, currencyCode: String?
    let id: Int
    let imgFileName: String
    let imgThumbnailURL, imgURL: String
    var lineItems: [LineItem]
    let ocrText: String
    var subtotal, tax, tip, total: Double?
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

func sendReceipt(to recipientID: String, receipt: Receipt) {
    let db = Firestore.firestore()
    db.collection("receipts").document(recipientID).collection("received").addDocument(data: [
        "createdDate": receipt.createdDate!,
        "currencyCode": receipt.currencyCode!,
        "id": receipt.id,
        "imgFileName": receipt.imgFileName,
        "imgThumbnailURL": receipt.imgThumbnailURL,
        "imgURL": receipt.imgURL,
        "lineItems": receipt.lineItems,
        "ocrText": receipt.ocrText,
        "subtotal": receipt.subtotal!,
        "tax": receipt.tax!,
        "tip": receipt.tip!,
        "total": receipt.total!,
        "vendor": receipt.vendor
        // Other receipt data...
    ])
}

func listenForReceipts() {
    let currentUserID = Auth.auth().currentUser?.uid
    guard let userID = currentUserID else { return }
    
    let db = Firestore.firestore()
    db.collection("receipts").document(userID).collection("received").addSnapshotListener { querySnapshot, error in
        guard let documents = querySnapshot?.documents else {
            print("Error fetching documents: \(String(describing: error))")
            return
        }
        
        // processing received receipts
        for document in documents {
            let data = document.data()
            // make receipt objects from data and display/process them in the app
            let createdDate = data["createdDate"] as? String ?? ""
            let currencyCode = data["currencyCode"] as? String ?? ""
            let id = data["id"] as? Int ?? 0
            let imgFileName = data["imgFileName"] as? String ?? ""
            let imgThumbnailURL = data["imgThumbnailURL"] as? String ?? ""
            let imgURL = data["imgURL"] as? String ?? ""
            let lineItems = data["lineItems"] as? [LineItem] ?? []
            let ocrText = data["ocrText"] as? String ?? ""
            let subtotal = data["subtotal"] as? Double ?? 0.0
            let tax = data["tax"] as? Double ?? 0.0
            let tip = data["tip"] as? Double ?? 0.0
            let total = data["total"] as? Double ?? 0.0
            let vendor = data["vendor"] as? Vendor ?? nil
            
            let receivedReceipt = Receipt(
                createdDate: createdDate,
                currencyCode: currencyCode,
                id: id,
                imgFileName: imgFileName,
                imgThumbnailURL: imgThumbnailURL,
                imgURL: imgURL,
                lineItems: lineItems,
                ocrText: ocrText,
                subtotal: subtotal,
                tax: tax,
                tip: tip,
                total: total,
                vendor: vendor!
            )
        }
    }
}

// MARK: - Vendor
struct Vendor: Codable {
    let category: String?
    let name: String
}
