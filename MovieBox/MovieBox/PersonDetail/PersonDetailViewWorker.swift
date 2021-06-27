//
//  PersonDetailViewWorker.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit
import Alamofire

protocol PersonDetailViewWorkerProtocol {
    func getPersonDetail(withPersonId id:Int,
                         completionHandler:@escaping (PersonDetailViewModel?, Error?) -> Void)
}

final class PersonDetailViewWorker {
    
    func getPersonDetail(withPersonId id:Int,
                         completionHandler:@escaping (PersonDetailViewModel?, Error?) -> Void) {
        
        let params: Parameters = [
            "api_key": Constants.apiKey
            ]
        
        AF.request(String(format: TransactionURL.getPersonDetail.urlString, String(id)),
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString)
            
            .responseDecodable(of: PersonDetailViewModel.self) { response in
                
                switch response.result {
                    case .success(let personDetailViewModel):
                        completionHandler(personDetailViewModel, nil)
                        
                    case .failure(let error):
                        completionHandler(nil, error)
                }
        }
    }
    
    func getPersonMovieCredits(withPersonId id:Int,
                         completionHandler:@escaping (PersonMovieCreditViewModel?, Error?) -> Void) {
        
        let params: Parameters = [
            "api_key": Constants.apiKey
            ]
        
        AF.request(String(format: TransactionURL.getPersonMovieCredit.urlString, String(id)),
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString)
            
            .responseDecodable(of: PersonMovieCreditViewModel.self) { response in
                
                switch response.result {
                    case .success(let personMovieCreditViewModel):
                        completionHandler(personMovieCreditViewModel, nil)
                        
                    case .failure(let error):
                        completionHandler(nil, error)
                }
        }
    }
}
