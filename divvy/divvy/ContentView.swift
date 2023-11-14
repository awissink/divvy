import SwiftUI

struct ContentView: View {
    @State private var isCameraPresented = false
    @State private var image: UIImage?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("No image selected")
            }
            Button("Open Camera") {
                isCameraPresented = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .sheet(isPresented: $isCameraPresented) {
                CameraView(image: $image)
            }
        }
    }
}
