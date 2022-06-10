//
//  DataTests.swift
//  DataTests
//
//  Created by Matheus Souza on 6/10/22.
//

import XCTest

class RemoteAddAccount {
    private var url : URL
    private var httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient){
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(){
        httpClient.post(url: url)
    }
}

protocol HttpPostClient{
    func post(url: URL)
    
}


class RemoteAddAccountTests: XCTestCase {
    
    func test_add_should_call_httpClient_with_correct_url() throws {
        let url = URL(string:"http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add()
        
        XCTAssertEqual(httpClientSpy.url, url)
        
    }

    

}


extension RemoteAddAccountTests{
    
    class HttpClientSpy: HttpPostClient {
        var url : URL?
        func post(url: URL) {
            self.url=url

        }

    }
}
