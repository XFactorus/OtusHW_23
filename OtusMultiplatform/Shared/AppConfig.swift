import Foundation
import TVShowsLibrary

class AppConfig: NSObject {
    static let shared = AppConfig()
    
    override init() {
        super.init()
    }
    
    func setup() {
        TVShowsLibraryServiceLocator.addService(BreakingBadApiService())
        TVShowsLibraryServiceLocator.addService(RickMortyApiService())
        
        TVShowsLibraryServiceLocator.addService(DatabaseService())
        TVShowsLibraryServiceLocator.addService(CharactersService())
        TVShowsLibraryServiceLocator.addService(LoaderService())
    }
}
