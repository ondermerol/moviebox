//
//  TableView+Extension.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 26.06.2021.
//

import UIKit

extension UICollectionView {
    
    func setEmptyMessage(message: String) {
        let epmtyStateview = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: self.bounds.size.width,
                                                  height: self.bounds.size.height))
        
        let messageLabel = UILabel(frame: .zero)
        messageLabel.text = message
        messageLabel.textColor = ColorUtility.titleColor()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20.0)
        messageLabel.sizeToFit()
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        epmtyStateview.addSubview(messageLabel)
        
        messageLabel.topAnchor.constraint(equalTo: epmtyStateview.topAnchor, constant: 40).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: epmtyStateview.centerXAnchor).isActive = true
        self.backgroundView = epmtyStateview
    }

    func restore() {
        self.backgroundView = nil
    }
}
