//
//  DashboardViewInteractorTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class DashboardViewInteractorTests: XCTestCase {

    var sut: DashboardViewInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = DashboardViewInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Presentation Logic Spy
    
    class DashboardViewPresentationLogicSpy: DashboardViewPresentationLogic {
        
        var presentPopularMoviesCalled = false
        var presentBothSearchedPeopleAndMovieCalled = false
        
        func presentPopularMovies(movieListViewModel: MovieListViewModel, genreViewModel: GenreViewModel?) {
            presentPopularMoviesCalled = true
        }
        
        func presentBothSearchedPeopleAndMovie(movieListViewModel: MovieListViewModel, peopleListViewModel: PeopleListViewModel) {
            presentBothSearchedPeopleAndMovieCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentPopularMovies() {
        
        let spy = DashboardViewPresentationLogicSpy()
        sut.presenter = spy
        
        let predicate = NSPredicate(block: {any, _ in
            guard let spy = any as? DashboardViewPresentationLogicSpy else {
                return false
            }
            
            return spy.presentPopularMoviesCalled
        })
        _ = self.expectation(for: predicate, evaluatedWith: spy, handler: .none)
        
        sut.getPopularMovies(forpage: 1)
        
        waitForExpectations(timeout: 15, handler: .none)
    }
    
    func testPresentBothSearchedPeopleAndMovie() {
        
        let spy = DashboardViewPresentationLogicSpy()
        sut.presenter = spy
        
        let predicate = NSPredicate(block: {any, _ in
            guard let spy = any as? DashboardViewPresentationLogicSpy else {
                return false
            }
            
            return spy.presentBothSearchedPeopleAndMovieCalled
        })
        _ = self.expectation(for: predicate, evaluatedWith: spy, handler: .none)
        
        sut.searchBothMoviesAndPeople(forMoviePage: 1, forPeoplePage: 1, queryString: "A")
        
        waitForExpectations(timeout: 15, handler: .none)
    }
}
