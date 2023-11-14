import SwiftUI

struct ContentView: View {
    @State private var image: UIImage?
    @State private var isCameraPresented = false

    var body: some View {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }

                Button("Scan Receipt") {
                    isCameraPresented = true
                }
                .sheet(isPresented: $isCameraPresented) {
                    CameraView(image: $image) {
                        // Placeholder for OCR processing
                        processImageForOCR(image)
                    }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

