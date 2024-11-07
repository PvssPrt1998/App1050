import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = VMC.shared.makeProfileViewModel()
    
    var body: some View {
        ZStack {
            Color.c164209255.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Profile")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                ImageView(imageData: $viewModel.imageData, image: setImage(viewModel.imageData))
                    .padding(.top, 33)
                VStack(spacing: 20) {
                    ProfileTextField(text: $viewModel.name, placeholder: "Name", trailing: viewModel.isNameEdited ? 76 : 57)
                        .overlay(
                            nameRight
                            , alignment: .trailing
                        )
                    
                    HStack(spacing: 16) {
                        Text("Birthday")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.c038108)
                        Spacer()
                        DatePicker(selection: $viewModel.birthday, displayedComponents: .date) {}
                                        .labelsHidden()
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 50)
                    .background(Color.white)
                    .clipShape(.rect(cornerRadius: 15))
                    
                    
                    ProfileTextField(text: $viewModel.weight, placeholder: "Weight", trailing: viewModel.isWeightEdited ? 76 : 57)
                        .overlay(
                            weightRight
                            , alignment: .trailing
                        )
                        .onChange(of: viewModel.weight, perform: { newValue in
                            weightValidation(newValue)
                        })
                        .keyboardType(.numberPad)
                    ProfileTextField(text: $viewModel.height, placeholder: "Height", trailing: viewModel.isHeightEdited ? 76 : 57)
                        .overlay(
                            heightRight
                            , alignment: .trailing
                        )
                        .onChange(of: viewModel.height, perform: { newValue in
                            heightValidation(newValue)
                        })
                        .keyboardType(.numberPad)
                    Text("Fill in your information")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(EdgeInsets(top: 33, leading: 39, bottom: 0, trailing: 39))
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.bottom, bottomPadding)
        }
    }
    
    func weightValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        let newValuePostfixFilter = newValue.filter{ Set(" kg").contains($0) }
        if newValuePostfixFilter != "" && !newValue.contains(" kg") {
            filtered.removeLast()
        }
        while filtered != "" && filtered.first == "0" && filtered.count > 1 {
            filtered.removeFirst()
        }
        
        if filtered != "" {
            viewModel.weight = filtered + " kg"
        } else {
            viewModel.weight = ""
        }
    }
    
    func heightValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        let newValuePostfixFilter = newValue.filter{ Set(" cm").contains($0) }
        if newValuePostfixFilter != "" && !newValue.contains(" cm") {
            filtered.removeLast()
        }
        while filtered != "" && filtered.first == "0" && filtered.count > 1 {
            filtered.removeFirst()
        }
        
        if filtered != "" {
            viewModel.height = filtered + " cm"
        } else {
            viewModel.height = ""
        }
    }
    
    @ViewBuilder var nameRight: some View {
        if viewModel.isNameEdited {
            HStack(spacing: 8) {
                Button {
                    viewModel.name = viewModel.dc.name
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.c038108)
                        .frame(width: 18, height: 18)
                        .frame(width: 26, height: 38)
                }
                
                Button {
                    viewModel.saveName()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                } label: {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.c038108)
                        .frame(width: 18, height: 18)
                        .frame(width: 18, height: 38)
                }
            }
            .padding(.trailing, 16)
        } else {
            Image(systemName: "person.fill")
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(.c038108)
                .padding(.trailing, 16)
        }
    }
    
    @ViewBuilder var weightRight: some View {
        if viewModel.isWeightEdited {
            HStack(spacing: 8) {
                Button {
                    viewModel.weight = viewModel.dc.weight
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.c038108)
                        .frame(width: 18, height: 18)
                        .frame(width: 26, height: 38)
                }
                
                Button {
                    viewModel.saveWeight()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                } label: {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.c038108)
                        .frame(width: 18, height: 18)
                        .frame(width: 18, height: 38)
                }
            }
            .padding(.trailing, 16)
        } else {
            Image(systemName: "pencil")
                .font(.system(size: 32, weight: .regular))
                .foregroundColor(.c038108)
                .padding(.trailing, 16)
        }
    }
    
    @ViewBuilder var heightRight: some View {
        if viewModel.isHeightEdited {
            HStack(spacing: 8) {
                Button {
                    viewModel.height = viewModel.dc.height
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.c038108)
                        .frame(width: 18, height: 18)
                        .frame(width: 26, height: 38)
                }
                
                Button {
                    viewModel.saveHeight()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                } label: {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.c038108)
                        .frame(width: 18, height: 18)
                        .frame(width: 18, height: 38)
                }
            }
            .padding(.trailing, 16)
        } else {
            Image(systemName: "pencil")
                .font(.system(size: 32, weight: .regular))
                .foregroundColor(.c038108)
                .padding(.trailing, 16)
        }
    }
    
    
    
    private func setImage(_ data: Data?) -> Image? {
        guard let data = data, let image = UIImage(data: data) else {
            return nil
        }
        return Image(uiImage: image)
    }
}

#Preview {
    ProfileView()
}
