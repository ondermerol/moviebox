//
//  DashboardViewControllerTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class DashboardViewControllerTests: XCTestCase {

    var sut: DashboardViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        sut = DashboardViewController()
        sut.movieListViewModel = MovieListViewModel(items: MovieMockData.popularMovieList,
                                                    totalPages: 1,
                                                    totalResults: MovieMockData.popularMovieList.count,
                                                    page: 1)
        window.addSubview(sut.view)
        sut.collectionView?.reloadData()
    }
    
    override func tearDown() {
        sut = nil
        window = nil
        super.tearDown()
    }
    
    // MARK: Routing Logic Spy
    
    class DashboardViewRoutingLogicSpy: NSObject, DashboardViewDataPassing & DashboardViewRoutingLogic{
        
        var routeToMovieDetailCalled = false
        var routeToPersonDetailCalled = false
        
        func routeToMovieDetail(movieId: Int) {
            routeToMovieDetailCalled = true
        }
        
        func routeToPersonDetail(personId: Int) {
            routeToPersonDetailCalled = true
        }
        
        var dataStore: DashboardViewDataStore?
    }
    
    // MARK: Tests
    
    func testInitDashboardViewController() {
        sut.loadView()
        XCTAssertNotNil(sut, "Dashboard exists")
        XCTAssertNotNil(sut.interactor, "Dashboard interactor exists")
        XCTAssertNotNil(sut.router, "Dashboard Router exists")
        
        if sut.collectionView == nil {
            XCTAssert(false)
            return
        }
    }
    
    func testSetViewModel() {
        XCTAssertNotNil(sut.movieListViewModel, "View model exists")
    }
    
    func testCell() {
        
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = sut.collectionView(sut.collectionView!, cellForItemAt: indexPath) as? MovieCell
        let movieTitle = cell?.viewModel?.title
        
        XCTAssertNotNil(cell)
        XCTAssertNotNil(movieTitle)
        XCTAssert(movieTitle == MovieMockData.popularMovieList[0].title)
    }
    
    func testCollectionViewNumberOfRowsInSection() {
        let expectedRows = MovieMockData.popularMovieList.count
        XCTAssertTrue(expectedRows == sut.collectionView?.numberOfItems(inSection: 0))
    }
    
    func testRouteToMovieDetail() {
        
        let spy = DashboardViewRoutingLogicSpy()
        sut.router = spy
        
        sut.openMovieDetail(movieId: 1)
        
        XCTAssertTrue(spy.routeToMovieDetailCalled)
    }
    
    func testRouteToPersonDetail() {
        
        let spy = DashboardViewRoutingLogicSpy()
        sut.router = spy
        
        sut.openPersonDetail(personId: 1)
        
        XCTAssertTrue(spy.routeToPersonDetailCalled)
    }
}
