//
//  cameraView.swift
//  testingFlow
//
//  Created by joyce jiang on 11/13/23.
//

import Foundation
import SwiftUI
import AVFoundation

//This example creates a CameraView that is a UIViewControllerRepresentable wrapping a UIViewController. The AVCaptureSession is used to capture live video from the device's camera, and a simple AVCapturePhotoOutput is added to capture photos.

//Remember to add the necessary privacy permissions to your app's Info.plist file for camera access by adding the following:

//<key>NSCameraUsageDescription</key>
//<string>We need access to your camera to capture photos.</string>


struct CameraView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let imageData = photo.fileDataRepresentation(), let _ = UIImage(data: imageData) {
                // Handle the captured image (uiImage) here
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()

        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            return viewController
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
        } catch {
            return viewController
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = viewController.view.layer.bounds
        viewController.view.layer.addSublayer(previewLayer)

        let output = AVCapturePhotoOutput()
        captureSession.addOutput(output)

        captureSession.startRunning()

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update logic, if needed
    }
}


#Preview {
      CameraView()
}
