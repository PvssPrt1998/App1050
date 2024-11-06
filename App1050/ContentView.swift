import SwiftUI

struct ContentView: View {
    
    @State var showSplash = true
    
    var body: some View {
        if showSplash {
            Splash(showSplash: $showSplash, dc: VMC.shared.dc)
        } else {
            Tab()
        }
    }
}

#Preview {
    ContentView()
}
