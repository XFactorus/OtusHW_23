import Foundation
import Combine
import SwiftUI
import TVShowsLibrary

final class BBCharacterImageViewModel: ObservableObject {
    @Published private(set) var characterImage = UIImage()
    
    private var imageUrlString: String?

    init(urlString:String) {
        self.imageUrlString = urlString
    }
    
    func loadCharacterImage() {
        
        guard let imageUrl = imageUrlString else {
            print("Empty image URL string")
            return
        }
        BreakingBadApiService.service.downloadBBImage(imageUrl: imageUrl)
        { (imageData, errorText) in
            guard let imageData = imageData, errorText == nil else {
                print(errorText ?? "Empty image")
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                print(errorText ?? "Cannot extract image from data")
                return
            }
            
            DispatchQueue.main.async {
                self.characterImage = image
            }
            
        }
    }
}
