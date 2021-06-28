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
    
    static var movieDetail: MovieDetailViewModel {
        return MovieDetailViewModel(id: 604, title: "Life Is Beautiful", overview: "overview", averageVote: 0, genres: nil, video: nil, imageUrl: nil, imbdId: nil)
    }
    
    static var castMembers: CastMembersViewModel {
        let cast1 = CastMemberViewModel(id: 1, name: "Roberto Benigni", imageUrl: nil)
        return CastMembersViewModel(id: 1, cast: [cast1])
    }
    
    static var videoViewModel: VideoViewModel = VideoViewModel(results: [VideoModel(id: "1", name: "alo", key: "zalo")])
    
    static var movie: Movie = Movie(id: 1,
                                    title: "Moview 1",
                                    posterPath: "",
                                    releaseDate: "",
                                    averageVote: 8.2,
                                    genreIds: nil,
                                    genreString: "")
}
