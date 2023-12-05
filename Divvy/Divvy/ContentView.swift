import SwiftUI
import Network

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showNetworkAlert = false
    @StateObject var viewRouter = ViewRouter()

    var body: some View {
        ZStack {
            if userData.loggedIn {
                NavBar(viewRouter: viewRouter)
                    .onAppear{
                        checkNetworkStatus()
                    }
                    .alert(isPresented: $showNetworkAlert) {
                        Alert(
                            title: Text("No Internet Connection"),
                            message: Text("Please ensure you are connected to the internet."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
            } else {
                SignInView()
                    .onAppear{
                        checkNetworkStatus()
                    }
                    .alert(isPresented: $showNetworkAlert) {
                        Alert(
                            title: Text("No Internet Connection"),
                            message: Text("Please ensure you are connected to the internet."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
            }
        }
    }
    private func checkNetworkStatus() {
        if !networkMonitor.isConnected {
            showNetworkAlert = true
        }
    }
}
