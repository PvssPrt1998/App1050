import Foundation

final class NoteViewModel: ObservableObject {
    
    let dc: DC
    
    @Published var state: ColorState = .time
    @Published var newGoalState: ColorState = .time
    
    @Published var notes: Array<Note>
    @Published var goals: Array<Goal>
    
    @Published var newGoalDate: Date = Date()
    @Published var newGoalValue: String = ""
    
    @Published var newNoteText = ""
    @Published var newNoteDate: Date = Date()
    
    @Published var editGoalState: ColorState = .time
    @Published var editGoalDate: Date = Date()
    @Published var editGoalValue: String = ""
    
    @Published var editNoteState: ColorState = .time
    @Published var editNoteTitle: String = ""
    @Published var editNoteDate: Date = Date()
    
    var noteForEdit: Note?
    var goalForEdit: Goal?
    
    var union: Array<NoteAndGoal> {
        unionArrays()
    }
    
    init(dc: DC) {
        self.dc = dc
        notes = dc.notes
        goals = dc.goals
    }
    
    func delete(_ note: Note) {
        guard let index = notes.firstIndex(where: {$0.uuid == note.uuid}) else { return }
        notes.remove(at: index)
        dc.deleteNote(note)
    }
    
    func delete(_ goal: Goal) {
        guard let index = goals.firstIndex(where: {$0.uuid == goal.uuid}) else { return }
        goals.remove(at: index)
        dc.deleteGoal(goal)
    }
    
    func saveEditGoal() {
        guard var goalForEdit = goalForEdit, let editGoalValue = Int(editGoalValue), let index = goals.firstIndex(where: {goalForEdit.uuid == $0.uuid}) else { return }
        var goalStateValue = 0
        if editGoalState == .time { goalStateValue = 0 }
        else if editGoalState == .speed { goalStateValue = 1 }
        else if editGoalState == .distance { goalStateValue = 2 }
        goalForEdit.date = dateToString(editGoalDate)
        goalForEdit.state = goalStateValue
        goalForEdit.value = editGoalValue
        dc.editGoal(goalForEdit)
        goals[index] = goalForEdit
    }
    
    func saveEditNote() {
        guard var noteForEdit = noteForEdit, let index = notes.firstIndex(where: {$0.uuid == noteForEdit.uuid}), let editNoteTitle = Int(editNoteTitle) else { return }
        var noteStateValue = 0
        if editNoteState == .time { noteStateValue = 0 }
        else if editNoteState == .speed { noteStateValue = 1 }
        else if editNoteState == .distance { noteStateValue = 2 }
        noteForEdit.date = dateToString(editNoteDate)
        noteForEdit.title = editNoteTitle
        noteForEdit.state = noteStateValue
        dc.editNote(noteForEdit)
        notes[index] = noteForEdit
    }
    
    func prepareGoalForEdit(_ goal: Goal) {
        goalForEdit = goal
        editGoalState = stateByStateValue(goal.state)
        editGoalDate = stringToDate(goal.date)!
        editGoalValue = "\(goal.value)"
    }
    
    func prepareNoteForEdit(_ note: Note) {
        noteForEdit = note
        editNoteDate = stringToDate(note.date)!
        editNoteTitle = "\(note.title)"
        editNoteState = stateByStateValue(note.state)
    }
    
    private func stateByStateValue(_ value: Int) -> ColorState {
        if value == 0 {
            return .time
        } else if value == 1 {
            return .speed
        } else {
            return .distance
        }
    }
    
    func addGoal() {
        guard let newGoalValue = Int(newGoalValue) else { return }
        var newGoalStateValue = 0
        if newGoalState == .time { newGoalStateValue = 0 }
        else if newGoalState == .speed { newGoalStateValue = 1 }
        else if newGoalState == .distance { newGoalStateValue = 2 }
        let goal = Goal(uuid: UUID(), state: newGoalStateValue, value: newGoalValue, date: dateToString(newGoalDate))
        dc.addGoal(goal)
        goals.append(goal)
        newGoalDate = Date()
        self.newGoalValue = ""
    }
    
    func addNote() {
        guard let newNoteText = Int(newNoteText) else { return }
        var newNoteStateValue = 0
        if state == .time { newNoteStateValue = 0 }
        else if state == .speed { newNoteStateValue = 1 }
        else if state == .distance { newNoteStateValue = 2 }
        let note = Note(uuid: UUID(), state: newNoteStateValue, title: newNoteText, date: dateToString(newNoteDate))
        dc.addNote(note)
        notes.append(note)
        newNoteDate = Date()
        self.newNoteText = ""
    }
    
    func unionArrays() -> Array<NoteAndGoal> {
        var array: Array<NoteAndGoal> = []
        var i = 0
        var j = 0
        
        while i < notes.count && j < goals.count {
            array.append(notes[i])
            array.append(goals[j])
            
            i += 1
            j += 1
        }
        
        if i >= notes.count {
            for index in j..<goals.count {
                array.append(goals[index])
            }
        } else {
            for index in i..<notes.count {
                array.append(notes[index])
            }
        }
        return array.sorted(by: {stringToDate($0.date)! <= stringToDate($1.date)!}).reversed()
    }
  
    func circleTap() {
        switch state {
        case .speed: state = .distance
        case .distance: state = .time
        case .time: state = .speed
        }
    }
    
    func newGoalCircleTap() {
        switch newGoalState {
        case .speed: newGoalState = .distance
        case .distance: newGoalState = .time
        case .time: newGoalState = .speed
        }
    }
    
    private func stringToDate(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: str)
        return date
    }

    private func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}

enum ColorState {
    case speed
    case distance
    case time
}
