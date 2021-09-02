//
//  CompaniesCollectionView.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import UIKit

class CompaniesCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setuSubviews()
    }
    
    private let companiesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    func configureCell(with model: Companies) {
        companyNameLabel.text = model.name
        guard let companyLogo = model.logoPath else { return }
        if let url = URL(string: Constants.Images.baseUrl.rawValue+companyLogo) {
            companiesImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private func setuSubviews() {
        addMultipleSub(views: [companiesImageView, companyNameLabel])
        let itemHeight: CGFloat = contentView.height*0.6
        companiesImageView.layer.cornerRadius = itemHeight/2
        companiesImageView.frame = CGRect(x: 5, y: 0, width: itemHeight, height: itemHeight)
        companyNameLabel.frame = CGRect(x: 5, y: companiesImageView.bottom, width: self.width*0.8, height: self.height - companiesImageView.bottom+5)
        
    }
}
