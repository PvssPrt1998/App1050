import SwiftUI

struct ProfileTextField: View {
    
    @Binding var text: String
    let placeholder: String
    var trailing: CGFloat = 57
    
    var body: some View {
        HStack(spacing: 10) {
            TextField("", text: $text)
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.c038108)
                .autocorrectionDisabled(true)
                .accentColor(.c038108)
                .background(
                    placeholderView()
                )
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: trailing))
        .frame(height: 50)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 15))
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : placeholder)
            .font(.system(size: 13, weight: .regular))
            .foregroundColor(.c038108)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProfileTextField_Preview: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        ProfileTextField(text: $text, placeholder: "Name")
            .padding()
            .background(Color.blue)
    }
}
