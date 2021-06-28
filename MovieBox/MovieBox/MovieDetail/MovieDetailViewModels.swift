//
//  MovieDetailModels.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

struct CastMemberViewModel: Decodable {
    let id: Int?
    let name: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "profile_path"
    }
}

struct CastMembersViewModel: Decodable {
    let id: Int?
    let cast: [CastMemberViewModel]?
}

struct MovieDetailViewModel: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let averageVote: Float?
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

struct VideoModel: Decodable {
    let id: String?
    let name: String?
    let key: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case key
    }
}

struct VideoViewModel: Decodable {
    let results: [VideoModel]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct VideoCellViewModel: Decodable {
    let videoUrl: String?
    let index: Int
}
