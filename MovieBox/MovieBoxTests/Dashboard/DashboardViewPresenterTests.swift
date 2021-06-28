//
//  DashboardViewPresenterTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class DashboardViewPresenterTests: XCTestCase {

    var sut: DashboardViewPresenter!

    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = DashboardViewPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Display Logic Spy
    
    class DashboardViewDisplayLogicSpy: DashboardViewDisplayLogic {
        
        var displayPopularMoviesCalled = false
        var displayBothSearchedPeopleAndMovieCalled = false
        
        func displayPopularMovies(movieListViewModel: MovieListViewModel, genreViewModel: GenreViewModel?) {
            displayPopularMoviesCalled = true
        }
        
        func displayBothSearchedPeopleAndMovie(movieListViewModel: MovieListViewModel, peopleListViewModel: PeopleListViewModel) {
            displayBothSearchedPeopleAndMovieCalled = true
        }
    }
    
    // MARK: Tests
    
    func testDisplayPopularMovies() {
        
        let spy = DashboardViewDisplayLogicSpy()
        sut.viewController = spy
        sut.presentPopularMovies(movieListViewModel: MovieListViewModel(items: MovieMockData.popularMovieList,
                                                                        totalPages: 1,
                                                                        totalResults: MovieMockData.popularMovieList.count,
                                                                        page: 1),
                                 genreViewModel: nil)
        
        XCTAssertTrue(spy.displayPopularMoviesCalled)
    }
    
    func testDisplayBothSearchedPeopleAndMovie() {
        
        let spy = DashboardViewDisplayLogicSpy()
        sut.viewController = spy
        sut.presentBothSearchedPeopleAndMovie(movieListViewModel: MovieListViewModel(items: MovieMockData.popularMovieList,
                                                                                     totalPages: 1,
                                                                                     totalResults: MovieMockData.popularMovieList.count,
                                                                                     page: 1),
                                              peopleListViewModel: PeopleListViewModel(items: PersonMockData.personList,
                                                                                       totalPages: 1,
                                                                                       totalResults: PersonMockData.personList.count,
                                                                                       page: 1))
        
        XCTAssertTrue(spy.displayBothSearchedPeopleAndMovieCalled)
    }
}
