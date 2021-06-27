//
//  PersonDetailViewModels.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit

/*
 {
     "adult": false,
     "also_known_as": [
         "Jack Soloman",
         "Jack D. Solomon",
         "Jackson Solomon"
     ],
     "biography": "From Wikipedia, the free encyclopedia\n\nJack Solomon (March 8, 1913 – November 8, 2002) was an American sound engineer. He won an Oscar for Sound Recordingfor Hello, Dolly! (1969) and was nominated for five more in the same category. He worked on over 90 films between 1953 and 1991.",
     "birthday": "1913-03-08",
     "deathday": "2002-11-08",
     "gender": 2,
     "homepage": null,
     "id": 878,
     "imdb_id": "nm0813349",
     "known_for_department": "Sound",
     "name": "Jack Solomon",
     "place_of_birth": "Manhattan, New York, USA",
     "popularity": 0.997,
     "profile_path": null
 }
 */
struct PersonDetailViewModel: Decodable {
    let id: Int
    let name: String?
    let biography: String?
    let birthday: String?
    let imageUrl: String?
    let alsoKnownAs: [String]?
    //var movieCredits: [PersonMovieCredit]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case biography
        case birthday
        case imageUrl = "profile_path"
        case alsoKnownAs = "also_known_as"
        //case movieCredits
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
