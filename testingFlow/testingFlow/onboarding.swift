//
//  onboarding.swift
//  testingFlow
//
//  Created by joyce jiang on 11/10/23.
//

import Foundation
import SwiftUI

struct onboarding: View {
    var body: some View{
        HStack(spacing: 0) {
            
//            ONBOARDING
            ZStack() {
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 163.32, height: 188.23)
                        .background(.white)
                        .cornerRadius(6.83)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.83)
                                .inset(by: -0.68)
                                .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.68)
                        )
                        .offset(x: 0, y: 0)
                        .rotationEffect(.degrees(-10.17))
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 5.47, y: 2.73
                        )
                    Text("November 8")
                        .font(Font.custom("SF Pro Display", size: 16.40))
                        .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
                        .offset(x: -29.03, y: -64.38)
                        .rotationEffect(.degrees(-10.17))
                    Text("OBAO")
                        .font(Font.custom("SF Pro Display", size: 16.40))
                        .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
                        .offset(x: -73.21, y: 68.56)
                        .rotationEffect(.degrees(-10.17))
                    HStack(alignment: .top, spacing: -13.66) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 32.79, height: 32.79)
                            .background(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/33x33"))
                            )
                            .cornerRadius(16.40)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 32.79, height: 32.79)
                            .background(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/33x33"))
                            )
                            .cornerRadius(68.32)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 32.79, height: 32.79)
                            .background(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/33x33"))
                            )
                            .cornerRadius(68.32)
                    }
                    .frame(width: 70.77, height: 32.74)
                    .offset(x: -53.02, y: 37.45)
                    .rotationEffect(.degrees(-10.17))
                }
                .frame(width: 163.32, height: 188.23)
                .offset(x: 58.71, y: -20.60)
                .rotationEffect(.degrees(-10.17))
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 163.35, height: 188.21)
                        .background(.white)
                        .cornerRadius(6.83)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.83)
                                .inset(by: -0.68)
                                .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.68)
                        )
                        .offset(x: 0, y: 0)
                        .rotationEffect(.degrees(17.93))
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 5.47, y: 2.73
                        )
                    Text("September")
                        .font(Font.custom("SF Pro Display", size: 17.59))
                        .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
                        .offset(x: -22.39, y: -70.81)
                        .rotationEffect(.degrees(17.93))
                    HStack(alignment: .top, spacing: -13.66) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 32.79, height: 32.79)
                            .background(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/33x33"))
                            )
                            .cornerRadius(16.40)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 32.79, height: 32.79)
                            .background(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/33x33"))
                            )
                            .cornerRadius(68.32)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 32.79, height: 32.79)
                            .background(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/33x33"))
                            )
                            .cornerRadius(68.32)
                    }
                    .frame(width: 70.78, height: 32.73)
                    .offset(x: 1.80, y: 27.11)
                    .rotationEffect(.degrees(17.93))
                }
                .frame(width: 163.35, height: 188.21)
                .offset(x: -56.14, y: 29.68)
                .rotationEffect(.degrees(17.93))
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 163.31, height: 188.24)
                    .background(.white)
                    .cornerRadius(6.83)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6.83)
                            .inset(by: -0.68)
                            .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.68)
                    )
                    .offset(x: -1.57, y: 7.63)
                    .rotationEffect(.degrees(6.01))
                    .shadow(
                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 5.47, y: 2.73
                    )
                Text("November 8")
                    .font(Font.custom("SF Pro Display", size: 17.59))
                    .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
                    .offset(x: -22.21, y: -59.67)
                    .rotationEffect(.degrees(6.01))
                Text("New divvy ✨")
                    .font(Font.custom("SF Pro Display", size: 8.80).weight(.medium))
                    .foregroundColor(.black)
                    .offset(x: -38.77, y: -39.19)
                    .rotationEffect(.degrees(6))
                Text("OBAO")
                    .font(Font.custom("SF Pro Display", size: 17.59))
                    .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
                    .offset(x: -30.03, y: 74.64)
                    .rotationEffect(.degrees(6.01))
                HStack(alignment: .top, spacing: -13.66) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 32.79, height: 32.79)
                        .background(
                            AsyncImage(url: URL(string: "https://via.placeholder.com/33x33"))
                        )
                        .cornerRadius(16.40)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 32.79, height: 32.79)
                        .background(
                            AsyncImage(url: URL(string: "https://via.placeholder.com/33x33"))
                        )
                        .cornerRadius(68.32)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 32.79, height: 32.79)
                        .background(
                            AsyncImage(url: URL(string: "https://via.placeholder.com/33x33"))
                        )
                        .cornerRadius(68.32)
                }
                .frame(width: 70.77, height: 32.74)
                .offset(x: -22.36, y: 42.41)
                .rotationEffect(.degrees(6.01))
            }
            .frame(minWidth: 275.62, maxWidth: 275.62, maxHeight: .infinity)
        }
        .frame(width: 275.62, height: 229.44)
        
//        LOGO AND ONELINER
        
        ZStack() {
            ZStack() { }
            .frame(width: 251.21, height: 88.97)
            .offset(x: 0.25, y: -22.58)
            Text("the new way to split the bill")
                .font(Font.custom("SF Pro Display", size: 25.12))
                .foregroundColor(.black)
                .offset(x: 0, y: 49.48)
        }
        .frame(width: 326.50, height: 134.13)
        
//        TEXT Input
        VStack(alignment: .leading, spacing: 6) {
            Text("enter your number")
                .font(Font.custom("SF Pro Display", size: 16).weight(.medium))
                .lineSpacing(20)
                .foregroundColor(Color(red: 0.68, green: 0.68, blue: 0.68))
            HStack(spacing: 16) {
                HStack(spacing: 0) {
                    Text("🇺🇸")
                        .font(Font.custom("SF Pro Display", size: 17))
                        .lineSpacing(22)
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.60))
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 2, height: 23)
                        .background(Color(red: 0, green: 0.48, blue: 1))
                        .cornerRadius(2)
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 6))
                .frame(maxWidth: .infinity, minHeight: 36, maxHeight: 36)
                .background(Color(red: 0.46, green: 0.46, blue: 0.50).opacity(0.12))
                .cornerRadius(10)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(width: 329, height: 62)
        
//        ENTER Button
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 284, height: 52)
            .background(Color(red: 0.26, green: 0.26, blue: 0.26))
            .cornerRadius(27.01)
    }
    
    
    
    
}

#Preview {
      onboarding()
}
