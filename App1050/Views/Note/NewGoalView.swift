import SwiftUI

struct NewGoalView: View {
    
    @Binding var colorState: ColorState
    @Binding var show: Bool
    @Binding var text: String
    @Binding var date: Date
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color.c414141.opacity(0.58).ignoresSafeArea()
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Circle()
                        .fill(newGoalStateColor())
                        .frame(width: 34, height: 34)
                        .onTapGesture {
                            circleTap()
                        }
                    Text("Target")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(.c038108)
                        .frame(maxWidth: .infinity)
                    Button {
                        withAnimation {
                            show = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 36, weight: .regular))
                            .foregroundColor(.c038108)
                    }
                }
                
                Text("Choose your goal for the day")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.c038108)
                    .padding(.top, 24)
                
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(gradientForState(), lineWidth: 10)
                    .frame(width: 149, height: 149)
                    .overlay(
                        VStack(spacing: 13) {
                            Text("target")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(textColorForState())
                            TextField("", text: $text)
                                .font(.system(size: 45, weight: .bold))
                                .foregroundColor(textColorForState())
                                .autocorrectionDisabled(true)
                                .multilineTextAlignment(.center)
                                .accentColor(textColorForState())
                                .frame(width: 100, height: 55)
                                .background(Color.black.opacity(0.03))
                                .clipShape(.rect(cornerRadius: 10))
                                .onChange(of: text, perform: { newValue in
                                    validation(newValue)
                                })
                                .keyboardType(.numberPad)
                            Text(textForState())
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(textColorForState())
                        }
                    )
                    .padding(.top, 32)
                DatePicker(selection: $date, displayedComponents: .date) {}
                                .labelsHidden()
                                .padding(.top, 18)
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
                .disabled(text == "")
                .opacity(text == "" ? 0.5 : 1)
                .padding(.top, 18)
            }
            .padding(EdgeInsets(top: 20, leading: 13, bottom: 20, trailing: 13))
            .frame(width: 297)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 25))
        }
    }
    
    func validation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        if filtered != "" {
            text = filtered
        } else {
            text = ""
        }
    }
    
    func textForState() -> String {
        switch colorState {
        case .speed: return "km/h"
        case .distance: return "km"
        case .time: return "Hours"
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

struct NewGoalView_Preview: PreviewProvider {
    
    @State static var colorState: ColorState = .time
    @State static var show: Bool = true
    @State static var date: Date = Date()
    @State static var text: String = ""
    
    static var previews: some View {
        NewGoalView(colorState: $colorState, show: $show, text: $text, date: $date, action: {})
    }
}
