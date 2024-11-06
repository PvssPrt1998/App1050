import SwiftUI

struct Tab: View {
    
    @State var selection: Int = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NoteView()
                .tag(0)
            AnalysisView()
                .tag(1)
            ProfileView()
                .tag(2)
            SettingsView()
                .tag(3)
        }
        .overlay(
            customBar
            , alignment: .bottom
            
        )
        .ignoresSafeArea()
    }
    
    private var customBar: some View {
        HStack(spacing: 0) {
            VStack(spacing: 4) {
                tabViewImage("play.fill")
                    .foregroundColor(.c038108)
                    .frame(width: 64, height: 32)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(selection == 0 ? Color.c164209255 : Color.white)
                    )
                Text("Note")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.c038108)
                    .frame(height: 16)
            }
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0))
            .frame(maxWidth: .infinity)
            .onTapGesture {
                selection = 0
            }
            VStack(spacing: 4) {
                tabViewImage("doc.plaintext")
                    .foregroundColor(.c038108)
                    .frame(width: 64, height: 32)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(selection == 1 ? Color.c164209255 : Color.white)
                    )
                
                Text("Analysis")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.c038108)
                    .frame(height: 16)
            }
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0))
            .frame(maxWidth: .infinity)
            .onTapGesture {
                selection = 1
            }
            VStack(spacing: 4) {
                tabViewImage("person.fill")
                    .foregroundColor(.c038108)
                    .frame(width: 64, height: 32)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(selection == 2 ? Color.c164209255 : Color.white)
                    )
                Text("Profile")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.c038108)
                    .frame(height: 16)
            }
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0))
            .frame(maxWidth: .infinity)
            .onTapGesture {
                selection = 2
            }
            VStack(spacing: 4) {
                tabViewImage("gear")
                    .foregroundColor(.c038108)
                    .frame(width: 64, height: 32)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(selection == 3 ? Color.c164209255 : Color.white)
                    )
                Text("Settings")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.c038108)
                    .frame(height: 16)
            }
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0))
            .frame(maxWidth: .infinity)
            .onTapGesture {
                selection = 3
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(Color.white)
    }
    
    @ViewBuilder func tabViewImage(_ systemName: String) -> some View {
        if #available(iOS 15.0, *) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
                .environment(\.symbolVariants, .none)
        } else {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
        }
    }
}

#Preview {
    Tab()
}

extension UIColor {
   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
   }
}

extension View {
    var bottomPadding: CGFloat {
        80
    }
}
