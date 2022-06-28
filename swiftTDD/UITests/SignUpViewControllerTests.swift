import XCTest
import UIKit
import Presentation
@testable import UI


class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() throws {
        let sut = makeSut()
        
        XCTAssertEqual(sut.loadingIndicator?.isAnimating,false)

        
    }
    
    func test_loading_implements_loadingView() throws {
        let sut = makeSut()
     
        XCTAssertNotNil(sut as LoadingView)

        
    }
    
    func test_loading_implements_AlertView() throws {
        let sut = makeSut()

        XCTAssertNotNil(sut as AlertView)
       
    }
    
    

}
  
extension SignUpViewControllerTests {
    func makeSut() -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier:"SignUpViewController") as! SignUpViewController
        sut.loadViewIfNeeded()
        
        return sut
    }
    
}
