import Foundation

final public class BreakingBadApiService: BaseNetworkService, IService {
    
    let router = Router<BreakingBadApi>()
    
    override public init() {
        super.init()
    }
    
    public class var service: BreakingBadApiService {
        if let service: BreakingBadApiService = TVShowsLibraryServiceLocator.service() {
            return service
        }

        let service = BreakingBadApiService()
        TVShowsLibraryServiceLocator.addService(service)
        return service
    }
    
    public func clear() {
        
    }
    
    public func remove() {
        TVShowsLibraryServiceLocator.removeService(self)
    }
    
    public func loadBBCharacters(limit: Int, offset: Int, completion: @escaping (_ characters: [BBCharacter]?, _ error: String?)->()) {
        
        router.request(.getCharacters(limit: limit, offset: offset)) { (data, response, error) in
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
                        let apiResponse = try JSONDecoder().decode([BBCharacter].self, from: responseData)
                        completion(apiResponse,nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    public func downloadBBImage(imageUrl: String, completion: @escaping (_ responseModel: Data?, _ error: String?)->()) {
        
        let router = Router<BreakingBadApi>()
        
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
