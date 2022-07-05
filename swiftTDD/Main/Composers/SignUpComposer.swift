import Foundation
import UI
import Presentation
import Validation
import Data
import Infra
import Domain


public final class SignUpComposer {
    public static func composeControllerWith(addAccount: AddAccount) -> SignUpViewController{
        let controller = SignUpViewController.instatiate()
          let emailValidatorAdapter = EmailValidatorAdapter()
          
          let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, addAccount: addAccount, loadingView: WeakVarProxy(controller))
          controller.signUp = presenter.signUp
        
        return controller
    }
}
