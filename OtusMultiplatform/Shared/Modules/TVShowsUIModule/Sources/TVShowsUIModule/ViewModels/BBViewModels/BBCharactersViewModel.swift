
import Foundation
import Combine
import TVShowsLibrary

final class BBCharactersViewModel: ObservableObject, LoaderOutput {
    
    @Published private(set) var listDataSource = [BBCharacter]()
    
    @Published private(set) var isPageLoading = false
    @Published private(set) var offset: Int = 0
    
    private var loaderService: LoaderService? = TVShowsLibraryServiceLocator.service()
    
    private var initialInfoLoaded = false
    private let pageLimit = 20
    
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
        loaderService?.bbCharactersOutput = self
        loaderService?.loadDbBBCharacters()
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
                
        loaderService?.getApiBBCharacters(limit: pageLimit, offset: offset) { (characters, errorText) in
            DispatchQueue.main.async {
                self.isPageLoading = false

                guard let characters = characters, errorText == nil else {
                    print(errorText ?? "Empty character")
                    return
                }
                self.offset += self.pageLimit
                print("\(characters.count) BB characters loaded from API")
//                self.listDataSource.append(contentsOf: characters)
            }
        }
    }
    
    func loadMockData() {
        self.listDataSource = [BBCharacter .getMockCharacter(), BBCharacter.getMockCharacter()]
    }
    
    // MARK: Loader delegates
    
  
    
    func charactersLoadingFailed(errorText: String) {
        print("Cannot load BB characters from DB: \(errorText)")
    }
    
    func charactersArrayLoaded<T>(characters: [T]) where T : Codable {
        if let characters = characters as? [BBCharacter] {
            print("\(characters.count) BB characters loaded from DB")
            self.listDataSource = characters
        }
    }
    
}

