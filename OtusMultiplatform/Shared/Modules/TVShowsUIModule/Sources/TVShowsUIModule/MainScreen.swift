import SwiftUI

public struct MainScreen: View {
    
    @ObservedObject var rmListViewModel: RMCharactersViewModel = RMCharactersViewModel()
    @ObservedObject var bbListViewModel: BBCharactersViewModel = BBCharactersViewModel()
    
    public init() {}
    
    @State private var selection: Int = 0
    
    public var body: some View {
        NavControllerView()  {
            VStack {
                Picker("Options", selection: $selection) {
                    Text("Rick & Morty list").tag(0)
                    Text("Breaking Bad list").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                
                if selection == 0 {
                    RMCharactersListView(viewModel: rmListViewModel)
                        .onAppear() {
                            self.rmListViewModel.loadInitialList()
                        }
                } else {
                    BBCharactersListView(viewModel: bbListViewModel)
                        .onAppear() {
                            self.bbListViewModel.loadInitialList()
                        }
                }
            }.onAppear() {
                self.rmListViewModel.loadInitialList()
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .environmentObject(RMCharactersViewModel(isMock: true))
    }
}
