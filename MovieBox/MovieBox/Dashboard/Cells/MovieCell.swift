//
//  MovieCell.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 26.06.2021.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
    var viewModel: Movie? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            DispatchQueue.main.async {
                let url = "https://image.tmdb.org/t/p/w500" +  viewModel.posterPath.stringValue
                self.imageView.sd_setImage(with: URL(string: url),
                                           placeholderImage: UIImage(named: "movie"))
            }
            
            titleLabel.text = viewModel.title
            releaseDateLabel.text = viewModel.releaseDate
            averageVoteLabel.text = (viewModel.averageVote?.description).stringValue + " ✭"
            genreLabel.text = viewModel.genreString
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontUtility.titleFont()
        label.textColor = ColorUtility.titleColor()
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontUtility.descriptionFont()
        label.textColor = ColorUtility.decriptionColor()
        return label
    }()
    
    private let averageVoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontUtility.voteFont()
        label.textColor = ColorUtility.appTopColor()
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontUtility.descriptionFont()
        label.textColor = ColorUtility.decriptionColor()
        label.numberOfLines = 0
        return label
    }()
    
    private let seperatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = ColorUtility.grayLight()
        return view
     }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    func configureCell(_ isLastItem: Bool) {
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.listedImageWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.listedImageHeight).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        if (viewModel?.releaseDate) != nil {
            addSubview(releaseDateLabel)
            releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3.3).isActive = true
            releaseDateLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
            releaseDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        }
        
        if (viewModel?.averageVote) != nil {
            addSubview(averageVoteLabel)
            averageVoteLabel.translatesAutoresizingMaskIntoConstraints = false
            averageVoteLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -43.3).isActive = true
            averageVoteLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
            averageVoteLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
            averageVoteLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        }
        
        if (viewModel?.genreString) != nil {
            addSubview(genreLabel)
            genreLabel.translatesAutoresizingMaskIntoConstraints = false
            genreLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
            genreLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
            genreLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
            genreLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        if !isLastItem {
            addSubview(seperatorView)
            seperatorView.translatesAutoresizingMaskIntoConstraints = false
            seperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            seperatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            seperatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            seperatorView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        } else {
            seperatorView.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
