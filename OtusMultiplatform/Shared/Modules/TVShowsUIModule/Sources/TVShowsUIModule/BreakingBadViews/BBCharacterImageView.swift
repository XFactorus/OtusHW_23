import SwiftUI

struct BBCharacterImageView: View {
    var imageLink: String?
    
    @ObservedObject var characterImageViewModel:BBCharacterImageViewModel
    
    init(withURL url:String?) {
        characterImageViewModel = BBCharacterImageViewModel(urlString: url ?? "")
    }
    
    var body: some View {
        VStack {
            FakeNavBar(label: "Characters details")
            Spacer()
            Image(uiImage: characterImageViewModel.characterImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //                .frame(width:300, height:300)
                .onAppear(perform: {
                    characterImageViewModel.loadCharacterImage()
                })
                .modifier(FocusView())

            Spacer()
        }
    }
}


struct BBCharacterImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavControllerView(transition: .custom(.slide))  {
            BBCharacterImageView(withURL: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
        }
    }
}
