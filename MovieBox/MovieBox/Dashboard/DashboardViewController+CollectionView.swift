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
        return Constants.sectionNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("isSearching 1 = \(isSearching)")
        let moviewList = isSearching ? searchedMovieListViewModel : movieListViewModel
        
        if (moviewList?.items.count).intValue == 0 {
            collectionView.setEmptyMessage(message: "There is no any result.")
        } else {
            collectionView.restore()
        }
        
        switch DashboardSections(rawValue: section) {
        case .Movie:
            return (moviewList?.items.count).intValue // TODO:Mock
        case .Person:
            return 0
        case .none:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("isSearching 2 = \(isSearching)")
        let moviewList = isSearching ? searchedMovieListViewModel : movieListViewModel
        
        if (moviewList?.page).intValue < (moviewList?.totalPages).intValue
            && indexPath.row == ((moviewList?.items.count).intValue * (moviewList?.page).intValue) - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityIndicatorCell", for: indexPath)
            return cell
        }
        
        switch DashboardSections(rawValue: indexPath.section) {
        case .Movie:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
            let movie = moviewList?.items[indexPath.row]
            cell.viewModel = CustomCellViewModel(name: (movie?.title).stringValue,
                                                 imageUrl: (movie?.posterPath).stringValue)
            return cell
        case .Person:
            break
        case .none:
            break
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: Section Title
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("isSearching 3 = \(isSearching)")
        let moviewList = isSearching ? searchedMovieListViewModel : movieListViewModel
        
        if kind == UICollectionView.elementKindSectionHeader {
             let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
            
            if (moviewList?.items.count).intValue == 0 {
                sectionHeader.label.text = ""
            } else {
                switch DashboardSections(rawValue: indexPath.section) {
                case .Movie:
                    sectionHeader.label.text = "Students"
                case .Person:
                    sectionHeader.label.text = "Cars"
                case .none:
                    break
                }
            }
            
             return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("Index path = \(indexPath)  --  hasActivePaginationServiceCall = \(hasActivePaginationServiceCall)")
        print("isSearching 4 = \(isSearching)")
        let moviewList = isSearching ? searchedMovieListViewModel : movieListViewModel
        
        if (moviewList?.page).intValue < (moviewList?.totalPages).intValue
            && indexPath.row == ((moviewList?.items.count).intValue * (moviewList?.page).intValue) - 1
            && !hasActivePaginationServiceCall {
            hasActivePaginationServiceCall = true
            
            if isSearching {
                interactor?.searchMovies(forpage: (moviewList?.page).intValue + 1, queryString: searchText)
            } else {
                interactor?.getPopularMovies(forpage: (moviewList?.page).intValue + 1)
            }
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
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
         label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
         label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
