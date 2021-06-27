//
//  MovieCastCell.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit
import SDWebImage

class MovieCastCell: UICollectionViewCell {
    
    var viewModel: CastMemberViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            DispatchQueue.main.async {
                let url = "https://image.tmdb.org/t/p/w500" +  viewModel.imageUrl.stringValue
                self.imageView.sd_setImage(with: URL(string: url),
                                           placeholderImage: UIImage(named: "avatar"))
            }
            
            nameLabel.text = viewModel.name
        }
    }
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        contentView.backgroundColor = .yellow
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
