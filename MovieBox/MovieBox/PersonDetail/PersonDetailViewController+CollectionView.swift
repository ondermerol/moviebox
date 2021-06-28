//
//  PersonDetailViewController+CollectionView.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

extension PersonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource protocol
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (movieCreditViewModel?.cast?.count).intValue
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCastCell", for: indexPath) as! PersonCastCell
        let item = movieCreditViewModel?.cast?[indexPath.row]
        cell.viewModel = MovieCreditViewModel(id: (item?.id).intValue,
                                              title: (item?.title).stringValue,
                                              imageUrl: (item?.imageUrl).stringValue)
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate protocol
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = movieCreditViewModel?.cast?[indexPath.row]
        
        if let id = item?.id {
            openMovieDetail(movieId: id)
        }
    }
    
    // MARK: Actions
    
    func openMovieDetail(movieId: Int) {
        router?.routeToMovieDetail(movieId: movieId)
    }
}
