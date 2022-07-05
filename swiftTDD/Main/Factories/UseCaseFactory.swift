import Foundation
import Data
import Infra
import Domain




final class useCaseFactory {
    static func makeRemoteAddAccount() -> AddAccount {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "http://localhost:5050/api/signup")!
        return RemoteAddAccount(url: url, httpClient: alamofireAdapter)
    }
}
