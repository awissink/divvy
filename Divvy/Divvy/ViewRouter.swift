//
//  ViewRouter.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/6/23.
//


import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .home
    
    func navigateTo(_ page: Page) {
            currentPage = page
        }
}


enum Page {
    case home
    case menu
    case camera
    case photoUpload
    case user
}
