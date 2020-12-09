import Foundation
import RealmSwift

public protocol LoaderOutput {
    func charactersArrayLoaded<T: Codable>(characters: [T])
    func charactersLoadingFailed(errorText: String)
}

public final class LoaderService {
    
    private var rickMortyApiService: RickMortyApiService?
    private var breakingBadApiService: BreakingBadApiService?
    
    private var charactersService: CharactersService?
    
    private var notificationToken: NotificationToken?
    public var rmCharactersOutput: LoaderOutput?
    public var bbCharactersOutput: LoaderOutput?
    
    public init() {
        self.rickMortyApiService = TVShowsLibraryServiceLocator.service()
        self.breakingBadApiService = TVShowsLibraryServiceLocator.service()
        self.charactersService = TVShowsLibraryServiceLocator.service()
    }
    
    public func getApiRmCharacters( _ page: Int, completion: @escaping (_ characters: [RMCharacter]?, _ errorText: String?)->()) {
        
        rickMortyApiService?.loadRMCharacters(page) { (characters, errorText) in
           
            guard let characters = characters,
                  characters.count > 0,
                  errorText == nil else {
                let errorText = errorText ?? "Empty RM characters list"
                completion(nil, errorText)
                return
            }
            
            self.charactersService?.writeCharacters(characters, completion: { (errorText) in
                guard errorText == nil else {
                    completion(nil, errorText)
                    return
                }
                completion(characters, nil)
            })
        }
    }
    
    public func getApiBBCharacters(limit: Int, offset: Int, completion: @escaping (_ characters: [BBCharacter]?, _ errorText: String?)->()) {
        
        breakingBadApiService?.loadBBCharacters(limit: limit, offset: offset) { (characters, errorText) in
            
            guard let characters = characters,
                  characters.count > 0,
                  errorText == nil else {
                let errorText = errorText ?? "Empty BB characters list"
                completion(nil, errorText)
                return
            }
            
            self.charactersService?.writeCharacters(characters, completion: { (errorText) in
                guard errorText == nil else {
                    completion(nil, errorText)
                    return
                }
                completion(characters, nil)
            })
        }
    }
    
    public func loadDbRMCharacters() {
        guard let rmCharacters = self.charactersService?.readRMCharacters() else {
            self.rmCharactersOutput?.charactersLoadingFailed(errorText: "No RM characters loaded from DB")
            return
        }
        
        self.notificationToken = rmCharacters.observe (
            { [weak self] (changes) in
                
                switch changes
                {
                case .initial:
                    let items = Array(rmCharacters)
                    print("Initial load")
                    self?.rmCharactersOutput?.charactersArrayLoaded(characters: items)

                case .update(_, _, _, _):
                    let items = Array(rmCharacters)
                    print("Updated db load")
                    self?.rmCharactersOutput?.charactersArrayLoaded(characters: items)
                    
                case .error(let error):
                    self?.rmCharactersOutput?.charactersLoadingFailed(errorText: error.localizedDescription)
                }
            })
    }
    
    public func loadDbBBCharacters() {
        guard let rmCharacters = self.charactersService?.readBBCharacters() else {
            self.rmCharactersOutput?.charactersLoadingFailed(errorText: "No BB characters loaded from DB")
            return
        }
        
        self.notificationToken = rmCharacters.observe (
            { [weak self] (changes) in
                
                switch changes
                {
                case .initial:
                    let items = Array(rmCharacters)
                    print("Initial load")
                    self?.bbCharactersOutput?.charactersArrayLoaded(characters: items)
                    
                case .update(_, _, _, _):
                    let items = Array(rmCharacters)
                    print("Updated db load")
                    self?.bbCharactersOutput?.charactersArrayLoaded(characters: items)
                    
                case .error(let error):
                    self?.bbCharactersOutput?.charactersLoadingFailed(errorText: error.localizedDescription)
                }
            })
    }
    
}
