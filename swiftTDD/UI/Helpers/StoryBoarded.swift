import Foundation
import UIKit

public protocol StoryBoarded {
    static func instatiate() -> Self
    
    
}

extension StoryBoarded where Self: UIViewController {
    public static func instatiate() -> Self {
        let viewControllerName = String(describing: self)
        let storyBoardName = viewControllerName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        
        let sb = UIStoryboard(name: storyBoardName, bundle: bundle)
        return sb.instantiateViewController(withIdentifier: viewControllerName) as! Self
    }
}
