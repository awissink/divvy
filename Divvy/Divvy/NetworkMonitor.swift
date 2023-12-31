//
//  NetworkMonitor.swift
//  Divvy
//
//  Created by Hannah on 12/4/23.
// referenced code from: https://www.danijelavrzan.com/posts/2022/11/network-connection-alert-swiftui/

import Foundation
import SwiftUI
import Network

class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
