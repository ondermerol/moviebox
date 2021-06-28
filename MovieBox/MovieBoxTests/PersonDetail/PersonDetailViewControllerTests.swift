//
//  PersonDetailViewControllerTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class PersonDetailViewControllerTests: XCTestCase {

    var sut: PersonDetailViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        sut = PersonDetailViewController()
        sut.personDetailViewModel = PersonMockData.personDetail
        sut.movieCreditViewModel = PersonMockData.personMovieCredit
        window.addSubview(sut.view)
    }
    
    override func tearDown() {
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Routing Logic Spy
    
    class PersonDetailViewRoutingLogicSpy: NSObject, PersonDetailViewDataPassing & PersonDetailViewRoutingLogic {
  
        var dataStore: PersonDetailViewDataStore?
        
        var routeToBiographyDetailCalled = false
        var routeToMovieDetailCalled = false
        
        func routeToBiographyDetail(biography: String, actorName: String) {
            routeToBiographyDetailCalled = true
        }
        
        func routeToMovieDetail(movieId: Int) {
            routeToMovieDetailCalled = true
        }
    }
    
    // MARK: Tests
    
    func testInitPersonDetailViewController() {
        sut.loadView()
        XCTAssertNotNil(sut, "PersonDetail exists")
        XCTAssertNotNil(sut.interactor, "PersonDetail interactor exists")
        XCTAssertNotNil(sut.router, "PersonDetail Router exists")
        XCTAssertNotNil(sut.collectionView, "CollectionView exists")
    }
    
    func testSetViewModel() {
        XCTAssertNotNil(sut.personDetailViewModel, "View model exists")
    }
    
    func testCell() {
        
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = sut.collectionView(sut.collectionView!, cellForItemAt: indexPath) as? PersonCastCell
        let personName = cell?.viewModel?.title

        XCTAssertNotNil(cell)
        XCTAssertNotNil(personName)
        XCTAssert(personName == PersonMockData.personMovieCredit.cast?[0].title)
    }
    
    func testCollectionViewNumberOfRowsInSection() {
        let expectedRows = (PersonMockData.personMovieCredit.cast?.count).intValue
        XCTAssertTrue(expectedRows == sut.collectionView?.numberOfItems(inSection: 0))
    }
    
    func testRouteToMovieDetail() {
        
        let spy = PersonDetailViewRoutingLogicSpy()
        sut.router = spy
        
        sut.openMovieDetail(movieId: 1)
        
        XCTAssertTrue(spy.routeToMovieDetailCalled)
    }
    
    func testRouteToBiographyDetail() {
        
        let spy = PersonDetailViewRoutingLogicSpy()
        sut.router = spy
        
        sut.biographyAction(sender: UIBarButtonItem())
        
        XCTAssertTrue(spy.routeToBiographyDetailCalled)
    }
}
