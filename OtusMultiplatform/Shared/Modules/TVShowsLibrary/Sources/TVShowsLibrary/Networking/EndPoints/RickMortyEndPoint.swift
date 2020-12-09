
import Foundation

public enum RickMortyApi {
    case getCharacters(page: Int)
    case downloadImage(_ imageLink: String)
}

extension RickMortyApi: EndPointType {
    
    var environmentBaseURL : String {
        switch RickMortyApiService.service.getEnvironment() {
        case .production, .development: return "https://rickandmortyapi.com/api/"
        }
    }
    
    var baseURL: URL {
        switch self {
        case .downloadImage(let imageLink):
            guard let url = URL(string: imageLink) else { fatalError("baseURL could not be configured.")}
            return url
        default:
            guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
            return url
        }
    }
    
    var baseAuthenticationHeader: HTTPHeaders {
        return ["Authorization":"Basic \("")"]
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "character/"
        case .downloadImage:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
             return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getCharacters(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page])
        case .downloadImage:
            return .requestParameters(bodyParameters: nil,
                                                bodyEncoding: .urlEncoding,
                                                urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


