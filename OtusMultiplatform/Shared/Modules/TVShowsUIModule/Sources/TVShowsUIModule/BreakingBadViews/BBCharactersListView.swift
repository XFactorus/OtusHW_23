import SwiftUI
import TVShowsLibrary

struct BBCharactersListView: View {
    
    @ObservedObject var viewModel: BBCharactersViewModel
    @EnvironmentObject private var navModel: NavControllerViewModel
    
    var body: some View {
        #if os(iOS) || os(macOS) 
        List(self.viewModel.listDataSource.indices, id: \.self) { index in
            BBCharacterCell(character: self.viewModel.listDataSource[index])
                .onAppear() {
                    self.viewModel.fetchIfRequired(index: index)
                }
                .onTapGesture {
                    print("Row tapped")
                    navModel.push(BBCharacterDetailsView(character: self.viewModel.listDataSource[index]))
                }
        }
        #else
        NavigationView {
            List(self.viewModel.listDataSource.indices, id: \.self) { index in
                NavigationLink(destination: BBCharacterDetailsView(character: self.viewModel.listDataSource[index])) {
                    BBCharacterCell(character: self.viewModel.listDataSource[index])
                        .onAppear() {
                            self.viewModel.fetchIfRequired(index: index)
                        }
                }
            }
        }
        
        #endif
    }
}
    
struct BBCharacterCell: View {
    
    @State var character: BBCharacter
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Text(character.nickname)
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


struct BBCharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        BBCharactersListView(viewModel: BBCharactersViewModel())
    }
}
