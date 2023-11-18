//
//  CameraView.swift
//  Divvy
//
//  Created by Test Account on 11/16/23.
//

import Foundation
import SwiftUI

struct CameraView: View {
    
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var image: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("upload_image")
                .resizable()
                    .frame(width: 300, height: 300)
                Button("Upload Photo"){
                    self.sourceType = .photoLibrary
                    self.showImagePicker = true
                }.padding()
                
                Spacer()
                Image("camera")
                .resizable()
                    .frame(width: 300, height: 300)
                Button("Take Photo"){
                    self.sourceType = .camera
                    self.showImagePicker = true
                }.padding()
                Spacer()
            }
            
            .navigationBarTitle("Camera Demo")
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

//#Preview {
//    CameraView()
//}
