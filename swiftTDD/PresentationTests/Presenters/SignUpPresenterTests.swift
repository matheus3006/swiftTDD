
import XCTest
import Presentation

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(fieldName: "O campo nome é obrigatório"))
    }
    
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        
       
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(fieldName: "O campo email é obrigatório"))
    }
    
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(fieldName: "O campo senha é obrigatório"))
    }
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(fieldName: "O campo confirmar senha é obrigatório"))
    }
    
    
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_not_match() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
       
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "diffent_password"))
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(fieldName: "Falha ao confirmar senha"))
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
        
        XCTAssertEqual(alertViewSpy.viewModel, makeAlertViewModel(fieldName: "Email invalido"))
    }
    
}
  

extension SignUpPresenterTests{
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(),emailValidator: EmailValidatorSpy = EmailValidatorSpy()) ->  SignUpPresenter{
       
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator)
        
        return sut
    }
    
    func makeSignUpViewModel(name: String? = "any_name" ,email: String? = "invalid_email@email.com",password:String? = "any_password",passwordConfirmation:String? = "any_password") -> SignUpViewModel {
        return SignUpViewModel(name: name ,email: email,password: password,passwordConfirmation: passwordConfirmation)
    }
    
    func makeAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title:"Falha na validação", message: fieldName)
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
    
}
