//
//  PersonDetailViewController+CollectionView.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
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
        return CGSize(width: 150, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        let item = movieCreditViewModel?.cast?[indexPath.row]
        cell.viewModel = MovieCreditViewModel(id: (item?.id).intValue,
                                              title: (item?.title).stringValue,
                                              imageUrl: (item?.imageUrl).stringValue)
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = movieCreditViewModel?.cast?[indexPath.row]
        
        if let id = item?.id {
            router?.routeToMovieDetail(movieId: id)
        }
    }
    
}
