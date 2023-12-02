//
//  EmptyDivvy.swift
//  Divvy
//
//  Created by joyce jiang on 12/1/23.
//

import Foundation
import SwiftUI

struct EmptyDivvy: View{
    var body: some View{
        
        GeometryReader { geometry in
            //background
            RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9512709975, green: 1, blue: 0.930760324, alpha: 1)), Color(#colorLiteral(red: 0.7515366077, green: 0.8420163989, blue: 0.7321715951, alpha: 1))]), startPoint: .center, endPoint: .bottomTrailing))
                .rotation3DEffect(
                    Angle(
                        degrees: Double((geometry.frame(in: .global).minX - 15) / -20)
                    ),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .center,
                    anchorZ: 0.0,
                    perspective: 1.0
                )
                .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
            
            //content
            
            VStack {
                
                Text("No new Divvys")
                    .font(.system(size: 24))
                    .foregroundColor(.secondary)
                
            }
            .padding(24)
            .padding(.top, 100)
            .multilineTextAlignment(.center)
            .foregroundColor(.primary)
            .frame (maxWidth: .infinity, alignment: .center)
        }
        .frame(width: 220, height: 280)
        
    }
    
}


#Preview{
    EmptyDivvy()
}
