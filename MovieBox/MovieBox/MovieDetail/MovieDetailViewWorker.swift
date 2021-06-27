//
//  MovieDetailViewWorker.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit
import Alamofire

protocol MovieDetailViewWorkerProtocol {
    func getMovieDetail(withMovieId id:Int,
                         completionHandler:@escaping (MovieDetailViewModel?, Error?) -> Void)
}

final class MovieDetailViewWorker {
    
    func getMovieDetail(withMovieId id:Int,
                        completionHandler:@escaping (MovieDetailViewModel?, Error?) -> Void) {
        
        let params: Parameters = [
            "api_key": Constants.apiKey
            ]
        
        AF.request(String(format: TransactionURL.getMovieDetail.urlString, String(id)),
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString)
            
            .responseDecodable(of: MovieDetailViewModel.self) { response in
                
                switch response.result {
                    case .success(let movieDetailViewModel):
                        completionHandler(movieDetailViewModel, nil)
                        
                    case .failure(let error):
                        completionHandler(nil, error)
                }
        }
    }
    
    func getMovieCastMembers(withMovieId id:Int,
                             completionHandler:@escaping (CastMembersViewModel?, Error?) -> Void) {
        
        let params: Parameters = [
            "api_key": Constants.apiKey
            ]
        
        AF.request(String(format: TransactionURL.getMovieCastMembers.urlString, String(id)),
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString)
            
            .responseDecodable(of: CastMembersViewModel.self) { response in
                
                switch response.result {
                    case .success(let castMembersViewModel):
                        completionHandler(castMembersViewModel, nil)
                        
                    case .failure(let error):
                        completionHandler(nil, error)
                }
        }
    }
}
