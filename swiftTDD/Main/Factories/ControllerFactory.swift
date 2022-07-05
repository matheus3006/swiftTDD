
import Foundation
import UI
import Presentation
import Validation
import Data
import Infra
import Domain

class ControllerFactory{
    static func makeSignUp(addAccount: AddAccount)-> SignUpViewController {
      let controller = SignUpViewController.instatiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, addAccount: addAccount, loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.signUp

        return controller

    }

}

class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instace: T){
        self.instance = instace
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}