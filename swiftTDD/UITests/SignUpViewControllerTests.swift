import XCTest
import UIKit
import Presentation
@testable import UI


class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() throws {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier:"SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating,false)

        
    }
    
    func test_loading_implements_loadingView() throws {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier:"SignUpViewController") as! SignUpViewController
        XCTAssertNotNil(sut as LoadingView)

        
    }
    
    func test_loading_implements_AlertView() throws {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier:"SignUpViewController") as! SignUpViewController
        XCTAssertNotNil(sut as AlertView)

        
    }
    
    

}
  
