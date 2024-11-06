import SwiftUI

struct AddNoteTextField: View {
    
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        HStack(spacing: 10) {
            TextField("", text: $text)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.c038108)
                .autocorrectionDisabled(true)
                .accentColor(.c038108)
                .background(
                    placeholderView()
                )
        }
        .padding(.leading, 18)
        .frame(height: 52)
        .background(Color.c233233233)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : placeholder)
            .font(.system(size: 15, weight: .regular))
            .foregroundColor(.c038108)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AddNoteTextField_Preview: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        AddNoteTextField(text: $text, placeholder: "Name")
            .padding()
            .background(Color.white)
    }
}
