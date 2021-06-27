//
//  MovieDetailViewController+CollectionView.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource protocol
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (castMembersViewModel?.cast?.count).intValue
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCell", for: indexPath) as! MovieCastCell
        let item: CastMemberViewModel? = castMembersViewModel?.cast?[indexPath.row]
        cell.viewModel = CastMemberViewModel(id: (item?.id).intValue,
                                             name: (item?.name).stringValue,
                                             imageUrl: (item?.imageUrl).stringValue)
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = castMembersViewModel?.cast?[indexPath.row]
        
        if let id = item?.id {
            router?.routeToPersonDetail(personId: id)
        }
    }
}

