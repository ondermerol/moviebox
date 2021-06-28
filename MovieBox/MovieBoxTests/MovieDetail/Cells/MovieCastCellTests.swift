//
//  MovieCastCellTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

class MovieCastCellTests: XCTestCase {

    var collectionView: UICollectionView?
    
    override func setUp() {
        super.setUp()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(MovieCastCell.self, forCellWithReuseIdentifier: "MovieCastCell")
    }

    override func tearDown() {
        collectionView = nil
        super.tearDown()
    }
    
    private class MockDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
        
        var mockData = MovieMockData.castMembers.cast
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return (mockData?.count).intValue
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCell", for: indexPath) as! MovieCastCell
            cell.viewModel = mockData?[indexPath.row]
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
        
        let cell = spy.collectionView(collectionView, cellForItemAt: firstItemIndex) as! MovieCastCell
        
        XCTAssertNotNil(cell)
        cell.viewModel = MovieMockData.castMembers.cast?[0]
        
        XCTAssert(cell.viewModel?.id == MovieMockData.castMembers.cast?[0].id)
    }
}
