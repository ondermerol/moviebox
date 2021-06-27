//
//  BiographyViewInteractor.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit

protocol BiographyViewDataStore {
    var name: String? { get set }
    var biographyText: String? { get set }
}

class BiographyViewInteractor:BiographyViewDataStore {
    
    var biographyText: String?
    var name: String?
}
