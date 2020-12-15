import SwiftUI
import TVShowsLibrary

struct BBCharacterDetailsView: View {
    var character: BBCharacter
    
    var body: some View {
        
        VStack {
            FakeNavBar(label: "Characters list")
            Spacer()
            BBPropertyView(propertyTitle: "Name", propertyValue: character.name)
            BBPropertyView(propertyTitle: "Status", propertyValue: character.status)
            BBPropertyView(propertyTitle: "Birthday", propertyValue: character.birthday)
            BBPropertyView(propertyTitle: "Nickname", propertyValue: character.nickname)
            BBPropertyView(propertyTitle: "Actor", propertyValue: character.portrayed)
            #if os(iOS) || os(macOS)
            NavPushButton(destination:
                            BBCharacterImageView(withURL: character.img)){
                Text("Show character image")
                    .foregroundColor(.blue)
                    .font(.title2)
                Spacer()
            }
            #else
            NavigationLink(destination:  BBCharacterImageView(withURL: character.img)) {
                Text("Show character image")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            #endif
        }
    }
}

struct BBPropertyView: View {
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

struct BBCharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavControllerView(transition: .custom(.slide))  {
            BBCharacterDetailsView(character: BBCharacter.getMockCharacter())
        }
    }
}
