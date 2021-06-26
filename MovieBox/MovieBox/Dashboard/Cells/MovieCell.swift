//
//  MovieCell.swift
//  MovieBox
//
//  Created by Wolverin Mm on 26.06.2021.
//

import UIKit
import SDWebImage

struct CustomCellViewModel {
    let name: String
    let imageUrl: String
}

class MovieCell: UICollectionViewCell {
    
    var viewModel: CustomCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            DispatchQueue.main.async {
                let url = "https://image.tmdb.org/t/p/w500" +  viewModel.imageUrl
                self.imageView.sd_setImage(with: URL(string: url),
                                           placeholderImage: UIImage(named: "picture_placeholder"))
            }
            
            nameLabel.text = viewModel.name
        }
    }
    
    fileprivate let imageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
                iv.layer.cornerRadius = 12
        return iv
    }()
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
