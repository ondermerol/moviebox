//
//  MovieDetailModels.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit

// cover photo, title, overview, average vote, cast members, videos at least

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

/*
 
 {
     "adult": false,
     "backdrop_path": "/wjQXZTlFM3PVEUmKf1sUajjygqT.jpg",
     "belongs_to_collection": null,
     "budget": 0,
     "genres": [
         {
             "id": 878,
             "name": "Science Fiction"
         },
         {
             "id": 28,
             "name": "Action"
         },
         {
             "id": 53,
             "name": "Thriller"
         }
     ],
     "homepage": "https://www.paramountplus.com/movies/infinite/gkYk2Ju73QiIYX8TrooFblbsaUfPugRz/",
     "id": 581726,
     "imdb_id": "tt6654210",
     "original_language": "en",
     "original_title": "Infinite",
     "overview": "Evan McCauley has skills he never learned and memories of places he has never visited. Self-medicated and on the brink of a mental breakdown, a secret group that call themselves “Infinites” come to his rescue, revealing that his memories are real.",
     "popularity": 5354.043,
     "poster_path": "/niw2AKHz6XmwiRMLWaoyAOAti0G.jpg",
     "production_companies": [
         {
             "id": 435,
             "logo_path": "/AjzK0s2w1GtLfR4hqCjVSYi0Sr8.png",
             "name": "Di Bonaventura Pictures",
             "origin_country": "US"
         },
         {
             "id": 4,
             "logo_path": "/fycMZt242LVjagMByZOLUGbCvv3.png",
             "name": "Paramount",
             "origin_country": "US"
         },
         {
             "id": 8537,
             "logo_path": null,
             "name": "Closest to the Hole Productions",
             "origin_country": "US"
         },
         {
             "id": 114732,
             "logo_path": "/tNCbisMxO5mX2X2bOQxHHQZVYnT.png",
             "name": "New Republic Pictures",
             "origin_country": "US"
         },
         {
             "id": 8151,
             "logo_path": null,
             "name": "Fuqua Films",
             "origin_country": "US"
         }
     ],
     "production_countries": [
         {
             "iso_3166_1": "US",
             "name": "United States of America"
         }
     ],
     "release_date": "2021-09-08",
     "revenue": 0,
     "runtime": 106,
     "spoken_languages": [
         {
             "english_name": "English",
             "iso_639_1": "en",
             "name": "English"
         }
     ],
     "status": "Released",
     "tagline": "Grief. Hallucinations. Pride. Visions & Reminiscence",
     "title": "Infinite",
     "video": false,
     "vote_average": 0.0,
     "vote_count": 0
 }
 */
