//
//  MovieSummaryView.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import UIKit


class MovieSummaryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.8
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.text = "Synopsis"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    private let ratingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.isUserInteractionEnabled = false
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = Constants.Colors.goldColor
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    func configureView(with model: SummaryViewModel) {
        overviewLabel.text = model.overview
        ratingsButton.setTitle("\(  model.ratings)", for: .normal)
        let genre = model.genre.map { $0.name }.joined(separator: " ** ")
        genreLabel.text = "** \(genre) **"
    }
    
    private func setupSubviews() {
        addMultipleSub(views: [movieImage, containerView])
        movieImage.frame = CGRect(x: 20, y: 0, width: self.width-40, height: (self.height*0.6))
        containerView.frame = CGRect(x: 20, y: movieImage.bottom, width: self.width-40, height: (self.height*0.4))
        containerView.addMultipleSub(views: [titleLabel, ratingsButton, overviewLabel, genreLabel])
        
        let labelHeight: CGFloat = containerView.height*0.2
        titleLabel.frame = CGRect(x: 5, y: 10, width: containerView.width*0.5, height: labelHeight)
        ratingsButton.frame = CGRect(x: containerView.width-(containerView.width*0.25), y: 10, width: containerView.width*0.25, height: labelHeight)
        
        overviewLabel.frame = CGRect(x: 10, y: ratingsButton.bottom+10, width: containerView.width*0.95, height: containerView.height - (ratingsButton.bottom+labelHeight))
        genreLabel.frame = CGRect(x: 10, y: overviewLabel.bottom+5, width: containerView.width*0.95, height: labelHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
