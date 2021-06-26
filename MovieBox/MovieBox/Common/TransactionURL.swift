//
//  TransactionURL.swift
//  MovieBox
//
//  Created by Wolverin Mm on 26.06.2021.
//

import Foundation

enum TransactionURL: String {
    case getPopularMovies = "https://api.themoviedb.org/3/movie/popular/"
    
    var urlString: String {
        return self.rawValue
    }
}
