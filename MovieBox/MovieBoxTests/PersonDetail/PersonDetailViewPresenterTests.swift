//
//  PersonDetailViewPresenterTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class PersonDetailViewPresenterTests: XCTestCase {

    var sut: PersonDetailViewPresenter!

    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = PersonDetailViewPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Display Logic Spy
    
    class PersonDetailViewDisplayLogicSpy: PersonDetailViewDisplayLogic {
        
        var displayPersonDetailCalled = false
        
        func displayPersonDetail(personDetail: PersonDetailViewModel, movieCredit: PersonMovieCreditViewModel) {
            displayPersonDetailCalled = true
        }
    }
    
    // MARK: Tests

    func testDisplayPersonDetail() {
        
        let spy = PersonDetailViewDisplayLogicSpy()
        sut.viewController = spy
        sut.presentPersonDetail(personDetail: PersonMockData.personDetail, movieCredit: PersonMockData.personMovieCredit)
        
        XCTAssertTrue(spy.displayPersonDetailCalled)
    }
}
