//
//  MovieDetailViewControllerTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class MovieDetailViewControllerTests: XCTestCase {

    var sut: MovieDetailViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        sut = MovieDetailViewController()
        sut.castMembersViewModel = MovieMockData.castMembers
        sut.movieDetailViewModel = MovieMockData.movieDetail
        sut.videoViewModel = MovieMockData.videoViewModel
        window.addSubview(sut.view)
    }
    
    override func tearDown() {
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Routing Logic Spy
    
    class MovieDetailViewRoutingLogicSpy: NSObject, MovieDetailViewDataPassing & MovieDetailViewRoutingLogic {
        
        var dataStore: MovieDetailViewDataStore?
        
        var routeToPersonDetailCalled = false
        var routeToOverviewPageCalled = false
        
        func routeToPersonDetail(personId: Int) {
            routeToPersonDetailCalled = true
        }
        
        func routeToOverviewPage(overview: String, movieName: String) {
            routeToOverviewPageCalled = true
        }
    }
    
    // MARK: Tests
    
    func testInitPersonDetailViewController() {
        sut.loadView()
        XCTAssertNotNil(sut, "MovieDetail exists")
        XCTAssertNotNil(sut.interactor, "MovieDetail interactor exists")
        XCTAssertNotNil(sut.router, "MovieDetail Router exists")
        XCTAssertNotNil(sut.collectionviewForVideos, "CollectionView for videos exists")
        XCTAssertNotNil(sut.collectionviewForCredits, "CollectionView for videos exists")
    }
    
    func testSetViewModel() {
        XCTAssertNotNil(sut.movieDetailViewModel, "View model exists")
    }
    
    func testVideoCell() {
        
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = sut.collectionView(sut.collectionviewForVideos!, cellForItemAt: indexPath) as? VideoCell
        let videoUrl = cell?.viewModel?.videoUrl

        XCTAssertNotNil(cell)
        XCTAssertNotNil(videoUrl)
        XCTAssert(videoUrl == MovieMockData.videoViewModel.results?[0].key)
    }
    
    func testMovieCastCell() {
        
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = sut.collectionView(sut.collectionviewForCredits!, cellForItemAt: indexPath) as? MovieCastCell
        let name = cell?.viewModel?.name

        XCTAssertNotNil(cell)
        XCTAssertNotNil(name)
        XCTAssert(name == MovieMockData.castMembers.cast?[0].name)
    }
    
    func testCollectionViewNumberOfRowsInVideoSection() {
        let expectedRows = (MovieMockData.videoViewModel.results?.count).intValue
        XCTAssertTrue(expectedRows == sut.collectionviewForVideos?.numberOfItems(inSection: 0))
    }
    
    func testCollectionViewNumberOfRowsInMovieCastSection() {
        let expectedRows = (MovieMockData.castMembers.cast?.count).intValue
        XCTAssertTrue(expectedRows == sut.collectionviewForCredits?.numberOfItems(inSection: 0))
    }
    
    func testRouteToPersonDetail() {
        
        let spy = MovieDetailViewRoutingLogicSpy()
        sut.router = spy
        
        sut.openPersonDetail(personId: 1)
        
        XCTAssertTrue(spy.routeToPersonDetailCalled)
    }
    
    func testRouteToOverviewPage() {
        
        let spy = MovieDetailViewRoutingLogicSpy()
        sut.router = spy
        
        sut.overViewAction(sender: UIBarButtonItem())
        
        XCTAssertTrue(spy.routeToOverviewPageCalled)
    }
}
