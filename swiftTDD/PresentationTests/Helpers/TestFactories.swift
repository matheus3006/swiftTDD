import Foundation
import Presentation



 func makeSignUpViewModel(name: String? = "any_name" ,email: String? = "any_email@email.com",password:String? = "any_password",passwordConfirmation:String? = "any_password") -> SignUpViewModel {
    
    return SignUpViewModel(name: name ,email: email,password: password,passwordConfirmation: passwordConfirmation)
}

 func makeAlertViewModel(messageField: String) -> AlertViewModel {
    return AlertViewModel(title:"Falha na validação", message: messageField)
}

 func makeErrorAlertViewModel(messageField: String) -> AlertViewModel {
    return AlertViewModel(title:"Error", message: messageField)
}

 func makeSuccessAlertViewModel(messageField: String) -> AlertViewModel {
    return AlertViewModel(title:"Sucesso", message: messageField)
}

