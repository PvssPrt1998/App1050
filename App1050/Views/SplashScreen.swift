import SwiftUI

struct Splash: View {
    
    @State var rotationValue: Double = 0
    @Binding var showSplash: Bool
    let dc: DC
    
    var body: some View {
        ZStack {
            Image("SplashBackground")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Image("SplashLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 43)
                Rectangle().fill(.clear).frame(maxHeight: 144)
                VStack(spacing: 38) {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 1)
                            .stroke(Color.c0194255, style: StrokeStyle(lineWidth: 1.59, lineCap: .round))
                            .frame(height: 103)
                        Circle()
                            .trim(from: 0, to: 0.3)
                            .stroke(Color.c0194255, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .frame(height: 103)
                            .rotationEffect(.degrees(rotationValue))
                    }
                    Text("Loading")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(.c0194255)
                }
            }
        }
        .onAppear {
            stroke()
            dc.load()
        }
    }
    
    private func stroke() {
        withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
            rotationValue = 360
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            showSplash = false
        }
    }
}

struct Splash_Preview: PreviewProvider {
    
    @State static var showSplash = true
    
    static var previews: some View {
        Splash(showSplash: $showSplash, dc: DC())
    }
}
