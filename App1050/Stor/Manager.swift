import Foundation

final class Manager {
    private let modelName = "DModel"
    
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
    
    func saveWeight(_ value: String) {
        do {
            let weights = try coreDataStack.managedContext.fetch(Weight.fetchRequest())
            if weights.count > 0 {
                weights[0].weight = value
            } else {
                let weight =  Weight(context: coreDataStack.managedContext)
                weight.weight = value
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func fetchWeight() throws -> String? {
        guard let weight = try coreDataStack.managedContext.fetch(Weight.fetchRequest()).first else { return nil }
        return weight.weight
    }
    func saveHeight(_ value: String) {
        do {
            let heights = try coreDataStack.managedContext.fetch(Height.fetchRequest())
            if heights.count > 0 {
                heights[0].height = value
            } else {
                let height =  Height(context: coreDataStack.managedContext)
                height.height = value
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func fetchHeight() throws -> String? {
        guard let height = try coreDataStack.managedContext.fetch(Height.fetchRequest()).first else { return nil }
        return height.height
    }
    func saveName(_ value: String) {
        do {
            let names = try coreDataStack.managedContext.fetch(Name.fetchRequest())
            if names.count > 0 {
                names[0].name = value
            } else {
                let name =  Name(context: coreDataStack.managedContext)
                name.name = value
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func fetchName() throws -> String? {
        guard let name = try coreDataStack.managedContext.fetch(Name.fetchRequest()).first else { return nil }
        return name.name
    }
    func saveBirthday(_ value: String) {
        do {
            let birthdays = try coreDataStack.managedContext.fetch(Birthday.fetchRequest())
            if birthdays.count > 0 {
                birthdays[0].birthday = value
            } else {
                let birthday =  Birthday(context: coreDataStack.managedContext)
                birthday.birthday = value
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func fetchBirthday() throws -> String? {
        guard let birthday = try coreDataStack.managedContext.fetch(Birthday.fetchRequest()).first else { return nil }
        return birthday.birthday
    }
    func saveImage(_ imageData: Data) {
        do {
            let images = try coreDataStack.managedContext.fetch(ImageData.fetchRequest())
            if images.count > 0 {
                images[0].imageData = imageData
            } else {
                let image =  ImageData(context: coreDataStack.managedContext)
                image.imageData = imageData
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func fetchImage() throws -> Data? {
        guard let image = try coreDataStack.managedContext.fetch(ImageData.fetchRequest()).first else { return nil }
        return image.imageData
    }
    func saveNote(_ note: Note) {
        let noteCD = NoteCD(context: coreDataStack.managedContext)
        noteCD.uuid = note.uuid
        noteCD.date = note.date
        noteCD.title = Int32(note.title)
        noteCD.state = Int32(note.state)
        coreDataStack.saveContext()
    }
    func fetchNotes() throws -> Array<Note> {
        var array: Array<Note> = []
        let notesCD = try coreDataStack.managedContext.fetch(NoteCD.fetchRequest())
        notesCD.forEach { ncd in
            array.append(Note(uuid: ncd.uuid, state: Int(ncd.state), title: Int(ncd.title), date: ncd.date))
        }
        return array
    }
    func editNote(_ note: Note) {
        do {
            let notesCD = try coreDataStack.managedContext.fetch(NoteCD.fetchRequest())
            notesCD.forEach { ncd in
                if ncd.uuid == note.uuid {
                    ncd.title = Int32(note.title)
                    ncd.state = Int32(note.state)
                    ncd.date = note.date
                    coreDataStack.saveContext()
                    return
                }
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func saveGoal(_ note: Goal) {
        let noteCD = GoalCD(context: coreDataStack.managedContext)
        noteCD.uuid = note.uuid
        noteCD.date = note.date
        noteCD.value = Int32(note.value)
        noteCD.state = Int32(note.state)
        coreDataStack.saveContext()
    }
    func fetchGoals() throws -> Array<Goal> {
        var array: Array<Goal> = []
        let notesCD = try coreDataStack.managedContext.fetch(GoalCD.fetchRequest())
        notesCD.forEach { ncd in
            array.append(Goal(uuid: ncd.uuid, state: Int(ncd.state), value: Int(ncd.value), date: ncd.date))
        }
        return array
    }
    func editGoal(_ note: Goal) {
        do {
            let notesCD = try coreDataStack.managedContext.fetch(GoalCD.fetchRequest())
            notesCD.forEach { ncd in
                if ncd.uuid == note.uuid {
                    ncd.value = Int32(note.value)
                    ncd.state = Int32(note.state)
                    ncd.date = note.date
                    coreDataStack.saveContext()
                    return
                }
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func removeGoal(_ goal: Goal) throws {
        let goalsCD = try coreDataStack.managedContext.fetch(GoalCD.fetchRequest())
        let goalCD = goalsCD.first(where: {$0.uuid == goal.uuid})
        guard let goalCD = goalCD else { return }
        coreDataStack.managedContext.delete(goalCD)
        coreDataStack.saveContext()
    }
    func removeNote(_ note: Note) throws {
        let notesCD = try coreDataStack.managedContext.fetch(NoteCD.fetchRequest())
        let noteCD = notesCD.first(where: {$0.uuid == note.uuid})
        guard let noteCD = noteCD else { return }
        coreDataStack.managedContext.delete(noteCD)
        coreDataStack.saveContext()
    }
}
