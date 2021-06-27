//
//  ActivityIndicatorCell.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 26.06.2021.
//

import UIKit

class ActivityIndicatorCell: UICollectionViewCell {
    
    private let indicatorView: UIActivityIndicatorView = {
       let view = UIActivityIndicatorView(style: .white)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(indicatorView)
        
        indicatorView.topAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        indicatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        indicatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        indicatorView.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
