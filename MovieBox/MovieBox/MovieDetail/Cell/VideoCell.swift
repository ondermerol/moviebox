//
//  VideoCell.swift
//  MovieBox
//
//  Created by Wolverin Mm on 28.06.2021.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    var videoUrl: String?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontUtility.titleFont()
        label.textColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    private let view: UIView = {
        let iv = UIView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.backgroundColor = UIColor(red: 38.0/255.0, green: 38.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(view)
        contentView.addSubview(titleLabel)
    }
    
    func configure(_ index: Int) {
        
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        titleLabel.text = "Tralier \(index + 1)"
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
