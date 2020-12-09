import SwiftUI
import TVShowsLibrary

struct RMCharactersListView: View {
    
    @ObservedObject var viewModel: RMCharactersViewModel
    @EnvironmentObject private var navModel: NavControllerViewModel
    
    var body: some View {
        List(self.viewModel.listDataSource.indices, id: \.self) { index in
            RMCharacterCell(character: self.viewModel.listDataSource[index])
                .onAppear() {
                    self.viewModel.fetchIfRequired(index: index)
                }
                .onTapGesture {
                    print("Row tapped")
                    navModel.push(RMCharacterDetailsView(character: self.viewModel.listDataSource[index]))
                }
        }
    }
    
}
    
struct RMCharacterCell: View {
    
    @State var character: RMCharacter
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Text(character.gender)
                    .font(.callout)
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text(character.status)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                
            .frame(height: 64)
        }
        .contentShape(Rectangle())
    }
}


struct RMCharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        RMCharactersListView(viewModel: RMCharactersViewModel())
    }
}
