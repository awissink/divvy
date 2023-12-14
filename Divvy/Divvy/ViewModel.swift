//
//  ViewModel.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/22/23.
//

import Foundation
import VeryfiSDK

class ViewModel: ObservableObject {
    // TODO: replace with actual API keys if testing
    let clientId = "secret"
    let clientSecret = "secret"
    let username = "secret"
    let apiKey = "secret"

    @Published var restaurantName: String = ""
    @Published var menuItems: [LineItem] = [] {
        didSet { recalculateTotal() }
    }
    @Published var tax: Double = 0.0 {
        didSet { recalculateTotal() }
    }
    @Published var tip: Double = 0.0 {
        didSet { recalculateTotal() }
    }
    @Published var lineItemsTotal: Double = 0.0
    @Published var total: Double = 0.0
    
    @Published var currReceipt: Receipt!
    
    private func recalculateTotal() {
        lineItemsTotal = menuItems.reduce(0) { $0 + $1.total }
        total = tax + tip + lineItemsTotal
    }
    
    func loadData(completion: @escaping (Bool) -> Void) {
        let client = Client(clientId: clientId, clientSecret: clientSecret, username: username, apiKey: apiKey)
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = "receipt"
        guard let fileURL = documentsDirectory?.appendingPathComponent(fileName) else {
                print("File URL is nil")
                return
        }
        guard let fileData = try? Data(contentsOf: fileURL) else {
                print("Failed to load data from \(fileURL)")
                return
        }
        client.processDocument(fileName: fileName, fileData: fileData) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let receipt = try JSONDecoder().decode(Receipt.self, from: data)
                        self.restaurantName = receipt.vendor.name
                        self.tax = receipt.tax ?? 0.0
                        self.tip = receipt.tip ?? 0.0
                        self.total = receipt.total ?? 0.0
                        for lineItem in receipt.lineItems {
                            self.lineItemsTotal += lineItem.total
                            self.menuItems.append(lineItem)
                        }
                        
                        //set currReceipt to receipt, which will be the populated receipt object
                        self.currReceipt = receipt
                        print("RECEIPT IS: ", self.currReceipt as Any)
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
                completion(true)
            }
        }
    }
}
