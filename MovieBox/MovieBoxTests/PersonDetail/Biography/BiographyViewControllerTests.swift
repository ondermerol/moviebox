//
//  BiographyViewControllerTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class BiographyViewControllerTests: XCTestCase {
    
    var sut: BiographyViewController!
    var window: UIWindow!
    var biographyExampleText: String?
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        sut = BiographyViewController()
        biographyExampleText = "Biography information.."
        sut.router?.dataStore?.biographyText = biographyExampleText
        sut.router?.dataStore?.name = "Al Pacino"
        window.addSubview(sut.view)
    }
    
    override func tearDown() {
        sut = nil
        window = nil
        super.tearDown()
    }
    
    // MARK: Routing Logic Spy
    
    class BiographyViewRoutingLogicSpy: NSObject & BiographyViewDataPassing & BiographyViewRoutingLogic {
        
        var dataStore: BiographyViewDataStore?
        
        var routeBackCalled = false
        
        func routeBack() {
            routeBackCalled = true
        }
    }
    
    // MARK: Tests
    
    func testInitBiographyViewController() {
        sut.loadView()
        XCTAssertNotNil(sut, "Biography exists")
        XCTAssertNotNil(sut.router, "Biography Router exists")
    }
    
    func testBiographyText() {
        let textVewBiography = sut.view.viewWithTag(100) as? UITextView
        
        XCTAssertNotNil(textVewBiography)
        XCTAssert(biographyExampleText == textVewBiography?.text)
    }
    
    func testRouteBack() {
        
        let spy = BiographyViewRoutingLogicSpy()
        sut.router = spy
        
        sut.closeAction(sender: UIBarButtonItem())
        
        XCTAssertTrue(spy.routeBackCalled)
    }
}
