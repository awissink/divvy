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
                VStack {
                    Spacer()
                    switch viewRouter.currentPage {
                    case .home:
                        HomePage()
                    case .user:
                        Text("User")
                    // Remove cases for .camera and .photoUpload if not needed elsewhere
                    default:
                        EmptyView()
                    }
                    Spacer()

                    ZStack {
                        if showPopUp {
                            PlusMenu(widthAndHeight: geometry.size.width/7)
                                .offset(y: -geometry.size.height/6)
                        }

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
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//#Preview {
//    NavBar()
//}
//

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       NavBar(viewRouter: ViewRouter())
           .preferredColorScheme(.light)
   }
}

//struct PlusMenu: View {
//    let widthAndHeight: CGFloat
//    var onCameraSelected: () -> Void
//    var onPhotoUploadSelected: () -> Void
//
//    var body: some View {
//        HStack(spacing: 50) {
//            Button(action: onCameraSelected) {
//                ZStack {
//                    Circle()
//                        .foregroundColor(Color("ForestGreen"))
//                        .frame(width: widthAndHeight, height: widthAndHeight)
//                    Image(systemName: "camera")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(15)
//                        .frame(width: widthAndHeight, height: widthAndHeight)
//                        .foregroundColor(.white)
//                }
//            }
//
//            Button(action: onPhotoUploadSelected) {
//                ZStack {
//                    Circle()
//                        .foregroundColor(Color("ForestGreen"))
//                        .frame(width: widthAndHeight, height: widthAndHeight)
//                    Image(systemName: "folder")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(15)
//                        .frame(width: widthAndHeight, height: widthAndHeight)
//                        .foregroundColor(.white)
//                }
//            }
//        }
//        .transition(.scale)
//    }
//}

struct PlusMenu: View {
    let widthAndHeight: CGFloat

    var body: some View {
        HStack(spacing: 50) {
            NavigationLink(destination: CameraView()) {
                buttonContent(systemIconName: "camera")
            }

            NavigationLink(destination: PhotoUploadView()) {
                buttonContent(systemIconName: "folder")
            }
        }
        .transition(.scale)
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
