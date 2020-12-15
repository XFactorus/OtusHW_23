import SwiftUI

struct RMCharacterImageView: View {
    var imageLink: String?
    
    @ObservedObject var characterImageViewModel:RMCharacterImageViewModel
    
    init(withURL url:String?) {
        characterImageViewModel = RMCharacterImageViewModel(urlString: url ?? "")
    }
    
    var body: some View {
        VStack {
            FakeNavBar(label: "Characters details")
            Spacer()
            Image(uiImage: characterImageViewModel.characterImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear(perform: {
                    characterImageViewModel.loadCharacterImage()
                })
                .modifier(FocusView())
      
            Spacer()
        }
    }
}

struct RMCharacterImage_Previews: PreviewProvider {
    static var previews: some View {
        NavControllerView(transition: .custom(.slide))  {
            RMCharacterImageView(withURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        }
    }
}
