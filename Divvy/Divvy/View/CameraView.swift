import SwiftUI
import AVFoundation

struct CameraView: View {
    var body: some View {
        CameraScreenView()
    }
}

#Preview {
    CameraScreenView()
}

struct CameraScreenView: View {
    
    @StateObject var camera = CameraModel()
    
    var body: some View {
        
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                
                if camera.isTaken {
                    HStack {
                        Spacer()
                        
                        Button(action: camera.reTake, label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                            
                        })
                        .padding(.trailing, 10)
                    }
                }
                Spacer()
                
                HStack {
                    // if taken showing save and again take button
                    if camera.isTaken{
                        Button(action: {if !camera.isSaved{camera.savePic()}}, label: {
                            Text(camera.isSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                            
                        })
                        .padding(.leading)
                        Spacer()
                    } else {
                        Button(action: camera.takePic, label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear(perform: {
            camera.Check()
            
        })
    }
}

// Camera Model...

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var isSaved = false
    @Published var picData = Data(count: 0)

    func Check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            print("Camera access is already authorized.")
            setUp()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                DispatchQueue.main.async {
                    if status {
                        print("Camera access was just authorized.")
                        self.setUp()
                    } else {
                        print("Camera access denied by the user.")
                        self.alert = true
                    }
                }
            }
        case .denied:
            print("Camera access has been previously denied.")
            DispatchQueue.main.async {
                self.alert = true
            }
        default:
            print("Camera access is restricted or not available.")
            return
        }
    }

    func setUp() {
        do {
            self.session.beginConfiguration()
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                print("No suitable camera found.")
                return
            }
            let input = try AVCaptureDeviceInput(device: device)
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            } else {
                print("Cannot add input to the session.")
            }
            
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            } else {
                print("Cannot add output to the session.")
            }
            
            self.session.commitConfiguration()
            DispatchQueue.main.async {
                self.preview = AVCaptureVideoPreviewLayer(session: self.session)
                self.preview.videoGravity = .resizeAspectFill
                self.session.startRunning()
            }
        } catch {
            print("Camera setup failed with error: \(error.localizedDescription)")
        }
    }

    func takePic() {
        let settings = AVCapturePhotoSettings()
        self.output.capturePhoto(with: settings, delegate: self)
    }

    func reTake() {
        DispatchQueue.main.async {
            self.session.startRunning()
            self.isTaken = false
            self.isSaved = false
        }
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            return
        }

        guard let imageData = photo.fileDataRepresentation() else {
            print("No image data representation.")
            return
        }
        
        DispatchQueue.main.async {
            self.picData = imageData
            self.isTaken = true
            self.isSaved = true
            print("Photo captured and saved successfully.")
        }
    }

    func savePic() {
        guard let image = UIImage(data: self.picData) else {
            print("Could not convert data to UIImage.")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        print("Photo saved to photo album.")
    }
}


// setting view for preview...

struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera : CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        // Your Own Properties...
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        // starting session
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
