//
//  DashboardViewModels.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

enum DashboardSections: Int {
    case Movie
    case Person
}

struct Genre: Decodable {
    let id: Int?
    let name: String?
}

struct GenreViewModel: Decodable {
    let genres: [Genre]?
}

struct Person: Decodable {
    let id: Int?
    let name: String?
    let imageUrl: String?
    let knownForDepartment: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "profile_path"
        case knownForDepartment = "known_for_department"
    }
}

struct PeopleListViewModel: Decodable {
    var items: [Person]?
    let totalPages: Int?
    let totalResults: Int?
    let page: Int?
    
    enum CodingKeys: String, CodingKey {
        case items = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page = "page"
    }
}

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let releaseDate: String?
    let averageVote: CGFloat?
    let genreIds: [Int]?
    var genreString: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case averageVote = "vote_average"
        case genreIds = "genre_ids"
        case genreString
    }
}

struct MovieListViewModel: Decodable {
    var items: [Movie]?
    let totalPages: Int?
    let totalResults: Int?
    let page: Int?
    
    enum CodingKeys: String, CodingKey {
        case items = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page = "page"
    }
}
