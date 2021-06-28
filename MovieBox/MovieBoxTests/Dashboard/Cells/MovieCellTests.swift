//
//  MovieCellTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class MovieCellTests: XCTestCase {

    var collectionView: UICollectionView?
    
    override func setUp() {
        super.setUp()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
    }

    override func tearDown() {
        collectionView = nil
        super.tearDown()
    }
    
    private class MockDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
        
        var mockData = MovieMockData.popularMovieList
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return mockData.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.viewModel = mockData[indexPath.row]
            return cell
        }
    }
    
    // MARK: Tests
    
    func testCell() {
        let spy = MockDelegate()
        collectionView?.delegate = spy
        collectionView?.dataSource = spy
        let firstItemIndex = IndexPath(item: 0, section: 0)
        
        guard let collectionView = collectionView else {
            XCTAssert(false)
            return
        }
        
        let cell = spy.collectionView(collectionView, cellForItemAt: firstItemIndex) as! MovieCell
        
        XCTAssertNotNil(cell)
        cell.viewModel = MovieMockData.popularMovieList[0]
        
        XCTAssert(cell.viewModel?.id == MovieMockData.popularMovieList[0].id)
    }
}
