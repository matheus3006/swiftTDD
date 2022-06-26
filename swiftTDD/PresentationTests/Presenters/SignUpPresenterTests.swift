
import XCTest
import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self ] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(messageField: "O campo nome é obrigatório"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))

        wait(for: [exp], timeout: 1)
       
        
    }
    
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self ] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(messageField: "O campo email é obrigatório"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))

        wait(for: [exp], timeout: 1)
       
    }
    
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self ] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(messageField: "O campo senha é obrigatório"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))

        wait(for: [exp], timeout: 1)
        
    }
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self ] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(messageField: "O campo confirmar senha é obrigatório"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))

        wait(for: [exp], timeout: 1)
        
    }
    
    
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_not_match() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { [weak self ] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(messageField: "Falha ao confirmar senha"))
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
        
        alertViewSpy.observe { [weak self ] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(messageField: "Email invalido"))
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
        
        alertViewSpy.observe { [weak self ] viewModel in
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(messageField: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(email:"invalid_email@email.com"))
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    
}


extension SignUpPresenterTests{
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(),emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccountSpy = AddAccountSpy(), file:StaticString = #file,line:UInt = #line) ->  SignUpPresenter{
        
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func makeSignUpViewModel(name: String? = "any_name" ,email: String? = "any_email@email.com",password:String? = "any_password",passwordConfirmation:String? = "any_password") -> SignUpViewModel {
        
        return SignUpViewModel(name: name ,email: email,password: password,passwordConfirmation: passwordConfirmation)
    }
    
    func makeAlertViewModel(messageField: String) -> AlertViewModel {
        return AlertViewModel(title:"Falha na validação", message: messageField)
    }
    
    func makeErrorAlertViewModel(messageField: String) -> AlertViewModel {
        return AlertViewModel(title:"Error", message: messageField)
    }
    
    class AlertViewSpy: AlertView{
        var emit: ((AlertViewModel) -> Void)?
        
        func observe(completion: @escaping (AlertViewModel) -> Void){
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
        }
    }
    
    class EmailValidatorSpy: EmailValidator{
        var isValid = true
        var email: String?
        func isValid(email: String)-> Bool {
            self.email = email
            return isValid
        }
        
        func simulateInvalidEmail(){
            isValid = false
        }
    }
    
    
    
    class AddAccountSpy: AddAccount{
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>) -> Void)?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        
        func completeWithError(_ error: DomainError){
            completion?(.failure(error))
        }
    }
}
