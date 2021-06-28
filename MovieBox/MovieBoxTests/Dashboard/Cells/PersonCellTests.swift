//
//  PersonCellTests.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import XCTest

import XCTest

class PersonCellTests: XCTestCase {

    var collectionView: UICollectionView?
    
    override func setUp() {
        super.setUp()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PersonCell.self, forCellWithReuseIdentifier: "PersonCell")
    }

    override func tearDown() {
        collectionView = nil
        super.tearDown()
    }
    
    private class MockDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
        
        var mockData = PersonMockData.personList
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return mockData.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
            cell.viewModel = mockData[indexPath.row]
            cell.configureCell(mockData.count - 1 == indexPath.row)
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
        
        let cell = spy.collectionView(collectionView, cellForItemAt: firstItemIndex) as! PersonCell
        
        XCTAssertNotNil(cell)
        cell.viewModel = PersonMockData.personList[0]
        cell.configureCell(false)
        
        XCTAssert(cell.viewModel?.id == PersonMockData.personList[0].id)
    }
}
