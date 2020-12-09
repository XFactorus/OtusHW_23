
import Foundation

public enum BreakingBadApi {
    case getCharacters(limit: Int, offset: Int)
    case downloadImage(_ imageLink: String)
}

extension BreakingBadApi: EndPointType {
    
    var environmentBaseURL : String {
        switch BreakingBadApiService.service.getEnvironment() {
        case .production, .development: return "https://www.breakingbadapi.com/api/"
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
            return "characters"
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
        case .getCharacters(let limit, let offset):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["limit":limit, "offset":offset])
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


