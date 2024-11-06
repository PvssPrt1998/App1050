import Foundation

final class ProfileViewModel: ObservableObject {
    
    let dc: DC
    
    @Published var imageData: Data? {
        didSet {
            if imageData != dc.imageData {
                saveImage()
            }
        }
    }
    
    @Published var name: String = ""
    var isNameEdited: Bool {
        name != dc.name
    }
    @Published var birthday: Date {
        didSet {
            if birthday != dc.date {
                saveBirthday()
            }
        }
    }
    @Published var weight: String = ""
    var isWeightEdited: Bool {
        let str = weight.filter { Set("0123456789").contains($0) }
        return str != dc.weight
    }
    @Published var height: String = ""
    var isHeightEdited: Bool {
        let str = height.filter { Set("0123456789").contains($0) }
        return str != dc.height
    }
    
    init(dc: DC) {
        self.dc = dc
        birthday = dc.date
        name = dc.name
        weight = dc.weight
        height = dc.height
        imageData = dc.imageData
    }
    
    private func stringToDate(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: str)
        return date
    }

    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func saveName() {
        dc.saveName(name)
        objectWillChange.send()
    }
    func saveWeight() {
        dc.saveWeight(weight.filter { Set("0123456789").contains($0) })
        objectWillChange.send()
    }
    func saveBirthday() {
        dc.saveDate(birthday)
    }
    func saveHeight() {
        dc.saveHeight(height.filter { Set("0123456789").contains($0) })
        objectWillChange.send()
    }
    func saveImage() {
        guard let imageData = imageData else { return }
        dc.saveImage(imageData)
    }
}
