//
//  PersonMockData.swift
//  MovieBoxTests
//
//  Created by Wolverin Mm on 28.06.2021.
//

import Foundation

enum PersonMockData {
    
    static var personList: [Person]  {
        
        let person1 = Person(id: 1,
                             name: "Önder",
                             imageUrl: nil,
                             knownForDepartment: nil)
        
        let person2 = Person(id: 2,
                             name: "Nilay",
                             imageUrl: nil,
                             knownForDepartment: nil)
        
        return [person1, person2]
    }
    
    static var personDetail: PersonDetailViewModel {
        
        return PersonDetailViewModel(id: 1,
                                     name: "Önder",
                                     biography: nil,
                                     birthday: nil,
                                     imageUrl: nil,
                                     knownForDepartment: nil)
    }
    
    static var personMovieCredit: PersonMovieCreditViewModel {
        
        return PersonMovieCreditViewModel(id: 1,
                                          cast: nil)
    }
}
