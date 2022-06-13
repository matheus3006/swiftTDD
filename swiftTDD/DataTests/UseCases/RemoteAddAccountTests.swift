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
    
    
    func test_add_should_complete_with_error_if_client_complete_with_error() throws {
        let (sut,httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure(let error):XCTAssertEqual(error,.unexpected)

            case .success: XCTFail("Expected Error, received \(result) instead")
                
            }
            
            
            
            exp.fulfill()
        }
        httpClientSpy.completeWIthError(.noConnectivity)
        wait(for: [exp], timeout: 1)
//
        
    }
    
    func test_add_should_complete_with_error_if_client_complete_with_valid_data() throws {
        let (sut,httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        let expetedAccount = makeAccountModel()
        
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure: XCTFail("Expected sucess, received \(result) instead")
            case .success(let receivedAccount): XCTAssertEqual(receivedAccount, expetedAccount)

                
            }
            
            
            
            exp.fulfill()
        }
        httpClientSpy.completeWIthData(expetedAccount.toData()!)
        wait(for: [exp], timeout: 1)
//
        
    }

    
    
    
    func test_add_should_complete_with_error_if_client_complete_with_invalid_data() throws {
        let (sut,httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .failure(let error):XCTAssertEqual(error,.unexpected)

            case .success: XCTFail("Expected Error, received \(result) instead")
                
            }
             
            
            
            exp.fulfill()
        }
        httpClientSpy.completeWIthData(Data("invalid_data".utf8))
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
    
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "any_id" ,name: "any name", email: "any_email@email.com", password: "any_password")
    }
    
    
    class HttpClientSpy: HttpPostClient {
        var urls : [URL] = []
        var data : Data?
        var completion:((Result<Data,HttpError>) -> Void)?

        
        func post(to url: URL,with data: Data?, completion: @escaping (Result<Data, HttpError> ) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWIthError(_ error: HttpError){
            completion?(.failure(error))
        }
        
        func completeWIthData(_ data: Data){
            completion?(.success(data))
        }
    }
}
