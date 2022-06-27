
import XCTest
import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeAlertViewModel(messageField: "O campo nome é obrigatório"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))

        wait(for: [exp], timeout: 1)
       
        
    }
    
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe {  viewModel in
            XCTAssertEqual(viewModel, makeAlertViewModel(messageField: "O campo email é obrigatório"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))

        wait(for: [exp], timeout: 1)
       
    }
    
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeAlertViewModel(messageField: "O campo senha é obrigatório"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))

        wait(for: [exp], timeout: 1)
        
    }
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeAlertViewModel(messageField: "O campo confirmar senha é obrigatório"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))

        wait(for: [exp], timeout: 1)
        
    }
    
    
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_not_match() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeAlertViewModel(messageField: "Falha ao confirmar senha"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "diffent_password"))

        wait(for: [exp], timeout: 1)
    }
    
    
    
    func test_signUp_should_call_emailValidator_with_correct_email() throws {
        
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        
        
        let signUpViewModel = makeSignUpViewModel()
        
        sut.signUp(viewModel: signUpViewModel)
        
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeAlertViewModel(messageField: "Email invalido"))
            exp.fulfill()
        }
        
        
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: makeSignUpViewModel(email:"invalid_email@email.com"))

        wait(for: [exp], timeout: 1)
    }
    
    
    
    func test_signUp_should_call_addAccount_with_correct_values() throws {
        let addAccountSpy = AddAccountSpy()
        
        
        let sut = makeSut(addAccount: addAccountSpy)
        
        sut.signUp(viewModel: makeSignUpViewModel())
        
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signUp_should_show_error_message_if_addAccount_fails() throws {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe {viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(messageField: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(email:"invalid_email@email.com"))
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_signUp_should_show_loading_before_and_after_addAccount() throws {
        let addAccountSpy = AddAccountSpy()
        let loadingViewSpy = LoadingViewSpy()
        let sut=makeSut(addAccount: addAccountSpy, loadingView:loadingViewSpy)
        let exp = expectation(description: "waiting")
        
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel,LoadingViewModel(isLoading:true))
            exp.fulfill()
        }
        sut.signUp(viewModel:makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        
        loadingViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel,LoadingViewModel(isLoading:false))
            exp2.fulfill()
        }
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)

    }
    
    func test_signUp_should_show_success_message_if_addAccount_succeeds() throws {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertViewModel(messageField: "Conta criada com sucesso"))
                           
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(email:"invalid_email@email.com"))
        addAccountSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 1)
    }
    
    

}


extension SignUpPresenterTests{
            func makeSut(alertView: AlertViewSpy = AlertViewSpy(),emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccountSpy = AddAccountSpy(),loadingView: LoadingViewSpy = LoadingViewSpy(), file:StaticString = #file,line:UInt = #line) ->  SignUpPresenter{
        
                let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
}
