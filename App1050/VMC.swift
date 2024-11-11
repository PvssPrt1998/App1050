import SwiftUI

final class VMC {
    
    let dc: DC = DC()
    var preferredShow = false
    @AppStorage("statLine") var statLine = ""
    private var noteViewModel: NoteViewModel?
    private var profileViewModel: ProfileViewModel?
    
    static let shared = VMC()
    
    private init() {}
    
    func makeNoteViewModel() -> NoteViewModel {
        noteViewModel = NoteViewModel(dc: dc)
        return noteViewModel!
    }
    
    func makeProfileViewModel() -> ProfileViewModel {
        profileViewModel = ProfileViewModel(dc: dc)
        return profileViewModel!
    }
    
    func makeAnalysisViewModel() -> AnalysisViewModel {
        AnalysisViewModel(dc: dc)
    }
}
