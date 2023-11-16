//
//  CustomTabBarApp.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/6/23.
//

import SwiftUI

@main
struct CustomTabBarApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            NavBar(viewRouter: viewRouter)
        }
    }
}
