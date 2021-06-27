//
//  SectionHeader.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
     
    let label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = FontUtility.sectionFont()
        label.textColor = ColorUtility.appTopColor()
        label.sizeToFit()
        label.backgroundColor = .clear
        return label
     }()

     override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        self.backgroundColor = ColorUtility.grayLight()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
