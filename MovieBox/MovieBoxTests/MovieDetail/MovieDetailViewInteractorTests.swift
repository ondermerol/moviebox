//
//  MovieDetailInteractorTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class MovieDetailInteractorTests: XCTestCase {

    var sut: MovieDetailViewInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailViewInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Presentation Logic Spy
    
    class MovieDetailViewPresentationLogicSpy: MovieDetailViewPresentationLogic {
        
        var presentMovieDetailCalled = false
        
        func presentMovieDetail(movieDetail: MovieDetailViewModel, castMembers: CastMembersViewModel, videoViewModel: VideoViewModel?) {
            presentMovieDetailCalled = true
        }
    }
    
    // MARK: Tests

    func testPresentMovieDetail() {
        
        let spy = MovieDetailViewPresentationLogicSpy()
        sut.presenter = spy
        
        let predicate = NSPredicate(block: {any, _ in
            guard let spy = any as? MovieDetailViewPresentationLogicSpy else {
                return false
            }
            
            return spy.presentMovieDetailCalled
        })
        _ = self.expectation(for: predicate, evaluatedWith: spy, handler: .none)
        
        sut.getMoviewDetail(forMoviewId: 604)
        
        waitForExpectations(timeout: 15, handler: .none)
    }
}
