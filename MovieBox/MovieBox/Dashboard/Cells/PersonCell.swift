//
//  MovieCell.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 26.06.2021.
//

import UIKit
import SDWebImage

class PersonCell: UICollectionViewCell {
    
    var viewModel: Person? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            initView(with: viewModel)
        }
    }
    
    var isLast: Bool = false {
        didSet {
            
            if !isLast {
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
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontUtility.descriptionFont()
        label.textColor = ColorUtility.decriptionColor()
        return label
    }()
    
    private let seperatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = ColorUtility.grayLight()
        return view
     }()
    
    private func initView(with viewModel: Person) {
        
        DispatchQueue.main.async {
            let url = Constants.imagePrefixURL +  viewModel.imageUrl.stringValue
            self.imageView.sd_setImage(with: URL(string: url),
                                       placeholderImage: UIImage(named: "avatar"))
        }
        
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.knownForDepartment
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.listedImageWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.listedImageHeight).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        if (viewModel.knownForDepartment) != nil {
            addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 40).isActive = true
            descriptionLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
}
