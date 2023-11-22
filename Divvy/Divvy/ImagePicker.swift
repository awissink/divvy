//
//  ImagePicker.swift
//  Divvy
//
//  Created by Test Account on 11/16/23.
//
// code referenced from tutorial: https://www.youtube.com/watch?v=Y-65T0YBOm4&ab_channel=azamsharp

import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    @Binding var isImageSelected: Bool
    
    init(image: Binding<UIImage?>, isShown: Binding<Bool>, isImageSelected: Binding<Bool>) {
        _image = image
        _isShown = isShown
        _isImageSelected = isImageSelected
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            saveImage(image: uiImage)
            isShown = false
            isImageSelected = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
    
    func saveImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1) ?? image.pngData() {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fileName = "receipt.jpeg"
            let fileURL = documentsDirectory?.appendingPathComponent(fileName)
            do {
                try imageData.write(to: fileURL!)
                print("Image Saved Successfully")
            } catch {
                print("Error Saving Image: \(error)")
            }
        }
    }

    
}

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    @Binding var isImageSelected: Bool
//    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var sourceType: UIImagePickerController.SourceType
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isShown: $isShown, isImageSelected: $isImageSelected)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
}
