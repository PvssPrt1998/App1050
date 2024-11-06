import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            Color.c164209255.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Settings")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 16) {
                    Button {
                        SKStoreReviewController.requestReviewInCurrentScene()
                    } label: {
                        HStack(spacing: 15) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.c038108)
                            Text("Rate Us")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.c038108)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Image(systemName: "arrowtriangle.forward.fill")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.c038108)
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 50)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    Button {
                        if let url = URL(string: "https://www.termsfeed.com/live/14dd3d57-b566-43ce-9346-0eb0c246346d") {
                            openURL(url)
                        }
                    } label: {
                        HStack(spacing: 15) {
                            Image(systemName: "book.fill")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.c038108)
                            Text("Terms of use")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.c038108)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Image(systemName: "arrowtriangle.forward.fill")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.c038108)
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 50)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    Button {
                        if let url = URL(string: "https://www.termsfeed.com/live/96fef6ea-2371-4803-9b7c-3f9c5bff6606") {
                            openURL(url)
                        }
                    } label: {
                        HStack(spacing: 15) {
                            Image(systemName: "hand.raised.fill")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.c038108)
                            Text("Privacy")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.c038108)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Image(systemName: "arrowtriangle.forward.fill")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.c038108)
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 50)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 15))
                    }
                }
                .padding(EdgeInsets(top: 46, leading: 35, bottom: 0, trailing: 35))
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    SettingsView()
}

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
