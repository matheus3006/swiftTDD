import XCTest
import Validation
import Presentation

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
