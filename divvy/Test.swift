import SwiftUI

struct TestView: View {
    // This state will eventually hold the image captured by the camera
    @State private var image: UIImage?

    var body: some View {
        VStack {
            // Logo
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            // Placeholder for camera view
            Rectangle()
                .foregroundColor(.gray)
                .aspectRatio(3/4, contentMode: .fit)
                .overlay(Text("Camera View").foregroundColor(.white))

            // Button that will be used to trigger the camera
            Button(action: {
                // This will be replaced with actual camera functionality
                print("Camera button tapped")
            }) {
                Text("Scan Receipt")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }

            // Displaying the captured image (for future use)
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .padding()
    }
}
