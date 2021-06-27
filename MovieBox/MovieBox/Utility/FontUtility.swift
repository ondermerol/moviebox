//
//  FontUtility.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit


class FontUtility {
    
    static func sectionFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue-Medium", size: 20.0)
    }
    
    static func titleFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue-Medium", size: 16.0)
    }
    
    static func descriptionFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue-Light", size: 14.0)
    }
    
    static func voteFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue-Bold", size: 16.0)
    }
    
    static func castFont() -> UIFont? {
        return UIFont(name: "HelveticaNeue-Medium", size: 14.0)
    }
}
