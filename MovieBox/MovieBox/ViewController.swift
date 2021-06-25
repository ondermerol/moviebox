//
//  ViewController.swift
//  MovieBox
//
//  Created by Onder on 25.06.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPupularMovies()
        
        getMovieDetail(movieId: 581726)
        
        getPersonDetail(personId: 878)
    }

    private func getPupularMovies() {
        let url = "https://api.themoviedb.org/3/movie/popular/"
        let params: Parameters = [
            "api_key": "8c42cdf8179116388dd8fb6ca5a7046d",
            "page" : "1"
            ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.queryString)
            .responseDecodable(of: MovieList.self) { response in
                guard let movieList = response.value else {
                    return
                }
                
                print(movieList)
        }
    }
    
    private func getMovieDetail(movieId: Int) {
        let url = String(format:"%@%d", "https://api.themoviedb.org/3/movie/", movieId)
            
        let params: Parameters = [
            "api_key": "8c42cdf8179116388dd8fb6ca5a7046d"
            ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.queryString)
            .responseDecodable(of: Movie.self) { response in
                guard let movie = response.value else {
                    return
                }
                
                print(movie)
        }
    }
    
    private func getPersonDetail(personId: Int) {
        let url = String(format:"%@%d", "https://api.themoviedb.org/3/person/", personId)
            
        let params: Parameters = [
            "api_key": "8c42cdf8179116388dd8fb6ca5a7046d"
            ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.queryString)
            .responseDecodable(of: Person.self) { response in
                guard let person = response.value else {
                    return
                }
                
                print(person)
        }
    }
}

struct Person: Decodable {
    let id: Int
    let biography: String
    let alsoKnownAs: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case biography
        case alsoKnownAs = "also_known_as"
    }
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let descripton: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case descripton = "overview"
    }
}

struct MovieList: Decodable {
    let items: [Movie]
    let totalPages: Int
    let totalResults: Int
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case items = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page = "page"
    }
}

