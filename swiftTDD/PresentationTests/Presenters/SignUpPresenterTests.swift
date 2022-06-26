
import XCTest
import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(messageField: "O campo nome é obrigatório"))
    }
    
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        
       
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(messageField: "O campo email é obrigatório"))
    }
    
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(messageField: "O campo senha é obrigatório"))
    }
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(messageField: "O campo confirmar senha é obrigatório"))
    }
    
    
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_not_match() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
       
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "diffent_password"))
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(messageField: "Falha ao confirmar senha"))
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
        
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: makeSignUpViewModel(email:"invalid_email@email.com"))
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(messageField: "Email invalido"))
    }
    
    
    
    func test_signUp_should_call_addAccount_with_correct_values() throws {
       let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)

        sut.signUp(viewModel: makeSignUpViewModel())
        
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    
}
  

extension SignUpPresenterTests{
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(),emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccountSpy = AddAccountSpy()) ->  SignUpPresenter{
       
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount)
        
        return sut
    }
    
    func makeSignUpViewModel(name: String? = "any_name" ,email: String? = "any_email@email.com",password:String? = "any_password",passwordConfirmation:String? = "any_password") -> SignUpViewModel {
        
        return SignUpViewModel(name: name ,email: email,password: password,passwordConfirmation: passwordConfirmation)
    }
    
    func makeAlertViewModel(messageField: String) -> AlertViewModel {
        return AlertViewModel(title:"Falha na validação", message: messageField)
    }
    
    class AlertViewSpy: AlertView{
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
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
        
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            
        }
    }
}
