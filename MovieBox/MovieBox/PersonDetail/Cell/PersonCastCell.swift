//
//  PersonCastCell.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit
import SDWebImage

class PersonCastCell: UICollectionViewCell {
    
    var viewModel: MovieCreditViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            DispatchQueue.main.async {
                let url = "https://image.tmdb.org/t/p/w500" +  viewModel.imageUrl.stringValue
                self.imageView.sd_setImage(with: URL(string: url),
                                           placeholderImage: UIImage(named: "avatar"))
            }
            
            nameLabel.text = viewModel.title
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
        label.font = FontUtility.castFont()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        contentView.backgroundColor = .clear
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.listedImageWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.listedImageHeight).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
