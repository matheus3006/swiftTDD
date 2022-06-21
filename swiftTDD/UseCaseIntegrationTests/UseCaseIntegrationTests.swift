import XCTest
import Data
import Infra
import Domain

class UseCaseIntegrationTests: XCTestCase {

    func test_add_account(){
        let alamofireAdapter=AlamofireAdapter()
        let url = URL(string:"https://clean-node-api.herokuapp.com/api/signup")!
        let sut=RemoteAddAccount(url:url,httpClient:alamofireAdapter)
        let addAccountModel=AddAccountModel(name:"Matheus de Souza",email:"matheussouza18bussiness@gmail.com",
                                            password:"secret",passwordConfirmation:"secret")
       
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel:addAccountModel){ result in
            switch result{
            case .failure:XCTFail("Expect success got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.id)
                XCTAssertEqual(account.name,addAccountModel.name)
                XCTAssertEqual (account.email,addAccountModel.email)
                
            }

            exp.fulfill()
        }

       wait(for: [exp], timeout: 20)
    }


}
