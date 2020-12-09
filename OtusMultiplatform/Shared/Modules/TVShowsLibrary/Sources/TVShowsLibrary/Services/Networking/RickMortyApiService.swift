import Foundation

final public class RickMortyApiService: BaseNetworkService, IService {
    
    let router = Router<RickMortyApi>()
    
    override public init() {
        super.init()
    }
    
    public class var service: RickMortyApiService {
        if let service: RickMortyApiService = TVShowsLibraryServiceLocator.service() {
            return service
        }
        
        let service = RickMortyApiService()
        TVShowsLibraryServiceLocator.addService(service)
        return service
    }
    
    public func clear() {
        
    }
    
    public func remove() {
        TVShowsLibraryServiceLocator.removeService(self)
    }
  
    public func loadRMCharacters( _ page: Int, completion: @escaping (_ characters: [RMCharacter]?, _ error: String?)->()) {
        
        router.request(.getCharacters(page: page)) { (data, response, error) in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        //TODO: add logger if needed
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(RMCharactersInfo.self, from: responseData)
                        completion(apiResponse.results, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    public func downloadRMImage(imageUrl: String, completion: @escaping (_ responseModel: Data?, _ error: String?)->()) {
        
        let router = Router<RickMortyApi>()
        
        router.request(.downloadImage(imageUrl)) { (data, response, error) in
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    completion(responseData, nil)
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
