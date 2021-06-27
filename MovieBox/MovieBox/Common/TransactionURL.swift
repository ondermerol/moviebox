//
//  TransactionURL.swift
//  MovieBox
//
//  Created by Wolverin Mm on 26.06.2021.
//

import Foundation

enum TransactionURL: String {
    case getPopularMovies = "https://api.themoviedb.org/3/movie/popular/"
    case searchMovies = "https://api.themoviedb.org/3/search/movie"
    case searchPeople = "https://api.themoviedb.org/3/search/person"
    case getPersonDetail = "https://api.themoviedb.org/3/person/%@"
    case getPersonMovieCredit = "https://api.themoviedb.org/3/person/%@/movie_credits"
    case getMovieDetail = "https://api.themoviedb.org/3/movie/%@"
    case getMovieCastMembers = "https://api.themoviedb.org/3/movie/%@/credits"
    
    var urlString: String {
        return self.rawValue
    }
}
