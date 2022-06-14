import Foundation

func makeInvalidData()-> Data{
    return Data("invalid_data".utf8)
}

func makeValidData()-> Data{
    return Data("{\"name\":\"matheus\"}".utf8)
}


func makeError()-> Error{ 
    return NSError(domain:"any_error",code:0)
}

func makeURL() -> URL {
    return URL(string:"http://any-url.com")!
}

func makeHttpResponse(statusCode: Int = 200)->HTTPURLResponse{
    return HTTPURLResponse(url:makeURL(),statusCode:statusCode,httpVersion:nil,headerFields:nil)!

}

func makeEmptyData() -> Data {
    return Data()
}
