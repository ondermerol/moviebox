//
//  MovieDetailViewPresenterTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class MovieDetailViewPresenterTests: XCTestCase {

    var sut: MovieDetailViewPresenter!

    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailViewPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Display Logic Spy
    
    class MovieDetailViewDisplayLogicSpy: MovieDetailViewDisplayLogic {
        
        var displayMovieDetailCalled = false
        
        func displayMovieDetail(movieDetail: MovieDetailViewModel, castMembers: CastMembersViewModel, videoViewModel: VideoViewModel?) {
            displayMovieDetailCalled = true
        }
    }
    
    // MARK: Tests

    func testDisplayMovieDetail() {
        
        let spy = MovieDetailViewDisplayLogicSpy()
        sut.viewController = spy
        sut.presentMovieDetail(movieDetail: MovieMockData.movieDetail, castMembers: MovieMockData.castMembers, videoViewModel: nil)
        
        XCTAssertTrue(spy.displayMovieDetailCalled)
    }
}
