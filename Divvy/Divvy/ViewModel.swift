//
//  ViewModel.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/16/23.
//

import Foundation
import VeryfiSDK

class ViewModel: ObservableObject {
    let clientId = "vrfzjOIgSdzr7XcK9JFpeiprC2gxUtIs0rayi6e"
    let clientSecret = "Wf65yIsnhojOj2IkGZHV3ASYAkcvXcY9u8FapykLESFABtBKxMjvJAtftwMxUTuk4CMlXKY51MngaWOxiOspXBGUC3uHvhUogEEHjECBHBs55igwPkDwPhziuw46pPfd"
    let username = "afw2122"
    let apiKey = "e60612d2546792c313bd68636d7849b5"

    @Published var menuItems: [LineItem] = []
    @Published var restaurantName: String = ""
    @Published var tax: Double = 0.0
    @Published var tip: Double = 0.0
    @Published var total: Double = 0.0
    
    func loadData() {
        let client = Client(clientId: clientId, clientSecret: clientSecret, username: username, apiKey: apiKey)
        let file = "receipt"
        let url = Bundle(for: Self.self).url(forResource: file, withExtension: "jpeg")!
        let fileData = try? Data(contentsOf: url)
        client.processDocument(fileName: file, fileData: fileData!) { result in
            switch result {
            case .success(let data):
                do {
                    let receipt = try JSONDecoder().decode(Receipt.self, from: data)
                    self.restaurantName = receipt.vendor.name
                    self.tax = receipt.tax
                    self.tip = receipt.tip
                    self.total = receipt.total
                    for lineItem in receipt.lineItems {
                        self.menuItems.append(lineItem)
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
