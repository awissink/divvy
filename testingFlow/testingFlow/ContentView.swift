//
//  ContentView.swift
//  testingFlow
//
//  Created by joyce jiang on 11/8/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 28) {
      HStack(spacing: 0) {
        Text("No new Divvys to catch up on!")
          .font(Font.custom("SF Pro Display", size: 24))
          .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
      }
      .frame(maxWidth: .infinity, minHeight: 313, maxHeight: 313)
      ZStack() {
        HStack(spacing: 0) {
          Text("RECEIPTS")
            .font(Font.custom("SF Pro Display", size: 12).weight(.bold))
            .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        .frame(width: 106, height: 30)
        .offset(x: -135, y: -70)
        HStack(alignment: .top, spacing: 8) {
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 120, height: 138)
              .background(.white)
              .cornerRadius(5)
              .overlay(
                RoundedRectangle(cornerRadius: 5)
                  .inset(by: -0.50)
                  .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.50)
              )
              .offset(x: 0, y: 0)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 4, y: 2
              )
            Text("OBAO")
              .font(Font.custom("SF Pro Display", size: 12))
              .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
              .offset(x: -33.50, y: 50)
            HStack(alignment: .top, spacing: -10) {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(12)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(50)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(50)
            }
            .frame(width: 52, height: 24)
            .offset(x: -24, y: 27)
            VStack(alignment: .leading, spacing: 4) {
              Text("November 8")
                .font(Font.custom("SF Pro Display", size: 12))
                .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
              Text("✨ New divvy")
                .font(Font.custom("SF Pro Display", size: 12))
                .foregroundColor(Color(red: 0.92, green: 0.34, blue: 0.34))
            }
            .frame(width: 67, height: 32)
            .offset(x: -16.50, y: -40)
          }
          .frame(width: 120, height: 138)
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 120, height: 138)
              .background(.white)
              .cornerRadius(5)
              .overlay(
                RoundedRectangle(cornerRadius: 5)
                  .inset(by: -0.50)
                  .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.50)
              )
              .offset(x: 0, y: 0)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 4, y: 2
              )
            VStack(alignment: .leading, spacing: 4) {
              Text("November 1")
                .font(Font.custom("SF Pro Display", size: 12))
                .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
              Text("Completed")
                .font(Font.custom("SF Pro Display", size: 12))
                .foregroundColor(Color(red: 0.13, green: 0.59, blue: 0.33))
            }
            .frame(width: 61, height: 32.41)
            .offset(x: -19.50, y: -39.80)
            Text("Eye of Thai-Ger")
              .font(Font.custom("SF Pro Display", size: 12))
              .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
              .offset(x: -10.50, y: 50)
            HStack(alignment: .top, spacing: -10) {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(12)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(50)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(50)
            }
            .frame(width: 52, height: 24)
            .offset(x: -24, y: 27)
          }
          .frame(width: 120, height: 138)
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 120, height: 138)
              .background(.white)
              .cornerRadius(5)
              .overlay(
                RoundedRectangle(cornerRadius: 5)
                  .inset(by: -0.50)
                  .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.50)
              )
              .offset(x: 0, y: 0)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 4, y: 2
              )
            VStack(alignment: .leading, spacing: 4) {
              Text("October 31")
                .font(Font.custom("SF Pro Display", size: 12))
                .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
              Text("Completed")
                .font(Font.custom("SF Pro Display", size: 12))
                .foregroundColor(Color(red: 0.13, green: 0.59, blue: 0.33))
            }
            .frame(width: 57, height: 32.41)
            .offset(x: -21.50, y: -39.80)
            Text("Restaurant name")
              .font(Font.custom("SF Pro Display", size: 12))
              .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
              .offset(x: -7.50, y: 50)
            HStack(alignment: .top, spacing: -10) {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(12)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(50)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(50)
            }
            .frame(width: 52, height: 24)
            .offset(x: -24, y: 27)
          }
          .frame(width: 120, height: 138)
        }
        .frame(width: 376, height: 138)
        .offset(x: 0, y: 16)
      }
      ZStack() {
        HStack(spacing: 0) {
          Text("MY GROUPS")
            .font(Font.custom("SF Pro Display", size: 12).weight(.bold))
            .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        .frame(width: 106, height: 30)
        .offset(x: -135, y: -70)
        HStack(alignment: .top, spacing: 8) {
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 120, height: 138)
              .background(.white)
              .cornerRadius(5)
              .overlay(
                RoundedRectangle(cornerRadius: 5)
                  .inset(by: -0.50)
                  .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.50)
              )
              .offset(x: 0, y: 0)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 4, y: 2
              )
            Text("weekly thurs din")
              .font(Font.custom("SF Pro Display", size: 12))
              .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
              .offset(x: -9, y: 50)
            ZStack() {
              Ellipse()
                .foregroundColor(.clear)
                .frame(width: 84, height: 84)
                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                .offset(x: 0, y: 0)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 23.80, height: 23.80)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(70)
                .offset(x: 27.30, y: -0.70)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 22.40, height: 22.40)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/22x22"))
                )
                .cornerRadius(11.20)
                .offset(x: -14, y: 22.40)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 46.20, height: 46.20)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/46x46"))
                )
                .cornerRadius(96.25)
                .offset(x: -9.10, y: -13.30)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 23.80, height: 23.80)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(49.58)
                .offset(x: 13.30, y: 23.10)
            }
            .frame(width: 84, height: 84)
            .offset(x: -1, y: -14)
          }
          .frame(width: 120, height: 138)
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 120, height: 138)
              .background(.white)
              .cornerRadius(5)
              .overlay(
                RoundedRectangle(cornerRadius: 5)
                  .inset(by: -0.50)
                  .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.50)
              )
              .offset(x: 0, y: 0)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 4, y: 2
              )
            Text("trin, erin, chuck")
              .font(Font.custom("SF Pro Display", size: 12))
              .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
              .offset(x: -12, y: 50)
            ZStack() {
              Ellipse()
                .foregroundColor(.clear)
                .frame(width: 84, height: 84)
                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                .offset(x: 0, y: 0)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(50)
                .offset(x: -0, y: 26)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 46.20, height: 46.20)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/46x46"))
                )
                .cornerRadius(23.10)
                .offset(x: -8.90, y: -12.90)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(
                  AsyncImage(url: URL(string: "https://via.placeholder.com/24x24"))
                )
                .cornerRadius(50)
                .offset(x: 26, y: 8)
            }
            .frame(width: 84, height: 84)
            .offset(x: 0, y: -14)
          }
          .frame(width: 120, height: 138)
        }
        .frame(width: 376, height: 138)
        .offset(x: 0, y: 16)
      }
      .frame(height: 170)
    }
    .frame(width: 376, height: 709);
  }
}


#Preview {
    ContentView()
}
