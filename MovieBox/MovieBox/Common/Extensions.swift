//
//  Extensions.swift
//  MovieBox
//
//  Created by Wolverin Mm on 26.06.2021.
//

import UIKit

public extension Optional where Wrapped == Int {
    
    var intValue: Int {
        return self ?? 0
    }
}

public extension Optional where Wrapped == String {
    
    var stringValue: String {
        return self ?? ""
    }
}
