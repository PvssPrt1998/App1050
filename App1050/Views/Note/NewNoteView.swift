import SwiftUI

struct NewNoteView: View {
    
    @Binding var colorState: ColorState
    @Binding var show: Bool
    @Binding var title: String
    @Binding var date: Date
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.c414141.opacity(0.58).ignoresSafeArea()
            VStack(spacing: 0) {
                Text(textForState())
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(.c038108)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Button {
                            withAnimation {
                                show = false
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .font(.system(size: 36, weight: .regular))
                                .foregroundColor(.c038108)
                        }
                        , alignment: .trailing
                    )
                    .padding(.horizontal, 20)
                
                Text(noteDescriptionState())
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.c038108)
                    .padding(.top, 24)
                    .padding(.horizontal, 35)
                
                AddNoteTextField(text: $title, placeholder: "Note title")
                    .onChange(of: title, perform: { newValue in
                        validation(newValue)
                    })
                    .keyboardType(.numberPad)
                    .padding(.horizontal, 35)
                    .padding(.top, 31)
                
                DatePicker(selection: $date, displayedComponents: .date) {}
                                .labelsHidden()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 18)
                                .padding(.horizontal, 35)
                Button {
                    action()
                    withAnimation {
                        show = false
                    }
                } label: {
                    Text("Save")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.c038108)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(newGoalStateColor())
                        .clipShape(.rect(cornerRadius: 10))
                }
                .disabled(title == "")
                .opacity(title == "" ? 0.5 : 1)
                .padding(.top, 18)
                .padding(.horizontal, 20)
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            .frame(width: 310)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 25))
        }
    }
    
    func validation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            title = filtered
        } else {
            title = ""
        }
    }
    
    func textForState() -> String {
        switch colorState {
        case .speed: return "Speed"
        case .distance: return "Distance"
        case .time: return "Time"
        }
    }
    
    func noteDescriptionState() -> String {
        switch colorState {
        case .speed: return "Keep track of how fast you rowed"
        case .distance: return "Enter the distance you rowed"
        case .time: return "Enter how many hours you rowed today"
        }
    }
    
    func textColorForState() -> Color {
        if colorState == .time {
            return Color.c255223107
        } else if colorState == .distance {
            return Color.c48173243
        } else {
            return Color.c24480110
        }
    }
    
    func circleTap() {
        switch colorState {
        case .speed: colorState = .distance
        case .distance: colorState = .time
        case .time: colorState = .speed
        }
    }
    
    func gradientForState() -> LinearGradient {
        switch colorState {
        case .speed:
            LinearGradient(colors: [.c24480110, .redGradient2], startPoint: .top, endPoint: .bottom)
        case .distance:
            LinearGradient(colors: [.blueGradient1, .blueGradient2], startPoint: .top, endPoint: .bottom)
        case .time:
            LinearGradient(colors: [.c255223107, .yellowGradient2], startPoint: .top, endPoint: .bottom)
        }
    }
    
    func newGoalStateColor() -> Color {
        if colorState == .time {
            return Color.c255223107
        } else if colorState == .distance {
            return Color.c181222249
        } else {
            return Color.c24480110
        }
    }
}

struct NewNoteView_Preview: PreviewProvider {
    
    @State static var colorState: ColorState = .time
    @State static var show: Bool = true
    @State static var date: Date = Date()
    @State static var title: String = ""
    
    static var previews: some View {
        NewNoteView(colorState: $colorState, show: $show, title: $title, date: $date, action: {})
    }
}

