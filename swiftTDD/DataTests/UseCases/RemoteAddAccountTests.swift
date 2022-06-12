import XCTest
import Domain
import Data


class RemoteAddAccountTests: XCTestCase {
    
    func test_add_should_call_httpClient_with_correct_url() throws {
        let url = URL(string:"http://any-url.com")!
        let (sut,httpClientSpy) = makeSut(url: url)
                
        sut.add(addAccountModel: makeAddAccountModel()){ _ in }
        
        XCTAssertEqual(httpClientSpy.urls, [url])
        
    }
    
    
    
    func test_add_should_call_httpClient_with_correct_data() throws {
        let (sut,httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        
        sut.add(addAccountModel: addAccountModel){ _ in }
     
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
        
    }
    
    
    func test_add_should_complete_with_error_if_client_fails() throws {
        let (sut,httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: makeAddAccountModel()) { error in
            
            XCTAssertEqual(error, .unexpected)
            exp.fulfill()
        }
        httpClientSpy.completeWIthError(.noConnectivity)
        wait(for: [exp], timeout: 1)
//
        
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
        var urls : [URL] = []
        var data : Data?
        var completion: ((HttpError) -> Void)?
        
        func post(to url: URL,with data: Data?, completion: @escaping (HttpError) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWIthError(_ error: HttpError){
            completion?(error)
        }
    }
}
