import Foundation

final class VMC {
    
    let dc: DC = DC()
    
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
