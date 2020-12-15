import SwiftUI
import TVShowsLibrary

struct RMCharacterDetailsView: View {
    var character: RMCharacter
    var body: some View {
        
            VStack {
                FakeNavBar(label: "Characters list")
                Spacer()
                RMPropertyView(propertyTitle: "Name", propertyValue: character.name)
                RMPropertyView(propertyTitle: "Status", propertyValue: character.status)
                RMPropertyView(propertyTitle: "Species", propertyValue: character.species)
                RMPropertyView(propertyTitle: "Gender", propertyValue: character.gender)
                #if os(iOS) || os(macOS)
                NavPushButton(destination:
                                RMCharacterImageView(withURL: character.image)){
                    Text("Show character image")
                        .foregroundColor(.blue)
                        .font(.title2)
                    Spacer()
                    
                }
                #else
                NavigationLink(destination: RMCharacterImageView(withURL: character.image)) {
                    Text("Show character image")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
                #endif
            }
    }
}

struct RMPropertyView: View {
    let propertyTitle: String
    let propertyValue: String?
    var body: some View {
        HStack {
            Text("\(propertyTitle):")
                .font(.headline)
            Text(propertyValue ?? "Unknown")
                .font(.body)
        }.padding()
    }
}

struct RMCharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavControllerView(transition: .custom(.slide))  {
        RMCharacterDetailsView(character: RMCharacter.getMockCharacter())
        }
    }
}
