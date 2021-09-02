//
//  MovieListCollectionViewCell.swift
//  MovieLab
//
//  Created by King Bileygr on 8/31/21.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let frame = CGRect(x: 0, y: 0, width: contentView.width-30, height: contentView.height)
        Constants.setGradientBackground(view: movieImage, frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellSubviews()
    }
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        return imageView
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.font = UIFont(name: "Chalkduster", size: 22)
        label.textAlignment = .center
        return label
    }()
    
    public func configureCell(with model: MovieListViewModel) {
        movieTitle.text = model.movieTitle
        let stringUrl = Constants.Images.baseUrl.rawValue+model.backdropPath
        if let url = URL(string: stringUrl) {
        movieImage.sd_setImage(with: url, completed: nil)
        }
    }
    
    private func setupCellSubviews() {
        contentView.addSubview(movieImage)
        movieImage.frame = CGRect(x: 20, y: 0, width: contentView.width-30, height: contentView.height)

        movieImage.addSubview(movieTitle)
        movieTitle.frame = CGRect(x: 20, y: movieImage.bottom-(movieImage.height*0.3), width: movieImage.width-40, height: movieImage.height*0.3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
