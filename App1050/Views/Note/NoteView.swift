import SwiftUI

struct NoteView: View {
    
    @ObservedObject var viewModel = VMC.shared.makeNoteViewModel()
    @State var newGoalShow = false
    @State var newNoteShow = false
    
    @State var noteEditShow = false
    @State var goalEditShow = false
    
    @State var showDeleteAlert = false
    
    var body: some View {
        ZStack {
            Color.c164209255.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Note")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 18) {
                    addNote
                    addGoal
                }
                .padding(EdgeInsets(top: 25, leading: 22, bottom: 0, trailing: 22))
                
                Rectangle()
                    .fill(.white)
                    .frame(height: 3)
                    .padding(.top, 18)
                
                if viewModel.notes.isEmpty && viewModel.goals.isEmpty {
                    empty
                } else {
                    collection
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.bottom, bottomPadding)
            .ignoresSafeArea(.container, edges: .bottom)
            
            if newGoalShow {
                NewGoalView(colorState: $viewModel.newGoalState, show: $newGoalShow, text: $viewModel.newGoalValue, date: $viewModel.newGoalDate) {
                    viewModel.addGoal()
                }
            }
            if newNoteShow {
                NewNoteView(colorState: $viewModel.state, show: $newNoteShow, title: $viewModel.newNoteText, date: $viewModel.newNoteDate) {
                    viewModel.addNote()
                }
            }
            if noteEditShow {
                NewNoteView(colorState: $viewModel.editNoteState, show: $noteEditShow, title: $viewModel.editNoteTitle, date: $viewModel.editNoteDate) {
                    viewModel.saveEditNote()
                }
            }
            if goalEditShow {
                NewGoalView(colorState: $viewModel.editGoalState, show: $goalEditShow, text: $viewModel.editGoalValue, date: $viewModel.editGoalDate) {
                    viewModel.saveEditGoal()
                }
            }
        }
    }
    
    @ViewBuilder func card(_ noteAndGoal: NoteAndGoal) -> some View {
        if let note = noteAndGoal as? Note {
            NoteCard(note: note) {
                viewModel.prepareNoteForEdit(note)
                withAnimation {
                    noteEditShow = true
                }
            } deleteAction: {
                viewModel.delete(note)
            }

        } else if let goal = noteAndGoal as? Goal {
            GoalCard(goal: goal) {
                viewModel.prepareGoalForEdit(goal)
                withAnimation {
                    goalEditShow = true
                }
            } deleteAction: {
                viewModel.delete(goal)
            }

        } else {
            Text("Error")
        }
    }
    
    private var collection: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 18) {
                ForEach(0..<viewModel.union.count, id: \.self) { index in
                    card(viewModel.union[index])
                }
            }
            .padding(EdgeInsets(top: 25, leading: 28, bottom: 8, trailing: 28))
        }
    }
    
    private var empty: some View {
        Text("It's empty here. Add\nnotes and data about\nyour workouts")
            .font(.system(size: 20, weight: .regular))
            .foregroundColor(.c038108)
            .multilineTextAlignment(.center)
            .frame(maxHeight: .infinity)
    }
    
    private var addNote: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(stateColor())
                .frame(width: 34, height: 34)
                .onTapGesture {
                    viewModel.circleTap()
                }
            Text("Add a note about the " + textByState(viewModel.state))
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.c038108)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                withAnimation {
                    newNoteShow = true
                }
            } label: {
                Image(systemName: "plus.circle")
                    .font(.system(size: 36, weight: .regular))
                    .foregroundColor(.c038108)
            }
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
        .frame(height: 72)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 15))
    }
    
    func textByState(_ state: ColorState) -> String {
        switch state {
        case .time: return "time"
        case .speed: return "speed"
        case .distance: return "distance"
        }
    }
    
    private var addGoal: some View {
        HStack(spacing: 15) {
            Text("Want to add a daily goal?")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.c038108)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                withAnimation {
                    newGoalShow = true
                }
            } label: {
                Image(systemName: "plus.circle")
                    .font(.system(size: 36, weight: .regular))
                    .foregroundColor(.c038108)
            }
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
        .frame(height: 72)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 15))
    }
    
    func stateColor() -> Color {
        if viewModel.state == .time {
            return Color.c255223107
        } else if viewModel.state == .distance {
            return Color.c181222249
        } else {
            return Color.c24480110
        }
    }
}

#Preview {
    NoteView()
}
