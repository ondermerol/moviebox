//
//  DashboardViewController+Search.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 26.06.2021.
//

import UIKit

extension DashboardViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        
        if !searchText.isEmpty {
            interactor?.searchBothMoviesAndPeople(forMoviePage: 1,
                                                  forPeoplePage: 1,
                                                  queryString: searchText)
        } else {
            DispatchQueue.main.async {
                searchBar.endEditing(true)
            }
            
            isSearching = false
            collectionView?.setContentOffset(.zero, animated: false)
            collectionView?.reloadData()
        }
    }
}
