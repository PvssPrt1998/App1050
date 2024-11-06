import SwiftUI

struct GoalCard: View {
    
    let goal: Goal
    
    let editAction: () -> Void
    let deleteAction: () -> Void
    
    @State var showDeleteAlert = false
    
    var body: some View {
        ZStack {
            HStack(spacing: 7) {
                Button {
                    editAction()
                } label: {
                    Image(systemName: "pencil.circle")
                        .font(.system(size: 34, weight: .regular))
                        .foregroundColor(.c038108)
                }
                Button {
                    withAnimation {
                        showDeleteAlert = true
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 34, weight: .regular))
                        .foregroundColor(.c038108)
                }
                .alert(isPresented: $showDeleteAlert) {
                    Alert(title: Text("Delete"), message: Text("Are you sure you want to delete?"), primaryButton: .default(Text("Delete"), action: {
                        deleteAction()
                    }), secondaryButton: .destructive(Text("Close")))
                }
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 14))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            Text(goal.date)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.c038108)
                .padding(.top, 16)
                .frame(maxHeight: .infinity, alignment: .top)
            
            Text("Your goal for\nthe day")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.c038108)
                .padding(EdgeInsets(top: 16, leading: 15, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            Circle()
                .trim(from: 0, to: 1)
                .stroke(goalGradientByStateValue(goal.state), lineWidth: 10)
                .frame(width: 149, height: 149)
                .overlay(
                    VStack(spacing: 13) {
                        Text("target")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(colorByStateValue(goal.state))
                        Text("\(goal.value)")
                            .font(.system(size: 45, weight: .bold))
                            .foregroundColor(colorByStateValue(goal.state))
                            .frame(height: 55)
                        Text(goalTextByStateValue(goal.state))
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(colorByStateValue(goal.state))
                    }
                )
                .padding(EdgeInsets(top: 56, leading: 0, bottom: 16, trailing: 0))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 221)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 25))
    }
    
    func colorByStateValue(_ value: Int) -> Color {
        if value == 0 {
            return Color.c255223107
        } else if value == 1 {
            return Color.c24480110
        } else {
            return Color.c181222249
        }
    }
    
    func goalTextByStateValue(_ value: Int) -> String {
        if value == 0 {
            return "hours"
        } else if value == 1 {
            return "km/h"
        } else {
            return "km"
        }
    }
    
    func goalGradientByStateValue(_ value: Int) -> LinearGradient {
        if value == 0 {
            return LinearGradient(colors: [.c255223107, .yellowGradient2], startPoint: .top, endPoint: .bottom)
        } else if value == 1 {
            return LinearGradient(colors: [.c24480110, .redGradient2], startPoint: .top, endPoint: .bottom)
        } else {
            return LinearGradient(colors: [.blueGradient1, .blueGradient2], startPoint: .top, endPoint: .bottom)
        }
    }
}

#Preview {
    GoalCard(goal: Goal(uuid: UUID(), state: 0, value: 10, date: "05.12.1998"), editAction: {}, deleteAction: {})
}
