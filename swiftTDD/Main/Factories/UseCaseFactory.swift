import Foundation
import Data
import Infra
import Domain




final class useCaseFactory {
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = "http://localhost:5050/api"
    
    private static func makeUrl(path: String)-> URL{
        return URL(string: "\(apiBaseUrl)/\(path)")!
    }
    static func makeRemoteAddAccount() -> AddAccount {
         return RemoteAddAccount(url: makeUrl(path:"signUp"), httpClient: httpClient)
    }
}
