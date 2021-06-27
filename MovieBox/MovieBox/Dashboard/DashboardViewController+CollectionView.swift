//
//  DashboardViewController+CollectionView.swift
//  MovieBox
//
//  Created by Wolverin Mm on 26.06.2021.
//

import UIKit

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource protocol
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isSearching ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("isSearching 1 = \(isSearching)")
        
        if isSearching
            && (searchedMovieListViewModel?.items.count).intValue == 0
            && (searchedPeopleListViewModel?.items.count).intValue == 0 {
            
            collectionView.setEmptyMessage(message: "There is no any result.")
        } else {
            collectionView.restore()
        }
        
        switch DashboardSections(rawValue: section) {
        case .Movie:
            let moviewList = isSearching ? searchedMovieListViewModel : movieListViewModel
            return (moviewList?.items.count).intValue
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
        print("isSearching 2 = \(isSearching)")
        
        switch DashboardSections(rawValue: indexPath.section) {
        case .Movie:
            
            let moviewList = isSearching ? searchedMovieListViewModel : movieListViewModel
            
            if !isSearching
                && (moviewList?.page).intValue < (moviewList?.totalPages).intValue
                && indexPath.row == ((moviewList?.items.count).intValue * (moviewList?.page).intValue) - 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityIndicatorCell", for: indexPath)
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
            let movie = moviewList?.items[indexPath.row]
            cell.viewModel = CustomCellViewModel(name: (movie?.title).stringValue,
                                                 imageUrl: (movie?.posterPath).stringValue)
            return cell
        case .Person:
            
            if isSearching {
                let moviewList = searchedPeopleListViewModel
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
                let poeple = moviewList?.items[indexPath.row]
                cell.viewModel = CustomCellViewModel(name: (poeple?.name).stringValue,
                                                     imageUrl: (poeple?.image).stringValue)
                return cell
            }
    
        case .none:
            break
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: Section Title
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("isSearching 3 = \(isSearching)")
        
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            
            switch DashboardSections(rawValue: indexPath.section) {
            case .Movie:
                let moviewList = isSearching ? searchedMovieListViewModel : movieListViewModel
                
                if (moviewList?.items.count).intValue == 0 {
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
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if isSearching {
            return
        }
        
        let moviewList = isSearching ? searchedMovieListViewModel : movieListViewModel
        
        if (moviewList?.page).intValue < (moviewList?.totalPages).intValue
            && indexPath.row == ((moviewList?.items.count).intValue * (moviewList?.page).intValue) - 1
            && !hasActivePaginationServiceCall {
            hasActivePaginationServiceCall = true
            interactor?.getPopularMovies(forpage: (moviewList?.page).intValue + 1)
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch DashboardSections(rawValue: indexPath.section) {
        case .Movie:
            let moviewList = isSearching ? searchedMovieListViewModel : movieListViewModel
            let movie = moviewList?.items[indexPath.row]
            
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
    
}

class SectionHeader: UICollectionReusableView {
     
    var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .red
         label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
         label.sizeToFit()
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)

         addSubview(label)

         label.translatesAutoresizingMaskIntoConstraints = false
         label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
         label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
         label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
