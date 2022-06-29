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
    
    func test_saveButton_calls_signUp_on_tap() throws {
        var signUpViewModel: SignUpViewModel?
        
        let signUpSpy: (SignUpViewModel)-> Void = { signUpViewModel = $0 }
        let sut = makeSut(signUpSpy: signUpSpy )
        let name = sut.nameTextField?.text
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        let passwordConfirmation = sut.passwordConfirmationTextField?.text
        
        sut.saveButton?.simulateTap()
        XCTAssertEqual(signUpViewModel, SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation))
        
    }
    
    
    
}

extension SignUpViewControllerTests {
    func makeSut(signUpSpy: ((SignUpViewModel)-> Void)? = nil ) -> SignUpViewController {
        let sut = SignUpViewController.instatiate()
        sut.signUp = signUpSpy
        
        sut.loadViewIfNeeded()
        
        return sut
    }
    
    
    
    
}
