
import Foundation
import Domain


public final class SignUpPresenter{
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount
    private let loadingView: LoadingView
    
    public init(alertView:AlertView, emailValidator: EmailValidator, addAccount: AddAccount, loadingView: LoadingView){
        self.alertView=alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loadingView = loadingView
    }
    
   public func signUp(viewModel: SignUpViewModel){
        if let message = validate(viewModel: viewModel){
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
            
        } else{
                       
            loadingView.display(viewModel:LoadingViewModel(isLoading:true))

            addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel: viewModel)) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso"))
                
                }
                 
                self.loadingView.display(viewModel:LoadingViewModel(isLoading:false))
            }
        }
       
       
      
       
        
    }
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "O campo nome é obrigatório"
            
        }
        
        if viewModel.email == nil || viewModel.email!.isEmpty {
           return "O campo email é obrigatório"
            
        }
        
        
        if viewModel.password == nil || viewModel.password!.isEmpty {
            return "O campo senha é obrigatório"
            
        }
        
        
        if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
          return "O campo confirmar senha é obrigatório"
            
        }
        
        
        if viewModel.password != viewModel.passwordConfirmation {
          return "Falha ao confirmar senha"
            
        }
        
        
        if !emailValidator.isValid(email: viewModel.email!) {
          return "Email invalido"
            
        }
       
        return nil
    }
    
}
