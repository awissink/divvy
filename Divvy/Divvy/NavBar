import SwiftUI

struct NavBar: View {
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    // The viewRouter will decide which view to show based on the current page
                    switch viewRouter.currentPage {
                    case .home:
                        HomePage()
                    case .user:
                        Text("User")
                    default:
                        EmptyView()
                    }
                    Spacer()
                    
                    // Updated TabBar with even spacing
                    HStack {
                        Spacer() // Spacer before the first button
                        
                        // Home button
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "house", tabName: "Home")
                        
                        Spacer() // Spacer between buttons
                        
                        // Camera button
                        NavigationLink(destination: CameraView()) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                                .foregroundColor(Color("ForestGreen"))
                        }
                        .isDetailLink(false)
                        
                        Spacer() // Spacer between buttons
                        
                        // Account button
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Account")
                        
                        Spacer() // Spacer after the last button
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/8)
                    .background(Color("TabBarBackground").shadow(radius: 2))
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(viewRouter: ViewRouter())
            .preferredColorScheme(.light)
    }
}

struct PlusMenu: View {
    
    let widthAndHeight: CGFloat
    
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .foregroundColor(Color("ForestGreen"))
                    .frame(width: widthAndHeight, height: widthAndHeight)
                Image(systemName: "camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
            ZStack {
                Circle()
                    .foregroundColor(Color("ForestGreen"))
                    .frame(width: widthAndHeight, height: widthAndHeight)
                Image(systemName: "folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
        }
            .transition(.scale)
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
