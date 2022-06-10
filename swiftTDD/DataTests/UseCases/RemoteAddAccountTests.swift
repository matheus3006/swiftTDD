import XCTest
import Domain
import Data


class RemoteAddAccountTests: XCTestCase {
    
    func test_add_should_call_httpClient_with_correct_url() throws {
        let url = URL(string:"http://any-url.com")!
        let (sut,httpClientSpy) = makeSut(url: url)
                
        sut.add(addAccountModel: makeAddAccountModel())
        
        XCTAssertEqual(httpClientSpy.url, url)
        
    }
    
    
    
    func test_add_should_call_httpClient_with_correct_data() throws {
        let (sut,httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        
        sut.add(addAccountModel: addAccountModel)
     
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
        
    }
    

}


extension RemoteAddAccountTests{
    func makeSut(url: URL = URL(string:"http://any-url.com")!) -> (sut: RemoteAddAccount, httpCLientSpy: HttpClientSpy){
        
        let httpClientSpy = HttpClientSpy()
        
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any name", email: "any_email@email.com", password: "any_password", passwordConfirmation: "any_password")
    }
    
    
    class HttpClientSpy: HttpPostClient {
        var url : URL?
        var data : Data?
        
        func post(to url: URL,with data: Data?) {
            self.url = url
            self.data = data

        }

    }
}
