import Foundation

final class DC: ObservableObject {
    
    let mng = Manager()
    
    var loaded = false
    
    @Published var notes: Array<Note> = []
    @Published var goals: Array<Goal> = []

    var imageData: Data?
    var name: String = ""
    var date: Date = Date()
    var weight: String = ""
    var height: String = ""
    
    func load() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            
            if let name = try? mng.fetchName() {
                self.name = name
            }
            if let weight = try? mng.fetchWeight() {
                self.weight = weight
            }
            if let height = try? mng.fetchHeight() {
                self.height = height
            }
            if let birthday = try? mng.fetchBirthday() {
                if let date = stringToDate(birthday) {
                    self.date = date
                }
            }
            if let imageData = try? mng.fetchImage() {
                self.imageData = imageData
            }
            if let notes = try? mng.fetchNotes() {
                self.notes = notes
            }
            if let goals = try? mng.fetchGoals() {
                self.goals = goals
            }
            
            DispatchQueue.main.async {
                self.loaded = true
            }
        }
    }
    
    func saveName(_ name: String) {
        self.name = name
        mng.saveName(name)
    }
    func saveDate(_ date: Date) {
        self.date = date
        mng.saveBirthday(dateToString(date))
    }
    func saveWeight(_ weight: String) {
        self.weight = weight
        mng.saveWeight(weight)
    }
    func saveHeight(_ height: String) {
        self.height = height
        mng.saveHeight(height)
    }
    func saveImage(_ imageData: Data) {
        self.imageData = imageData
        mng.saveImage(imageData)
    }
    
    func addGoal(_ goal: Goal) {
        goals.append(goal)
        mng.saveGoal(goal)
    }
    
    func deleteGoal(_ goal: Goal) {
        guard let index = goals.firstIndex(where: {$0.uuid == goal.uuid}) else { return }
        goals.remove(at: index)
        try? mng.removeGoal(goal)
    }
    
    func editGoal(_ goal: Goal) {
        guard let index = goals.firstIndex(where: {$0.uuid == goal.uuid}) else { return }
        goals[index] = goal
        mng.editGoal(goal)
    }
    
    func editNote(_ note: Note) {
        guard let index = notes.firstIndex(where: {$0.uuid == note.uuid}) else { return }
        notes[index] = note
        mng.editNote(note)
    }
    
    func addNote(_ note: Note) {
        notes.append(note)
        mng.saveNote(note)
    }
    
    func deleteNote(_ note: Note) {
        guard let index = notes.firstIndex(where: {$0.uuid == note.uuid}) else { return }
        notes.remove(at: index)
        try? mng.removeNote(note)
    }
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    private func stringToDate(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: str)
        return date
    }
}
