import Foundation
import Combine
import TVShowsLibrary

final class RMCharactersViewModel: ObservableObject, LoaderOutput {

    @Published private(set) var listDataSource = [RMCharacter]()
    
    @Published private(set) var isPageLoading = false
    @Published private(set) var page: Int = 1
    
    private let pageLimit = 20
    private var loaderService: LoaderService? = TVShowsLibraryServiceLocator.service()
    private var initialInfoLoaded = false
    
    init(isMock: Bool = false) {
        if isMock {
            self.loadMockData()
        }
    }

    func loadInitialList() {
        if !initialInfoLoaded {
            initialInfoLoaded.toggle()
            loadDbData()
            fetchPage()
        }
    }
    
    private func loadDbData() {
        loaderService?.rmCharactersOutput = self
        loaderService?.loadDbRMCharacters()
    }
    
    func fetchIfRequired(index: Int) {
        if index > 0, (index + 1) % pageLimit == 0 {
            fetchPage()
        }
    }
    
    func fetchPage() {
        
        guard isPageLoading == false else {
            return
        }
  
        isPageLoading = true
                
        loaderService?.getApiRmCharacters(page) { (characters, errorText) in
            DispatchQueue.main.async {
                self.isPageLoading = false

                guard let characters = characters, errorText == nil else {
                    print(errorText ?? "Empty RM characters list loaded from API")
                    return
                }
                
                print("\(characters.count) RM characters loaded from API")
                self.page += 1
            }
        }
    }
    
    func loadMockData() {
        listDataSource = [RMCharacter.getMockCharacter(), RMCharacter.getMockCharacter()]
    }
    
    // MARK: Loader delegates
    
    func charactersArrayLoaded<T>(characters: [T]) where T : Codable {
        if let characters = characters as? [RMCharacter] {
            print("\(characters.count) RM characters loaded from DB")
            self.listDataSource = characters
        }
    }
    
    func charactersLoadingFailed(errorText: String) {
        print("Cannot load RM characters from DB: \(errorText)")
    }
}

