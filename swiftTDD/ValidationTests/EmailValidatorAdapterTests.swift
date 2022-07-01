import XCTest
import Presentation

public class EmailValidatorAdapter : EmailValidator{
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9 .-]+\\.[A-Za-z]{2,64}"

    
   public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try? NSRegularExpression(pattern: pattern)
        
        return regex?.firstMatch(in: email, options: [], range: range) != nil
    }
}

class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() throws {
        let sut = makeSut()
        
        XCTAssertFalse(sut.isValid(email:"rr"))
        XCTAssertFalse(sut.isValid(email:"rr@"))
        XCTAssertFalse(sut.isValid(email:"rr@rr"))
        XCTAssertFalse(sut.isValid(email:"rr@rr."))
        XCTAssertFalse(sut.isValid(email:"@rr.com"))
    }
    func test_valid_emails() throws {
        let sut = makeSut()
        
        XCTAssertTrue(sut.isValid(email:"matheuss2@gmail.com"))
        XCTAssertTrue(sut.isValid(email:"mathe@hotmail.com"))
        XCTAssertTrue(sut.isValid(email:"matheussouza18s@hotmail.com"))
    }
    
    

}

extension EmailValidatorAdapterTests{
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
    
    
}
