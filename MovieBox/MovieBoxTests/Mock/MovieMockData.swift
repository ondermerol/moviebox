//
//  MovieMockData.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import Foundation

enum MovieMockData {
    
    static var popularMovieList: [Movie]  {
        
        let movie1 = Movie(id: 1,
                           title: "Moview 1",
                           posterPath: "",
                           releaseDate: "",
                           averageVote: 8.2,
                           genreIds: nil,
                           genreString: "")
        
        let movie2 = Movie(id: 2,
                           title: "Moview 1",
                           posterPath: "",
                           releaseDate: "",
                           averageVote: 6.5,
                           genreIds: nil,
                           genreString: "")
        
        return [movie1, movie2]
    }
}
