//
//  ViewModel.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/22/23.
//

import Foundation
import VeryfiSDK

class ViewModel: ObservableObject {
    let clientId = "vrfrFmw2P8hgakFhhvaMO9gHKSc4Rg9yH0vAElW"
    let clientSecret = "Er4f1OgYdiOLytIflcMjy3Ax4eDjNyEWCTwcKGJlzM75P4RhpsYlYlKzT6mXmjTvmZf3c7p0vNnALM3cCZG6nCTBm3W5gz8vYlWINrGH1IX0etsDO12G7YzEMpuLpwUV"
    let username = "amelia4"
    let apiKey = "69415cd7ce03189c57f9732504d0c3db"

    @Published var menuItems: [LineItem] = []
    @Published var restaurantName: String = ""
    @Published var tax: Double = 0.0
    @Published var tip: Double = 0.0
    @Published var total: Double = 0.0
    
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
                            self.menuItems.append(lineItem)
                        }
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
