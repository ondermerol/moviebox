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
        
        if collectionView == self.collectionviewForCredits {
            return (castMembersViewModel?.cast?.count).intValue
        }
        
        return (videoViewModel?.results?.count).intValue
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionviewForCredits {
            return CGSize(width: 150, height: 220)
        }
        
        return CGSize(width: 150, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if collectionView == self.collectionviewForCredits {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCell", for: indexPath) as! MovieCastCell
            let item: CastMemberViewModel? = castMembersViewModel?.cast?[indexPath.row]
            cell.viewModel = CastMemberViewModel(id: (item?.id).intValue,
                                                 name: (item?.name).stringValue,
                                                 imageUrl: (item?.imageUrl).stringValue)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.viewModel = VideoCellViewModel(videoUrl: videoViewModel?.results?[indexPath.row].key,
                                            index: indexPath.row)
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate protocol
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionviewForCredits {
    
            if let id = castMembersViewModel?.cast?[indexPath.row].id {
                openPersonDetail(personId: id)
            }
        } else {
            
            if let item: VideoModel = videoViewModel?.results?[indexPath.row], let key = item.key {
                let url = URL(string: "https://www.youtube.com/watch?v=\(key)")!
                UIApplication.shared.open(url)
            }
        }
    }
    
    // MARK: Actions
    
    func openPersonDetail(personId: Int) {
        router?.routeToPersonDetail(personId: personId)
    }
}

