import SwiftUI

struct NoteCard: View {
    
    let note: Note
    
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
                        //viewModel.delete(note.uuid)
                        deleteAction()
                    }), secondaryButton: .destructive(Text("Close")))
                }
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 14))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            HStack(spacing: 10) {
                Circle()
                    .fill(colorByStateValue(note.state))
                    .frame(width: 34, height: 34)
                VStack(spacing: 10) {
                    Text(textByStateValue(note.state))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.c038108)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(note.title) " + noteTextByStateValue(note.state))
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.c038108)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 14)
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(note.date)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.c038108)
                .padding(.top, 14)
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 78)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 20))
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
    
    func noteTextByStateValue(_ value: Int) -> String {
        if value == 0 {
            return "hours"
        } else if value == 1 {
            return "km/h"
        } else {
            return "km"
        }
    }
    
    func textByStateValue(_ value: Int) -> String {
        if value == 0 {
            return "Time"
        } else if value == 1 {
            return "Speed"
        } else {
            return "Distance"
        }
    }
}

#Preview {
    NoteCard(note: Note(uuid: UUID(), state: 0, title: 15, date: "05.12.1998"), editAction: {}, deleteAction: {})
}
