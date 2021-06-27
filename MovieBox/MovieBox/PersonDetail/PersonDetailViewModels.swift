//
//  PersonDetailViewModels.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

struct PersonDetailViewModel: Decodable {
    let id: Int
    let name: String?
    let biography: String?
    let birthday: String?
    let imageUrl: String?
    let alsoKnownAs: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case biography
        case birthday
        case imageUrl = "profile_path"
        case alsoKnownAs = "also_known_as"
    }
}

struct PersonMovieCreditViewModel: Decodable {
    let id: Int
    let cast: [MovieCreditViewModel]?
}

struct MovieCreditViewModel: Decodable {
    let id: Int
    let title: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "poster_path"
    }
}
