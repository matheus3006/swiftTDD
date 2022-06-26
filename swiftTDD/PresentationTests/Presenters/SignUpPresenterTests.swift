
import XCTest
import Presentation

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
       let (sut, alertViewSpy) = makeSut()
        
        let signUpViewModel = SignUpViewModel(email: "any_email@mail.com",password:"any_password",passwordConfirmation:"any_password")
        
        sut.signUp(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação", message: "O campo nome é obrigatório"))
    }
    
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
       let (sut, alertViewSpy) = makeSut()
        
        let signUpViewModel = SignUpViewModel(name: "any_name",password:"any_password",passwordConfirmation:"any_password")
        
        sut.signUp(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação", message: "O campo email é obrigatório"))
    }
    
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
       let (sut, alertViewSpy) = makeSut()
        
        let signUpViewModel = SignUpViewModel(name: "any_name",email:"any_email@email.com",passwordConfirmation:"any_password")
        
        sut.signUp(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação", message: "O campo senha é obrigatório"))
    }
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() throws {
       let (sut, alertViewSpy) = makeSut()
        
        let signUpViewModel = SignUpViewModel(name: "any_name",email:"any_email@email.com",password:"any_password")
        
        sut.signUp(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação", message: "O campo confirmar senha é obrigatório"))
    }
    
    
    
    
    func test_signUp_should_show_error_message_if_passwordConfirmation_not_match() throws {
       let (sut, alertViewSpy) = makeSut()
        
        let signUpViewModel = SignUpViewModel(name: "any_name",email:"any_email@email.com",password:"any_password",passwordConfirmation:"diffent_password")
        
        sut.signUp(viewModel: signUpViewModel)
        
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title:"Falha na validação", message: "Falha ao confirmar senha"))
    }
    
}


extension SignUpPresenterTests{
    func makeSut() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy){
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        
        return (sut, alertViewSpy)
    }
    
    
    class AlertViewSpy: AlertView{
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    
}
