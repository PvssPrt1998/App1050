import Foundation

final class AnalysisViewModel: ObservableObject {
    
    let dc: DC
    
    @Published var goals: Array<Goal>
    @Published var notes: Array<Note>
    
    var speedPercent: Double {
        Double(speed()) / Double(totalValue())
    }
    var timePercent: Double {
        Double(timeSpent()) / Double(totalValue())
    }
    var distancePercent: Double {
        Double(distance()) / Double(totalValue())
    }
    
    init(dc: DC) {
        self.dc = dc
        goals = dc.goals
        notes = dc.notes
        
        goals = goals.filter { $0.date == dateToString(Date()) }
        notes = notes.filter { $0.date == dateToString(Date()) }
    }
    
    func totalValue() -> Int {
        var total = 0
        notes.forEach { note in
            total += note.title
        }
        return total
    }
    
    func distance() -> Int {
        var total = 0
        let localNotes = notes.filter { $0.state == 2 }
        localNotes.forEach { note in
            total += note.title
        }
        return total
    }
    
    func timeSpent() -> Int {
        var total = 0
        let localNotes = notes.filter { $0.state == 0 }
        localNotes.forEach { note in
            total += note.title
        }
        return total
    }
    
    func getYesterdayTimeSpent() -> Double {
        var total = 0
        let ln = dc.notes.filter { $0.date == dateToString(Date().addingTimeInterval(-(24 * 60 * 60))) }.filter { $0.state == 0 }
        ln.forEach { note in
            total += note.title
        }
        return total != 0 ? (Double(timeSpent()) / Double(total)) : 0
    }
    
    func speed() -> Int {
        var total = 0
        let localNotes = notes.filter { $0.state == 1 }
        localNotes.forEach { note in
            total += note.title
        }
        return localNotes.count != 0 ? total / localNotes.count : 0
    }
    
    func target() -> Int {
        var total = 0
        let localGoals = goals.filter { $0.state == 2 }
        localGoals.forEach { goal in
            total += goal.value
        }
        return total
    }
    func progress() -> Double {
        var total = 0
        let localNotes = notes.filter { $0.state == 2 }
        localNotes.forEach { note in
            total += note.title
        }
        return min(1, Double(total) / Double(target())) * 100
    }
    
    func getClasses() -> Int {
        var count = 0
        var daysMultiplier: Double = 1
        let dateOffset: Double = -(24 * 60 * 60)
        var str = dateToString(Date().addingTimeInterval(dateOffset))
        while dc.notes.contains(where: {$0.date == str}) {
            count += 1
            daysMultiplier += 1
            str = dateToString(Date().addingTimeInterval(dateOffset * daysMultiplier))
        }
        
        return count
    }
    
    func getDayInt(_ date: String) -> Int? {
        var day = date.components(separatedBy: ".")[0]
        if day[0] == "0" {
            day.removeFirst()
        }
        print(day)
        return Int(day)
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

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
