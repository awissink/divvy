//
//  ContentView.swift
//  Divvy
//
//  Created by Test Account on 10/29/23.
//

import SwiftUI
import VeryfiSDK

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.restaurantName)
                .font(.title)
            List(viewModel.menuItems) { item in
                MenuItemView(menuItem: item)
            }
            .onAppear() {
                viewModel.loadData()
            }
            HStack {
                Text("Tax")
                Spacer()
                Text(String(viewModel.tax))
            }
            HStack {
                Text("Tip")
                Spacer()
                Text(String(viewModel.tip))
            }
            .padding()
            HStack {
                Text("Total")
                Spacer()
                Text(String(viewModel.total))
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
