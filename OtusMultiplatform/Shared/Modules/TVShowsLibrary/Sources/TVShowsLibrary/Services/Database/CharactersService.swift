import Foundation
import RealmSwift

public final class CharactersService {
    private var readRealm: Realm!
    
    let databaseService: DatabaseService?
    
    public init(){
        self.databaseService = TVShowsLibraryServiceLocator.service()
        readRealm = databaseService?.readRealm

    }
    
    func writeCharacters<T: Object>(_ characters: [T], completion: @escaping (_ errorText: String?)->()) {
//        DispatchQueue.global().async { // crashes in this thread
        DispatchQueue.main.async {
            autoreleasepool{
                [weak self] in
                
                guard let self = self else {return}
                
                let writeRealm = self.databaseService!.newRealm
                
                do
                {
                    try writeRealm.write
                    {
                        writeRealm.add(characters, update: .modified)
                        completion(nil)
                    }
                }
                catch
                {
                    completion(error.localizedDescription)
                }
            }
        }
    }
    
    func readRMCharacters() -> Results<RMCharacter>{
            return readRealm.objects(RMCharacter.self)
                .sorted(byKeyPath: RMCharacter.getPrimaryKey(), ascending: true)
    }
    
    func readBBCharacters() -> Results<BBCharacter>{
        return readRealm.objects(BBCharacter.self)
            .sorted(byKeyPath: BBCharacter.getPrimaryKey(), ascending: true)
    }
}

