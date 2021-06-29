//
//  VideoCell.swift
//  MovieBox
//
//  Created by Wolverin Mm on 28.06.2021.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    var viewModel: VideoCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            initView(with: viewModel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        let tintColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        iv.image = UIImage(named: "youtubePlayIcon")?.imageWithColor(tintColor: tintColor)
        return iv
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
        contentView.addSubview(imageView)
    }
    
    private func initView(with viewModel: VideoCellViewModel) {
        
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        titleLabel.text = "Tralier \(viewModel.index + 1)"
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
