//
//  AlertView.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 26.06.2021.
//

import Foundation
import SCLAlertView

class DialogBoxUtility {
    
    static let shared = DialogBoxUtility()
        
    init() { }
    
    class func showError(message: String) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Ok") {
            alertView.hideView()
        }
        alertView.showError("Error", subTitle: message)
    }
}
