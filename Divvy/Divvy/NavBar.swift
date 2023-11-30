//  NavBar.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/6/23.
//

import SwiftUI

struct NavBar: View {
    @StateObject var viewRouter: ViewRouter
    @State var showPopUp = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // Main content and Bottom bar
                    VStack {
                        // Main content based on viewRouter.currentPage
                        Spacer()
                        switch viewRouter.currentPage {
                        case .home:
                            HomePage()
                        case .user:
                            UserProfileView()
                        case .menu:
                            MenuView(viewRouter: viewRouter)
                        default:
                            EmptyView()
                        }
                        Spacer()

                        // Bottom Bar should always be visible except on the Menu page
                        if viewRouter.currentPage != .menu {
                            bottomBar(geometry: geometry)
                        }
                    }

                    // PlusMenu Popup, overlaying the content
                    if showPopUp {
                        PlusMenu(widthAndHeight: geometry.size.width/7, onImageSelected: {
                            viewRouter.currentPage = .menu
                        }, showPopUp: $showPopUp)
                        .position(x: geometry.size.width / 2, y: geometry.size.height - geometry.size.height/8 - geometry.size.width/7)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    @ViewBuilder
    private func bottomBar(geometry: GeometryProxy) -> some View {
        HStack {
            Spacer(minLength: 0)
            TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
            Spacer(minLength: 0)
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                    .shadow(radius: 4)
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/7-6, height: geometry.size.width/7-6)
                    .foregroundColor(Color("ForestGreen"))
                    .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
            }
            .offset(y: -geometry.size.height/8/2)
            .onTapGesture {
                withAnimation {
                    showPopUp.toggle()
                }
            }
            Spacer(minLength: 0)
            TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Account")
            Spacer(minLength: 0)
        }
        .frame(width: geometry.size.width, height: geometry.size.height/8)
        .background(Color("TabBarBackground").shadow(radius: 2))
    }
}

struct PlusMenu: View {
    //camera code begins
    
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var image: UIImage?
    @State private var isImageSelected = false

    
    //camera code ends
    
    let widthAndHeight: CGFloat
    var onImageSelected: (() -> Void)?
    @Binding var showPopUp: Bool

    var body: some View {
            HStack(spacing: 50) {
                cameraButton(systemIconName: "camera")
                photoUploadButton(systemIconName: "folder")
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$image, isShown: self.$showImagePicker, isImageSelected: self.$isImageSelected, sourceType: self.sourceType)
            }
            .onChange(of: isImageSelected) { newValue in
                if newValue {
                    onImageSelected?()  // Navigate to MenuView after selection
                    showPopUp = false  // Hide PlusMenu
                }
            }
            .background(Color.clear)
            .transition(.scale)
    }
    
    private func cameraButton(systemIconName: String) -> some View {
        Button(action: {
            self.sourceType = .camera
            self.showImagePicker = true
        }) {
            buttonContent(systemIconName: systemIconName)
        }
    }
    
    private func photoUploadButton(systemIconName: String) -> some View {
        Button(action: {
            self.sourceType = .photoLibrary
            self.showImagePicker = true
        }) {
            buttonContent(systemIconName: systemIconName)
        }
    }

    private func buttonContent(systemIconName: String) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color("ForestGreen"))
                .frame(width: widthAndHeight, height: widthAndHeight)
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(15)
                .frame(width: widthAndHeight, height: widthAndHeight)
                .foregroundColor(.white)
        }
    }
}



struct TabBarIcon: View {
   
   @StateObject var viewRouter: ViewRouter
   let assignedPage: Page
   
   let width, height: CGFloat
   let systemIconName, tabName: String

   var body: some View {
       VStack {
           Image(systemName: systemIconName)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: width, height: height)
               .padding(.top, 10)
           Text(tabName)
               .font(.footnote)
           Spacer()
       }
           .padding(.horizontal, -4)
           .onTapGesture {
               viewRouter.currentPage = assignedPage
           }
           .foregroundColor(viewRouter.currentPage == assignedPage ? Color("TabBarHighlight") : .gray)
   }
}
