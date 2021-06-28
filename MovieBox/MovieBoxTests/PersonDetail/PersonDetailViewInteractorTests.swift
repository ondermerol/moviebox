//
//  PersonDetailInteractorTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class PersonDetailInteractorTests: XCTestCase {

    var sut: PersonDetailViewInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = PersonDetailViewInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Presentation Logic Spy
    
    class PersonDetailViewPresentationLogicSpy: PersonDetailViewPresentationLogic {
        
        var presentPersonDetailCalled = false
        
        func presentPersonDetail(personDetail: PersonDetailViewModel, movieCredit: PersonMovieCreditViewModel) {
            presentPersonDetailCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentPersonDetail() {
        
        let spy = PersonDetailViewPresentationLogicSpy()
        sut.presenter = spy
        
        let predicate = NSPredicate(block: {any, _ in
            guard let spy = any as? PersonDetailViewPresentationLogicSpy else {
                return false
            }
            
            return spy.presentPersonDetailCalled
        })
        _ = self.expectation(for: predicate, evaluatedWith: spy, handler: .none)
        
        sut.getPersonDetail(forPersonId: 1)
        
        waitForExpectations(timeout: 15, handler: .none)
    }
}
