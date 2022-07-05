import Foundation

public final class EnvironmentHelper{
   public enum EnvironmentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
    }
   public static func variable(_ key: EnvironmentVariables) -> String {
        return Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
