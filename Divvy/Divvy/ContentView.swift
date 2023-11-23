//
//  ContentView.swift
//  Divvy
//
//  Created by Test Account on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    @StateObject var viewRouter = ViewRouter()

    var body: some View {
        ZStack {
            if userData.loggedIn {
                NavBar(viewRouter: viewRouter)
            } else {
                SignInView()
            }
        }
    }
}


#Preview {
    ContentView()
}
