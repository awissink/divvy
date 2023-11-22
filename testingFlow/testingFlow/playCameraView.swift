//
//  playCameraView.swift
//  testingFlow
//
//  Created by joyce jiang on 11/14/23.
//

import Foundation

// SwiftUI v4
import SwiftUI
import Charts
// original device rendered "iPhone 15 Pro" (393x852)
// used for scaling size values that are based on percentages.
let sw = UIScreen.main.bounds.width / 393
let sh = UIScreen.main.bounds.height / 852
// global constants
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaBottom = window?.safeAreaInsets.bottom
let safeAreaTop = window?.safeAreaInsets.top

struct playCameraView: View {
  var body: some View {
    ZStack(alignment: .leading) {
      ScrollView {
        Home()
      }.frame(minWidth: UIScreen.main.bounds.width, maxWidth: .infinity, minHeight: 1, maxHeight: 852, alignment: .topLeading)
        .background(Color.black.ignoresSafeArea())
      VStack(alignment: .leading) {
        ZStack {
          VStack(alignment: .leading) {
            HStack(alignment: .top) {
              Format()
              Spacer()
              Spacer()
            }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            Spacer()
            Spacer()
            Spacer()
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .zIndex(10)
          VStack(alignment: .leading) {
            HStack(alignment: .top) {
              Spacer()
              Spacer()
              Flash()
            }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            Spacer()
            Spacer()
            Spacer()
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .zIndex(10)
          VStack(alignment: .leading) {
            Spacer()
            Spacer()
            Spacer()
            HStack(alignment: .top) {
              Toolbar()
            }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .zIndex(10)
          VStack(alignment: .leading) {
            HStack(alignment: .top) {
              Histogram()
              Spacer()
              Spacer()
            }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            Spacer()
            Spacer()
            Spacer()
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .zIndex(6)
          VStack(alignment: .leading) {
            HStack(alignment: .top) {
              Spacer()
              Portrait_Badge()
              Spacer()
            }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            Spacer()
            Spacer()
            Spacer()
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .zIndex(10)
          VStack(alignment: .leading) {
            HStack(alignment: .top) {
              Spacer()
              Live_Badge()
              Spacer()
            }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            Spacer()
            Spacer()
            Spacer()
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .zIndex(10)
        }
      }.frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
        .ignoresSafeArea()
    }.frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
  }
  // component structs
  struct Home: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
              Viewer()
              Drawer()
            }.zIndex(4)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Spacer()
                Spacer()
                Sidebar()
              }.frame(width: .infinity, alignment: .topLeading)
              Spacer()
              Spacer()
            }.frame(width: .infinity, height: .infinity)
        .zIndex(5)
          }
        }
        // 100% x 100%
        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - safeAreaTop!, maxHeight: .infinity, alignment: .topLeading)
        .clipped()
    }
  }
  struct HEIC: View {
    var body: some View {
      Text("HEIC".uppercased())
        .textStyle(XS())
        .tracking(1.76)
        // 34 x 100%
        .frame(maxHeight: .infinity, alignment: .center)
        .frame(width: 34, alignment: .center)
        .clipped()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
    }
  }
  struct RAW: View {
    var body: some View {
      Text("RAW".uppercased())
        .textStyle(XS())
        .tracking(1.76)
        // 34 x 100%
        .frame(maxHeight: .infinity, alignment: .center)
        .frame(width: 34, alignment: .center)
        .clipped()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
    }
  }
  struct PRO_: View {
    var body: some View {
      Text("PRO+".uppercased())
        .textStyle(XS())
        .tracking(1.76)
        // 34 x 100%
        .frame(maxHeight: .infinity, alignment: .center)
        .frame(width: 34, alignment: .center)
        .clipped()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
    }
  }
  struct Format: View {
    var body: some View {
      VStack(alignment: .center, spacing: 8) {
          HEIC()
          RAW()
          PRO_()
        }
        // 64 x 32
        .frame(width: 64, height: 32, alignment: .top)
        .clipped()
        .background(.clear)
        .clipShape(RoundedRectangle(cornerRadius: 64, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 64, style: .continuous)
        .stroke(Color(#colorLiteral(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)), style: StrokeStyle(lineWidth: 1.2, lineJoin: .round)))
        .padding(.top, 16)
        .padding(.trailing, 16)
        .padding(.bottom, 16)
        .padding(.leading, 24)
    }
  }
  struct Flash: View {
    var body: some View {
      HStack(alignment: .top, spacing: 8) {
          Stack()
        }
        // Auto x Auto
        .frame(height: 32 * sh, alignment: .topLeading)
        .padding(.top, 16)
        .padding(.trailing, 24)
        .padding(.bottom, 16)
        .padding(.leading, 16)
    }
  }
  struct Icon: View {
    var body: some View {
      Image(systemName: "triangle")
        .font(.system(size: 16, weight: .regular))
        .imageScale(.small)
        .foregroundColor(.white)
        // 16 x 16
        .frame(width: 16, height: 16)
        .clipped()
    }
  }
  struct Stack: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
          Icon()
        }.padding(.top, 6)
        .padding(.trailing, 16)
        .padding(.bottom, 6)
        .padding(.leading, 16)
        // Auto x 32
        .frame(height: 32, alignment: .leading)
        .clipped()
        .background(.clear)
        .clipShape(RoundedRectangle(cornerRadius: 64, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 64, style: .continuous)
        .stroke(Color(#colorLiteral(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)), style: StrokeStyle(lineWidth: 1.2, lineJoin: .round)))
    }
  }
  struct B_W: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 100% x 100%
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0)
        .blendMode(.color)
    }
  }
  struct Viewer: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
          ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 8) {}.zIndex(0)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                B_W()
              }.frame(width: .infinity, alignment: .topLeading)
            }.frame(width: .infinity, height: .infinity)
        .zIndex(1)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Grid()
              }.frame(width: .infinity, alignment: .topLeading)
              Spacer()
              Spacer()
            }.frame(width: .infinity, height: .infinity)
        .zIndex(2)
          }
        }
        // 430 x 72%
        .frame(width: 430, height: 570.96 * sh, alignment: .topLeading)
        .clipped()
    }
  }
  struct Grid: View {
    var body: some View {
      ZStack(alignment: .leading) {
          Horizontal()
          Vertical()
        }
        // 100% x 86.9000015258789%
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 496.1642487121582 * sh, alignment: .topLeading)
        .clipped()
        .background(.clear)
        .opacity(0.45)
    }
  }
  struct Line: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 100% x 1
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 1, alignment: .topLeading)
        .clipped()
        .background(.white)
        .offset(y: 852 * 0.33)
    }
  }
  struct Line__1: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 100% x 1
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 1, alignment: .topLeading)
        .clipped()
        .background(.white)
        .offset(y: 852 * 0.66)
    }
  }
  struct Horizontal: View {
    var body: some View {
      VStack(alignment: .center, spacing: 0) {
          ZStack(alignment: .center) {
            VStack(alignment: .center, spacing: 0) {}.zIndex(0)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Line()
              }.frame(width: .infinity, alignment: .topLeading)
              Spacer()
              Spacer()
            }.frame(width: .infinity, height: .infinity)
        .zIndex(10)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Line__1()
              }.frame(width: .infinity, alignment: .topLeading)
              Spacer()
              Spacer()
            }.frame(width: .infinity, height: .infinity)
        .zIndex(10)
          }
        }
        // 393 x 852
        .frame(width: 393 * sw, height: 852, alignment: .center)
        .clipped()
    }
  }
  struct Line__2: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 1 x 852
        .frame(width: 1, height: 852, alignment: .topLeading)
        .clipped()
        .background(.white)
        .offset(x: 393 * 0.33)
    }
  }
  struct Line__3: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 1 x 852
        .frame(width: 1, height: 852, alignment: .topLeading)
        .clipped()
        .background(.white)
        .offset(x: 393 * 0.66)
    }
  }
  struct Vertical: View {
    var body: some View {
      HStack(alignment: .center, spacing: 130) {
          ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 130) {}.zIndex(0)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Line__2()
                Spacer()
                Spacer()
              }.frame(width: .infinity, alignment: .topLeading)
            }.frame(width: .infinity, height: .infinity)
        .zIndex(10)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Line__3()
                Spacer()
                Spacer()
              }.frame(width: .infinity, alignment: .topLeading)
            }.frame(width: .infinity, height: .infinity)
        .zIndex(10)
          }
        }
        // 393 x 852
        .frame(width: 393 * sw, height: 852, alignment: .center)
        .clipped()
    }
  }
  struct BG: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 393 x 78
        .frame(width: 393, height: 78, alignment: .topLeading)
        .clipped()
        .background(.black)
    }
  }
  struct Toolbar: View {
    var body: some View {
      VStack(alignment: .center, spacing: 0) {
          ZStack(alignment: .top) {
            VStack(alignment: .center, spacing: 0) {
              Scroll_Container()
            }.zIndex(1)
            VStack(alignment: .leading) {
              Spacer()
              Spacer()
              HStack(alignment: .top) {
                BG()
              }.frame(width: .infinity, alignment: .topLeading)
            }.frame(width: .infinity, height: 156)
        .zIndex(0)
          }
        }
        // 393 x 156
        .frame(width: 393, height: 156, alignment: .top)
        .clipped()
        .background(.clear)
        .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
        .offset(y: UIScreen.main.bounds.height * -0.26)
    }
  }
  struct Scroll_Container: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Row_1()
          Row_2()
        }
        // 393 x Auto
        .frame(width: 393, height: 158 * sh, alignment: .topLeading)
        .offset(y: 156 * 0.5)
    }
  }
  struct Row_1: View {
    var body: some View {
      HStack(alignment: .center, spacing: 0) {
          ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
              Icon__2()
              Spacer()
              Levels()
              Spacer()
              Icon__3()
            }.padding(.top, 16)
        .padding(.trailing, 12)
        .padding(.bottom, 12)
        .padding(.leading, 12)
        .zIndex(2)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Spacer()
                Grabber()
                Spacer()
              }.frame(width: .infinity, alignment: .topLeading)
              Spacer()
              Spacer()
            }.frame(width: .infinity, height: .infinity)
        .zIndex(10)
          }
        }
        // 393 x 80
        .frame(width: 393, height: 80, alignment: .center)
        .clipped()
        .background(LinearGradient(gradient: Gradient(stops: [.init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)), location: CGFloat(0)), .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.505)), location: CGFloat(0.9981825086805556))]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1)))
    }
  }
  struct Icon__1: View {
    var body: some View {
      Image(systemName: "cellularbars")
        .font(.system(size: 16, weight: .medium))
        .imageScale(.medium)
        .foregroundColor(.white)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
  struct Icon__2: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Icon__1()
        }
        // 32 x 32
        .frame(width: 32, height: 32, alignment: .topLeading)
        .clipped()
    }
  }
  struct Active: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 42 x 86%
        .frame(width: 42, height: 27.52 * sh, alignment: .topLeading)
        .clipped()
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
    }
  }
  struct Levels: View {
    var body: some View {
      HStack(alignment: .top, spacing: 0) {
          ZStack(alignment: .topLeading) {
            HStack(alignment: .top, spacing: 0) {
              _1()
              Spacer()
              _2()
              Spacer()
              _3()
            }.zIndex(3)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Spacer()
                Active()
                Spacer()
              }.frame(width: .infinity, alignment: .topLeading)
            }.frame(width: 138, height: .infinity)
        .zIndex(0)
          }
        }
        // Auto x 32
        .frame(height: 32, alignment: .topLeading)
        .clipped()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
  }
  struct Value: View {
    var body: some View {
      Text(".5×".uppercased())
        .textStyle(S())
        .tracking(1.20)
        // 100% x Fill Height
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(width: .infinity, height: (32 * sh), alignment: .center)
        .clipped()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
    }
  }
  struct _1: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Value()
        }
        // 46 x 32
        .frame(width: 46, height: 32, alignment: .topLeading)
    }
  }
  struct Value__1: View {
    var body: some View {
      Text("1×".uppercased())
        .textStyle(S())
        .tracking(1.20)
        // 46 x Auto
        .frame(width: 46, height: .infinity, alignment: .center)
        .clipped()
        .foregroundColor(.black)
        .multilineTextAlignment(.center)
    }
  }
  struct _2: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {}.zIndex(0)
            VStack(alignment: .leading) {
              Spacer()
              HStack(alignment: .top) {
                Value__1()
              }.frame(width: .infinity, alignment: .topLeading)
              Spacer()
            }.frame(width: .infinity, height: .infinity)
        .zIndex(10)
          }
        }
        // 46 x 38
        .frame(width: 46, height: 38, alignment: .topLeading)
    }
  }
  struct Value__2: View {
    var body: some View {
      Text("3×".uppercased())
        .textStyle(S())
        .tracking(1.20)
        // 100% x Fill Height
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(width: .infinity, height: (32 * sh), alignment: .center)
        .clipped()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
    }
  }
  struct _3: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Value__2()
        }
        // 46 x 38
        .frame(width: 46, height: 38, alignment: .topLeading)
    }
  }
  struct Icon__4: View {
    var body: some View {
      Image(systemName: "squareshape.split.2x2.dotted")
        .font(.system(size: 20, weight: .medium))
        .imageScale(.medium)
        .foregroundColor(.yellow)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
  struct Icon__3: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Icon__4()
        }
        // 32 x 32
        .frame(width: 32, height: 32, alignment: .topLeading)
        .clipped()
    }
  }
  struct LeftSide: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 16 x 4
        .frame(width: 16, height: 4, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(0, corners: [.topRight])
        .cornerRadius(0, corners: [.bottomRight])
        .cornerRadius(64, corners: [.bottomLeft])
        .cornerRadius(64, corners: [.topLeft])
    }
  }
  struct RightSide: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 16 x 4
        .frame(width: 16, height: 4, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(64, corners: [.topRight])
        .cornerRadius(64, corners: [.bottomRight])
        .cornerRadius(0, corners: [.bottomLeft])
        .cornerRadius(0, corners: [.topLeft])
    }
  }
  struct Grabber: View {
    var body: some View {
      HStack(alignment: .top, spacing: -4) {
          LeftSide()
          RightSide()
        }
        // Auto x Auto
        .frame(height: 4 * sh, alignment: .topLeading)
        .opacity(0.5)
        .offset(y: 6)
    }
  }
  struct Row_2: View {
    var body: some View {
      HStack(alignment: .center, spacing: 0) {
          Portrait()
          Spacer()
          B_W__1()
          Spacer()
          Flip()
          Spacer()
          Live()
        }.padding(12)
        // 393 x 78
        .frame(width: 393, height: 78, alignment: .center)
        .clipped()
        .background(.clear)
    }
  }
  struct Icon__5: View {
    var body: some View {
      Image(systemName: "cube.fill")
        .font(.system(size: 20, weight: .medium))
        .imageScale(.medium)
        .symbolRenderingMode(.hierarchical)
        .foregroundColor(.white)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
  struct Portrait: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Icon__5()
        }
        // 32 x 32
        .frame(width: 32, height: 32, alignment: .topLeading)
        .clipped()
    }
  }
  struct Icon__6: View {
    var body: some View {
      Image(systemName: "camera.filters")
        .font(.system(size: 20, weight: .medium))
        .imageScale(.medium)
        .foregroundColor(.white)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
  struct B_W__1: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Icon__6()
        }
        // 32 x 32
        .frame(width: 32, height: 32, alignment: .topLeading)
        .clipped()
    }
  }
  struct Icon__7: View {
    var body: some View {
      Image(systemName: "rotate.right.fill")
        .font(.system(size: 20, weight: .medium))
        .imageScale(.medium)
        .symbolRenderingMode(.hierarchical)
        .foregroundColor(.white)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
  struct Flip: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Icon__7()
        }
        // 32 x 32
        .frame(width: 32, height: 32, alignment: .topLeading)
        .clipped()
    }
  }
  struct Icon__8: View {
    var body: some View {
      Image(systemName: "livephoto")
        .font(.system(size: 20, weight: .medium))
        .imageScale(.medium)
        .foregroundColor(.white)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
  struct Live: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
              Icon__8()
            }.zIndex(0)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Slash_Container()
              }.frame(width: .infinity, alignment: .topLeading)
            }.frame(width: .infinity, height: .infinity)
        .zIndex(1)
          }
        }
        // 32 x 32
        .frame(width: 32, height: 32, alignment: .topLeading)
        .clipped()
    }
  }
  struct Stack_2: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 2 x 0
        .frame(width: 2, alignment: .topLeading)
        .clipped()
        .background(.red)
        .rotation3DEffect(.degrees(-38), axis: (x: 0, y: 0, z: 1), perspective: 0.5)
    }
  }
  struct Slash_Container: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {}.zIndex(0)
            VStack(alignment: .leading) {
              Spacer()
              HStack(alignment: .top) {
                Spacer()
                Stack_2()
                Spacer()
              }.frame(width: .infinity, alignment: .topLeading)
              Spacer()
            }.frame(width: .infinity, height: .infinity)
        .zIndex(0)
          }
        }
        // 100% x 100%
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .clipped()
        .background(.clear)
    }
  }
  struct Divider: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 393 x 1
        .frame(width: 393, height: 1, alignment: .topLeading)
        .clipped()
        .background(Color(#colorLiteral(red: 0.09, green: 0.094, blue: 0.094, alpha: 1)))
    }
  }
  struct Noise: View {
    var body: some View {
      AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3c5ef63a27e0e0yykOq.png?alt=media&token=a79a2deb-6731-447b-9cb7-c179fc7d2842")) {
        image in image.resizable()
        .scaledToFill()
          // 393 x Fill Height
          .frame(width: 393, height: (222.03999999999996 * sh))
        .clipped()
        .background(Color(#colorLiteral(red: 0.73, green: 0.73, blue: 0.73, alpha: 0.20)))
        .aspectRatio(contentMode: .fill)
        .clipped()
      }
      placeholder: {
        Image(systemName: "photo")
        .foregroundColor(Color.gray)
        // 393 x Fill Height
        .frame(width: 393, height: (222.03999999999996 * sh))
        .clipped()
        .background(Color(#colorLiteral(red: 0.73, green: 0.73, blue: 0.73, alpha: 0.20)))
      }.opacity(0.7)
    }
  }
  struct Drawer: View {
    var body: some View {
      VStack(alignment: .center, spacing: 24) {
          ZStack(alignment: .top) {
            VStack(alignment: .center, spacing: 24) {
              Slider_sha()
              Actions()
            }.padding(.top, 24)
        .zIndex(3)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Divider()
              }.frame(width: .infinity, alignment: .topLeading)
              Spacer()
              Spacer()
            }.frame(width: .infinity, height: .infinity)
        .zIndex(10)
            VStack(alignment: .leading) {
              HStack(alignment: .top) {
                Noise()
              }.frame(width: .infinity, alignment: .topLeading)
            }.frame(width: .infinity, height: .infinity)
        .zIndex(1)
          }
        }
        // 393 x 759
        .frame(width: 393 * sw, height: 759, alignment: .top)
        .clipped()
        .background(Color(#colorLiteral(red: 0.039, green: 0.039, blue: 0.039, alpha: 1)))
    }
  }
  struct Dot: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 3 x 3
        .frame(width: 3, height: 3, alignment: .topLeading)
        .clipped()
        .background(.yellow)
        .cornerRadius(64)
        .offset(y: 2)
    }
  }
  struct Slider_sha: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
              Depth()
            }.zIndex(1)
            VStack(alignment: .leading) {
              Spacer()
              Spacer()
              HStack(alignment: .top) {
                Spacer()
                Dot()
                Spacer()
              }.frame(width: .infinity, alignment: .topLeading)
            }.frame(width: .infinity, height: .infinity)
        .zIndex(10)
          }
        }
        // 0 x 34
        .frame(height: 34, alignment: .topLeading)
    }
  }
  struct Spacer_l3c: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 48.599998474121094% x 24
        .frame(width: 190.9979940032959 * sw, height: 24, alignment: .topLeading)
        .clipped()
    }
  }
  struct Spacer_gsa: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 49% x 24
        .frame(width: 192.57 * sw, height: 24, alignment: .topLeading)
        .clipped()
    }
  }
  struct Depth: View {
    var body: some View {
      ScrollView(.horizontal, showsIndicators: true) {
          HStack(alignment: .top, spacing: 0) {
            Spacer_l3c()
            Tics()
            Spacer_gsa()
          }.frame(maxHeight: .infinity, alignment: .top)
        }
        // 393% x Auto
        .frame(width: 393 * sw, height: 24 * sh, alignment: .topLeading)
        .background(.clear)
    }
  }
  struct Tics: View {
    var body: some View {
      HStack(alignment: .top, spacing: 0) {
          Group {
            _5_tics()
            _5_tics__1()
            _5_tics__2()
            _5_tics__3()
            _5_tics__4()
            _5_tics__5()
            _5_tics__6()
            _5_tics__7()
            _5_tics__8()
            _5_tics__9()
          }
          Group {
            _5_tics__10()
            _5_tics__11()
            _5_tics__12()
            _5_tics__13()
            _5_tics__14()
            _5_tics__15()
            _5_tics__16()
            _5_tics__17()
            _5_tics__18()
            _5_tics__19()
          }
        }
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .topLeading)
        .clipped()
        .background(.clear)
        .offset(x: 1)
    }
  }
  struct tic___1s: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__1: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__2: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__3: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s()
          tic___1s__1()
          tic___5s()
          tic___1s__2()
          tic___1s__3()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__4: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__5: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__1: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__6: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__7: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__1: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__4()
          tic___1s__5()
          tic___5s__1()
          tic___1s__6()
          tic___1s__7()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__8: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__9: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__2: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__10: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__11: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__2: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__8()
          tic___1s__9()
          tic___5s__2()
          tic___1s__10()
          tic___1s__11()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__12: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__13: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__3: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__14: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__15: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__3: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__12()
          tic___1s__13()
          tic___5s__3()
          tic___1s__14()
          tic___1s__15()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__16: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__17: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__4: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__18: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__19: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__4: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__16()
          tic___1s__17()
          tic___5s__4()
          tic___1s__18()
          tic___1s__19()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__20: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__21: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__5: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__22: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__23: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__5: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__20()
          tic___1s__21()
          tic___5s__5()
          tic___1s__22()
          tic___1s__23()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__24: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__25: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__6: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__26: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__27: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__6: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__24()
          tic___1s__25()
          tic___5s__6()
          tic___1s__26()
          tic___1s__27()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__28: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__29: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__7: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__30: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__31: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__7: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__28()
          tic___1s__29()
          tic___5s__7()
          tic___1s__30()
          tic___1s__31()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__32: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__33: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__8: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__34: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__35: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__8: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__32()
          tic___1s__33()
          tic___5s__8()
          tic___1s__34()
          tic___1s__35()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__36: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__37: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__9: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__38: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__39: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__9: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__36()
          tic___1s__37()
          tic___5s__9()
          tic___1s__38()
          tic___1s__39()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__40: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__41: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__10: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__42: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__43: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__10: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__40()
          tic___1s__41()
          tic___5s__10()
          tic___1s__42()
          tic___1s__43()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__44: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__45: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__11: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__46: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__47: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__11: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__44()
          tic___1s__45()
          tic___5s__11()
          tic___1s__46()
          tic___1s__47()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__48: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__49: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__12: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__50: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__51: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__12: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__48()
          tic___1s__49()
          tic___5s__12()
          tic___1s__50()
          tic___1s__51()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__52: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__53: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__13: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__54: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__55: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__13: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__52()
          tic___1s__53()
          tic___5s__13()
          tic___1s__54()
          tic___1s__55()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__56: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__57: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__14: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__58: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__59: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__14: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__56()
          tic___1s__57()
          tic___5s__14()
          tic___1s__58()
          tic___1s__59()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__60: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__61: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__15: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__62: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__63: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__15: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__60()
          tic___1s__61()
          tic___5s__15()
          tic___1s__62()
          tic___1s__63()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__64: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__65: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__16: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__66: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__67: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__16: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__64()
          tic___1s__65()
          tic___5s__16()
          tic___1s__66()
          tic___1s__67()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__68: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__69: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__17: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__70: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__71: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__17: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__68()
          tic___1s__69()
          tic___5s__17()
          tic___1s__70()
          tic___1s__71()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__72: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__73: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__18: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__74: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__75: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__18: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__72()
          tic___1s__73()
          tic___5s__18()
          tic___1s__74()
          tic___1s__75()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct tic___1s__76: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__77: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___5s__19: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 24
        .frame(width: 1.5, height: 24, alignment: .topLeading)
        .clipped()
        .background(.white)
        .cornerRadius(4)
    }
  }
  struct tic___1s__78: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct tic___1s__79: View {
    var body: some View {
      ZStack(alignment: .leading) {}
        // 1.5 x 16
        .frame(width: 1.5, height: 16, alignment: .topLeading)
        .clipped()
        .background(.white)
        .opacity(0.5)
        .cornerRadius(4)
    }
  }
  struct _5_tics__19: View {
    var body: some View {
      HStack(alignment: .bottom, spacing: 8) {
          tic___1s__76()
          tic___1s__77()
          tic___5s__19()
          tic___1s__78()
          tic___1s__79()
        }.padding(.trailing, 4)
        .padding(.leading, 4)
        // Auto x Auto
        .frame(height: 24 * sh, alignment: .bottomLeading)
        .clipped()
    }
  }
  struct Actions: View {
    var body: some View {
      HStack(alignment: .center, spacing: 0) {
          ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
              Recents()
              Spacer()
              Zoom()
            }.padding(.trailing, 16)
        .padding(.leading, 16)
        .zIndex(2)
            VStack(alignment: .leading) {
              Spacer()
              HStack(alignment: .top) {
                Spacer()
                Shutter()
                Spacer()
              }.frame(width: .infinity, alignment: .topLeading)
              Spacer()
            }.frame(width: .infinity, height: .infinity)
        .zIndex(10)
          }
        }
        // 100% x 92
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 92, alignment: .center)
        .background(.clear)
    }
  }
  struct Last_Photo: View {
    var body: some View {
      AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1533460004989-cef01064af7e?ixid=M3w4OTk0OHwwfDF8c2VhcmNofDF8fEdyYXNzfGVufDB8fHx8MTY5OTM2MDk1MHww&ixlib=rb-4.0.3")) {
        image in image.resizable()
        .scaledToFill()
          // 393 x Fill Height
          .frame(width: 393, height: (68 * sh))
        .clipped()
        .background(Color(#colorLiteral(red: 0.73, green: 0.73, blue: 0.73, alpha: 0.20)))
        .aspectRatio(contentMode: .fill)
        .clipped()
      }
      placeholder: {
        Image(systemName: "photo")
        .foregroundColor(Color.gray)
        // 393 x Fill Height
        .frame(width: 393, height: (68 * sh))
        .clipped()
        .background(Color(#colorLiteral(red: 0.73, green: 0.73, blue: 0.73, alpha: 0.20)))
      }.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
  }
  struct Recents: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
          Last_Photo()
        }.padding(4)
        // 76 x 76
        .frame(width: 76, height: 76, alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
        .stroke(Color(#colorLiteral(red: 0.22, green: 0.22, blue: 0.22, alpha: 1)), style: StrokeStyle(lineWidth: 3, lineJoin: .round)))
    }
  }
  struct Inner: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {}
        // 100% x 100%
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .clipped()
        .background(LinearGradient(gradient: Gradient(stops: [.init(color: Color(#colorLiteral(red: 0.849, green: 0.849, blue: 0.849, alpha: 1)), location: CGFloat(0)), .init(color: Color(#colorLiteral(red: 0.731, green: 0.731, blue: 0.731, alpha: 1)), location: CGFloat(1))]), startPoint: UnitPoint(x: 0.5, y: 0.3), endPoint: UnitPoint(x: 0.5, y: 0.7)))
        .cornerRadius(64)
    }
  }
  struct Shutter: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Inner()
        }.padding(5)
        // 80 x 80
        .frame(width: 80, height: 80, alignment: .topLeading)
        .clipped()
        .background(.clear)
        .cornerRadius(64)
        .overlay(RoundedRectangle(cornerRadius: 64)
        .stroke(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), style: StrokeStyle(lineWidth: 4, lineJoin: .round))
        .opacity(0.4))
    }
  }
  struct Icon__9: View {
    var body: some View {
      Image(systemName: "arrow.triangle.2.circlepath")
        .font(.system(size: 20, weight: .medium))
        .imageScale(.medium)
        .foregroundColor(.white)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
  struct Zoom: View {
    var body: some View {
      VStack(alignment: .center, spacing: 0) {
          Icon__9()
        }
        // 56 x 56
        .frame(width: 56, height: 56, alignment: .center)
        .clipped()
        .background(Color(#colorLiteral(red: 0.094, green: 0.098, blue: 0.094, alpha: 1)))
        .cornerRadius(64)
        .overlay(RoundedRectangle(cornerRadius: 64)
        .stroke(Color(#colorLiteral(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)), style: StrokeStyle(lineWidth: 1, lineJoin: .round))
        .opacity(0.2))
    }
  }
  struct Sidebar: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
          Modes()
        }
        // Auto x Auto
        .frame(height: 258 * sh, alignment: .topLeading)
        .clipped()
        .background(.clear)
        .opacity(0)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .scaleEffect(0.85)
        .padding(.top, 72)
        .padding(.trailing, 16)
        .padding(.bottom, 24)
        .padding(.leading, 24)
        .offset(x: UIScreen.main.bounds.width * 0.25)
    }
  }
  struct Modes: View {
    var body: some View {
      VStack(alignment: .center, spacing: 0) {
          Auto()
          Spacer()
          On()
          Spacer()
          Off()
        }
        // Auto x Auto
        .frame(height: 258 * sh, alignment: .center)
        .clipped()
        .background(.thinMaterial)
        .background(.clear)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
  }
  struct Icon__10: View {
    var body: some View {
      Image(systemName: "bolt.badge.a.fill")
        .font(.system(size: 20, weight: .regular))
        .imageScale(.large)
        .foregroundColor(.yellow)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
    struct `Type`: View {
    var body: some View {
      Text("Auto".uppercased())
        .textStyle(S())
        .tracking(1.20)
        .foregroundColor(.yellow)
        .multilineTextAlignment(.leading)
    }
  }
  struct Auto: View {
    var body: some View {
      VStack(alignment: .center, spacing: 8) {
          Icon__10()
          Type()
        }.padding(.top, 16)
        .padding(.trailing, 24)
        .padding(.bottom, 16)
        .padding(.leading, 24)
        // Auto x Auto
        .frame(height: 86 * sh, alignment: .center)
        .clipped()
    }
  }
  struct Icon__11: View {
    var body: some View {
      Image(systemName: "bolt.fill")
        .font(.system(size: 20, weight: .regular))
        .imageScale(.large)
        .foregroundColor(.white)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
  struct Type__1: View {
    var body: some View {
      Text("On".uppercased())
        .textStyle(S())
        .tracking(1.20)
        .foregroundColor(.white)
        .multilineTextAlignment(.leading)
    }
  }
  struct On: View {
    var body: some View {
      VStack(alignment: .center, spacing: 8) {
          Icon__11()
          Type__1()
        }.padding(.top, 16)
        .padding(.trailing, 24)
        .padding(.bottom, 16)
        .padding(.leading, 24)
        // Auto x Auto
        .frame(height: 86 * sh, alignment: .center)
        .clipped()
    }
  }
  struct Icon__12: View {
    var body: some View {
      Image(systemName: "bolt.fill")
        .font(.system(size: 20, weight: .regular))
        .imageScale(.large)
        .foregroundColor(.white)
        // 32 x 32
        .frame(width: 32, height: 32)
        .clipped()
    }
  }
  struct Type__2: View {
    var body: some View {
      Text("Auto".uppercased())
        .textStyle(S())
        .tracking(1.20)
        .foregroundColor(.white)
        .multilineTextAlignment(.leading)
    }
  }
  struct Off: View {
    var body: some View {
      VStack(alignment: .center, spacing: 8) {
          Icon__12()
          Type__2()
        }.padding(.top, 16)
        .padding(.trailing, 24)
        .padding(.bottom, 16)
        .padding(.leading, 24)
        // Auto x Auto
        .frame(height: 86 * sh, alignment: .center)
        .clipped()
    }
  }
  struct Chart: View {
    private   var chartData_zr8: [PlayChartPoint] = [.init(x: 0.00, y: 154.24, category: "Item 1"), .init(x: 1.00, y: 112.93, category: "Item 1"), .init(x: 2.00, y: 111.79, category: "Item 1"), .init(x: 3.00, y: 136.09, category: "Item 1"), .init(x: 4.00, y: 123.47, category: "Item 1"), .init(x: 5.00, y: 128.44, category: "Item 1"), .init(x: 6.00, y: 105.54, category: "Item 1"), .init(x: 7.00, y: 168.55, category: "Item 1"), .init(x: 8.00, y: 138.34, category: "Item 1"), .init(x: 9.00, y: 77.77, category: "Item 1"), .init(x: 10.00, y: 136.76, category: "Item 1"), .init(x: 0.00, y: 114.99, category: "Item 2"), .init(x: 1.00, y: 120.66, category: "Item 2"), .init(x: 2.00, y: 123.67, category: "Item 2"), .init(x: 3.00, y: 149.61, category: "Item 2"), .init(x: 4.00, y: 170.61, category: "Item 2"), .init(x: 5.00, y: 141.54, category: "Item 2"), .init(x: 6.00, y: 117.64, category: "Item 2"), .init(x: 7.00, y: 146.56, category: "Item 2"), .init(x: 8.00, y: 174.68, category: "Item 2"), .init(x: 9.00, y: 135.51, category: "Item 2"), .init(x: 10.00, y: 152.37, category: "Item 2"), .init(x: 0.00, y: 162.31, category: "Item 3"), .init(x: 1.00, y: 121.00, category: "Item 3"), .init(x: 2.00, y: 143.28, category: "Item 3"), .init(x: 3.00, y: 167.58, category: "Item 3"), .init(x: 4.00, y: 155.06, category: "Item 3"), .init(x: 5.00, y: 160.03, category: "Item 3"), .init(x: 6.00, y: 119.08, category: "Item 3"), .init(x: 7.00, y: 182.09, category: "Item 3"), .init(x: 8.00, y: 213.99, category: "Item 3"), .init(x: 9.00, y: 153.43, category: "Item 3"), .init(x: 10.00, y: 159.07, category: "Item 3"), .init(x: 0.00, y: 135.87, category: "Item 4"), .init(x: 1.00, y: 131.09, category: "Item 4"), .init(x: 2.00, y: 133.30, category: "Item 4"), .init(x: 3.00, y: 130.71, category: "Item 4"), .init(x: 4.00, y: 132.16, category: "Item 4"), .init(x: 5.00, y: 132.51, category: "Item 4"), .init(x: 6.00, y: 146.58, category: "Item 4"), .init(x: 7.00, y: 155.56, category: "Item 4"), .init(x: 8.00, y: 135.53, category: "Item 4"), .init(x: 9.00, y: 204.83, category: "Item 4"), .init(x: 10.00, y: 137.44, category: "Item 4"), .init(x: 0.00, y: 231.55, category: "Item 5"), .init(x: 1.00, y: 125.97, category: "Item 5"), .init(x: 2.00, y: 161.56, category: "Item 5"), .init(x: 3.00, y: 122.64, category: "Item 5"), .init(x: 4.00, y: 149.33, category: "Item 5"), .init(x: 5.00, y: 132.76, category: "Item 5"), .init(x: 6.00, y: 137.03, category: "Item 5"), .init(x: 7.00, y: 257.78, category: "Item 5"), .init(x: 8.00, y: 135.76, category: "Item 5"), .init(x: 9.00, y: 266.16, category: "Item 5"), .init(x: 10.00, y: 138.60, category: "Item 5")]
    var body: some View {
      Chart {
        ForEach(chartData_zr8) {
          item in BarMark(x: .value("x", item.x), y: .value("y", item.y), stacking: .standard)
        .foregroundStyle(by: .value("Category", item.category))
        }
      }.chartForegroundStyleScale(domain: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"], range: [.black, .black, .black, .black, .black])
        .chartXAxis {
          AxisMarks(content: {
            value in
          })
        }.chartYAxis {
          AxisMarks(position: .leading, content: {
            value in
          })
        }.chartLegend(.hidden)
        // 119 x 64
        .frame(width: 119, height: 64)
    }
  }
  struct Histogram: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
          Chart()
        }
        // 25.950000762939453% x 52
        .frame(width: 101.98350299835205 * sw, height: 52, alignment: .topLeading)
        .clipped()
        .background(.thinMaterial)
        .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
        .stroke(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), style: StrokeStyle(lineWidth: 1, lineJoin: .round))
        .opacity(0.1))
        .offset(x: UIScreen.main.bounds.width * 0.03, y: UIScreen.main.bounds.height * 0.7)
    }
  }
  struct Content: View {
    var body: some View {
      Text("Portrait Mode On".uppercased())
        .textStyle(S())
        .tracking(1.20)
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: false, vertical: true)
    }
  }
  struct Portrait_Badge: View {
    var body: some View {
      VStack(alignment: .center, spacing: 8) {
          Content()
        }.padding(12)
        // Auto x Auto
        .frame(height: 38 * sh, alignment: .top)
        .clipped()
        .background(.thinMaterial)
        .background(.clear)
        .opacity(0)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
        .stroke(Color(#colorLiteral(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)), style: StrokeStyle(lineWidth: 1.2, lineJoin: .round))
        .opacity(0))
        .offset(y: UIScreen.main.bounds.height * 0.06)
    }
  }
  struct Content__1: View {
    var body: some View {
      Text("Live Off".uppercased())
        .textStyle(S())
        .tracking(1.20)
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: false, vertical: true)
    }
  }
  struct Live_Badge: View {
    var body: some View {
      VStack(alignment: .center, spacing: 8) {
          Content__1()
        }.padding(12)
        // Auto x Auto
        .frame(height: 38 * sh, alignment: .top)
        .clipped()
        .background(.thinMaterial)
        .background(.clear)
        .opacity(0)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
        .stroke(Color(#colorLiteral(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)), style: StrokeStyle(lineWidth: 1.2, lineJoin: .round))
        .opacity(0))
        .offset(y: UIScreen.main.bounds.height * 0.06)
    }
  }
  // custom structs required by some components not fully supported in SwiftUI
  struct XS: ViewModifier {
    func body(content: Self.Content) -> some View {
      content.lineSpacing(0.79)
        // Add your custom fonts to XCode and swap these lines.
        // .font(Font.custom("SpaceGrotesk-Medium", size: 11)
        .font(Font.system(size: 11)
        .weight(.medium))
    }
  }
  struct S: ViewModifier {
    func body(content: Self.Content) -> some View {
      content.lineSpacing(0.86)
        // Add your custom fonts to XCode and swap these lines.
        // .font(Font.custom("SpaceGrotesk-Medium", size: 12)
        .font(Font.system(size: 12)
        .weight(.medium))
    }
  }
  struct PlayChartPoint: Identifiable {
    var x: Double
    var y: Double
    var category: String
    var id = UUID()
  }
}
// extensions
extension Text {
  func textStyle < Style: ViewModifier > (_ style: Style) -> some View {
    ModifiedContent(content: self, modifier: style)
  }
}
// Enables setting individual vales per corner
struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}
extension View {
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}
// optional preview provider (renders a device preview in XCode)
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
        playCameraView()
        .ignoresSafeArea(.all, edges: [.bottom])
    }
  }
}
