//
//  DashboardViewController+CollectionView.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 26.06.2021.
//

import UIKit

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource protocol
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return !isSearching || showEmptyState()  ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if showEmptyState() {
            collectionView.setEmptyMessage(message: "No Results")
        } else {
            collectionView.restore()
        }
        
        switch DashboardSections(rawValue: section) {
        case .Movie:
            let itemList = isSearching ? searchedMovieListViewModel : movieListViewModel
            return (itemList?.items.count).intValue
        case .Person:
            return (searchedPeopleListViewModel?.items.count).intValue
        case .none:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch DashboardSections(rawValue: indexPath.section) {
        case .Movie:
            
            let itemList = isSearching ? searchedMovieListViewModel : movieListViewModel
            
            if !isSearching
                && (itemList?.page).intValue < (itemList?.totalPages).intValue
                && indexPath.row == ((itemList?.items.count).intValue * (itemList?.page).intValue) - 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityIndicatorCell", for: indexPath)
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.viewModel = itemList?.items[indexPath.row]
            
            if let genreIds = cell.viewModel?.genreIds {
                cell.viewModel?.genreString = getGenreString(genreList: genreIds)
            }
            
            cell.configureCell((itemList?.items.count).intValue - 1 == indexPath.row)
            return cell
        case .Person:
            
            if isSearching {
                let itemList = searchedPeopleListViewModel
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
                cell.viewModel = itemList?.items[indexPath.row]
                cell.configureCell((itemList?.items.count).intValue - 1 == indexPath.row)
                return cell
            }
    
        case .none:
            break
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: Section Title
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            
            switch DashboardSections(rawValue: indexPath.section) {
            case .Movie:
                let itemList = isSearching ? searchedMovieListViewModel : movieListViewModel
                
                if (itemList?.items.count).intValue == 0 {
                    sectionHeader.label.text = ""
                } else {
                    sectionHeader.label.text = "Movies"
                }
            case .Person:
                if isSearching {
                    sectionHeader.label.text = "People"
                } else {
                    sectionHeader.label.text = ""
                }
                
            case .none:
                break
            }
            
             return sectionHeader
        } else { 
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if showEmptyState() {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if isSearching {
            return
        }
        
        let itemList = isSearching ? searchedMovieListViewModel : movieListViewModel
        
        if (itemList?.page).intValue < (itemList?.totalPages).intValue
            && indexPath.row == ((itemList?.items.count).intValue * (itemList?.page).intValue) - 1
            && !hasActivePaginationServiceCall {
            hasActivePaginationServiceCall = true
            interactor?.getPopularMovies(forpage: (itemList?.page).intValue + 1)
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch DashboardSections(rawValue: indexPath.section) {
        case .Movie:
            let itemList = isSearching ? searchedMovieListViewModel : movieListViewModel
            let movie = itemList?.items[indexPath.row]
            
            if let id = movie?.id {
                router?.routeToMovieDetail(movieId: id)
            }
            
        case .Person:
            let peopleItem = searchedPeopleListViewModel?.items[indexPath.row]
            
            if let id = peopleItem?.id {
                router?.routeToPersonDetail(personId: id)
            }
        case .none:
            break
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar?.endEditing(true)
    }
    
    // MARK: Private Helpers
    
    private func showEmptyState() -> Bool {
        return isSearching
            && (searchedMovieListViewModel?.items.count).intValue == 0
            && (searchedPeopleListViewModel?.items.count).intValue == 0
    }
    
    private func getGenreString(genreList: [Int]) -> String? {
        var resultStr: String?
        var filteredArray: [String] = []
        
        for genreId in genreList {
            
            if let name = self.genreViewModel?.genres?.filter({$0.id == genreId}).first?.name {
                filteredArray.append(name)
            }
        }
        
        for (index, name) in filteredArray.enumerated() {
            
            if index == 0 {
                resultStr = name
            } else {
                resultStr = resultStr.stringValue + ", " + name
            }
        }
        
        return resultStr
    }
}
