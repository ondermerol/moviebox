//
//  TableView+Extension.swift
//  MovieBox
//
//  Created by Wolverin Mm on 26.06.2021.
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
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        epmtyStateview.addSubview(messageLabel)
        
        messageLabel.centerYAnchor.constraint(equalTo: epmtyStateview.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: epmtyStateview.centerXAnchor).isActive = true
        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}
