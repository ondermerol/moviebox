//
//  MovieDetailModels.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

struct CastMemberViewModel: Decodable {
    let id: Int
    let name: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "profile_path"
    }
}

struct CastMembersViewModel: Decodable {
    let id: Int
    let cast: [CastMemberViewModel]?
}


struct Genre: Decodable {
    let id: Int
    let name: String?
}

struct MovieDetailViewModel: Decodable {
    let id: Int
    let title: String?
    let overview: String?
    let averageVote: Float // vote_average
    let genres: [Genre]?
    let video: Bool?
    let imageUrl: String?
    let imbdId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case averageVote = "vote_average"
        case genres
        case video
        case imageUrl = "poster_path"
        case imbdId = "imdb_id"
    }
}
