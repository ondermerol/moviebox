//
//  DashboardViewController+Search.swift
//  MovieBox
//
//  Created by Wolverin Mm on 26.06.2021.
//

import UIKit

extension DashboardViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchText
        
        if !searchText.isEmpty {
//            let moviePage = (searchedMovieListViewModel?.page).intValue != 0 ? searchedMovieListViewModel?.page : 1
//            let peoplePage = (searchedPeopleListViewModel?.page).intValue != 0 ? searchedPeopleListViewModel?.page : 1
            interactor?.searchBothMoviesAndPeople(forMoviePage: 1,
                                                  forPeoplePage: 1,
                                                  queryString: searchText)
        } else {
            isSearching = false
            collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                        at: .top,
                                        animated: false)
            collectionView?.reloadData()
        }
    }
}
