//
//  DashboardViewWorker.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit
import Alamofire

protocol DashboardViewWorkerProtocol {
    func getPopularMovies(forpage page:Int,
                          completionHandler:@escaping (() throws -> MovieListViewModel) -> Void)
    
    func searchMovies(forpage page:Int,
                      queryString: String?,
                      completionHandler:@escaping (MovieListViewModel?, Error?) -> Void)
    
    func searchPeople(forpage page:Int,
                      queryString: String?,
                      completionHandler:@escaping (PeopleListViewModel?, Error?) -> Void)
}

final class DashboardViewWorker {
    
    func getPopularMovies(forpage page:Int,
                          completionHandler:@escaping (MovieListViewModel?, Error?) -> Void) {
        
        let params: Parameters = [
            "api_key": Constants.apiKey,
            "page" : String(page)
            ]
        
        AF.request(TransactionURL.getPopularMovies.urlString,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString)
            
            .responseDecodable(of: MovieListViewModel.self) { response in
                
                switch response.result {
                    case .success(let movieListViewModel):
                        completionHandler(movieListViewModel, nil)
                        
                    case .failure(let error):
                        completionHandler(nil, error)
                }
        }
    }
    
    func searchMovies(forpage page:Int,
                      queryString: String?,
                      completionHandler:@escaping (MovieListViewModel?, Error?) -> Void) {
        
        let params: Parameters = [
            "api_key": Constants.apiKey,
            "page" : String(page),
            "query": queryString.stringValue
            ]
        
        AF.request(TransactionURL.searchMovies.urlString,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString)
            
            .responseDecodable(of: MovieListViewModel.self) { response in
                
                switch response.result {
                    case .success(let movieListViewModel):
                        completionHandler(movieListViewModel, nil)
                        
                    case .failure(let error):
                        completionHandler(nil, error)
                }
        }
    }
    
    func searchPeople(forpage page:Int,
                      queryString: String?,
                      completionHandler:@escaping (PeopleListViewModel?, Error?) -> Void) {
        
        let params: Parameters = [
            "api_key": Constants.apiKey,
            "page" : String(page),
            "query": queryString.stringValue
            ]
        
        AF.request(TransactionURL.searchPeople.urlString,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString)
            
            .responseDecodable(of: PeopleListViewModel.self) { response in
                
                switch response.result {
                    case .success(let peopleListViewModel):
                        completionHandler(peopleListViewModel, nil)
                        
                    case .failure(let error):
                        completionHandler(nil, error)
                }
        }
    }
}
